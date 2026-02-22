import Foundation
import SwiftUI

// --- ÉNUMÉRATIONS ---
// Définit les catégories pour le menu déroulant et le tri
enum FoodCategory: String, CaseIterable, Codable {
    case fruits, legumes, viandes, laitages, surgeles, boissons, epicerie, divers
}

// --- STRUCTURE PRINCIPALE ---
// La structure Aliment est le cœur de ton application
// Elle utilise 'Equatable' pour permettre les animations fluides dans la liste
struct Aliment: Identifiable, Codable, Equatable {
    var id = UUID()
    var nom: String
    var quantite: Int
    var datePeremption: Date
    var categorie: FoodCategory
    
    // Ajout de propriétés pour les versions esthétiques avancées
    var calories: Int = 0
    var prix: Double = 0.0
    var poids: Double = 0.0
    var estOuvert: Bool = false
    var addedDate: Date = Date()
    var notePersonnelle: String = ""
    
    // Fonction de comparaison indispensable pour corriger l'erreur 'Equatable'
    static func == (lhs: Aliment, rhs: Aliment) -> Bool {
        return lhs.id == rhs.id && 
               lhs.quantite == rhs.quantite && 
               lhs.nom == rhs.nom
    }
    
    // Calcul automatique des jours restants avant péremption
    var joursRestants: Int {
        let calendar = Calendar.current
        let aujourdhui = calendar.startOfDay(for: Date())
        let echeance = calendar.startOfDay(for: datePeremption)
        let composants = calendar.dateComponents([.day], from: aujourdhui, to: echeance)
        return composants.day ?? 0
    }
    
    // Détermine si le produit est dans la zone critique (3 jours ou moins)
    var estUrgent: Bool {
        return joursRestants <= 3
    }
}
