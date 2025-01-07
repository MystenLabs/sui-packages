module 0x9a84b6a7914aedd6741e73cc2ca23cbc77e22ed3c5f884c072a51868fedde45b::hyperspace {
    struct Marketplace has store {
        storage: 0x2::bag::Bag,
        transfer_policy_id: 0x2::object::ID,
    }

    struct Extension<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ItemListed<phantom T0, phantom T1> has copy, drop {
        kiosk: 0x2::object::ID,
        id: 0x2::object::ID,
        price: u64,
    }

    struct ItemDelisted<phantom T0, phantom T1> has copy, drop {
        kiosk: 0x2::object::ID,
        id: 0x2::object::ID,
    }

    struct ItemPurchased<phantom T0: store + key> has copy, drop {
        kiosk: 0x2::object::ID,
        id: 0x2::object::ID,
        price: u64,
    }

    struct HYPERSPACE has drop {
        dummy_field: bool,
    }

    struct Hyperspace has store, key {
        id: 0x2::object::UID,
    }

    public fun delist<T0: store + key, T1: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) {
        let v0 = storage_mut<T1>(arg0);
        0x2::kiosk::return_purchase_cap<T0>(arg0, 0x2::bag::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(v0, arg2));
        let v1 = ItemDelisted<T0, T1>{
            kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            id    : arg2,
        };
        0x2::event::emit<ItemDelisted<T0, T1>>(v1);
    }

    fun init(arg0: HYPERSPACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<HYPERSPACE>(arg0, arg1);
        let (v2, v3) = 0x2::transfer_policy::new<Hyperspace>(&v1, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Hyperspace>>(v3, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Hyperspace>>(v2);
    }

    public fun install<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Extension<T0>{dummy_field: false};
        let v1 = Marketplace{
            storage            : 0x2::bag::new(arg3),
            transfer_policy_id : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg2),
        };
        0x2::dynamic_field::add<Extension<T0>, Marketplace>(0x2::kiosk::uid_mut(arg0), v0, v1);
    }

    public fun list<T0: store + key, T1: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, arg3, arg4);
        let v1 = ItemListed<T0, T1>{
            kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            id    : arg2,
            price : arg3,
        };
        0x2::event::emit<ItemListed<T0, T1>>(v1);
        0x2::bag::add<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(storage_mut<T1>(arg0), arg2, v0);
    }

    public fun purchase<T0: store + key, T1: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>) : (T0, 0x2::transfer_policy::TransferRequest<T0>, 0x2::transfer_policy::TransferRequest<Hyperspace>, 0x2::transfer_policy::TransferRequest<T1>) {
        let v0 = storage_mut<T1>(arg0);
        let v1 = 0x2::bag::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(v0, arg1);
        let v2 = ItemPurchased<T0>{
            kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            id    : arg1,
            price : 0x2::coin::value<0x2::sui::SUI>(&arg2),
        };
        0x2::event::emit<ItemPurchased<T0>>(v2);
        let (v3, v4) = 0x2::kiosk::purchase_with_cap<T0>(arg0, v1, arg2);
        let v5 = v4;
        (v3, v5, 0x2::transfer_policy::new_request<Hyperspace>(arg1, 0x2::transfer_policy::paid<T0>(&v5), 0x2::transfer_policy::from<T0>(&v5)), 0x2::transfer_policy::new_request<T1>(arg1, 0x2::transfer_policy::paid<T0>(&v5), 0x2::transfer_policy::from<T0>(&v5)))
    }

    public fun purchase_silent<T0: store + key, T1: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: &mut 0x2::transfer_policy::TransferPolicy<Hyperspace>, arg5: &mut 0x2::transfer_policy::TransferPolicy<T1>, arg6: 0x2::object::ID, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        if (0x2::kiosk::is_listed(arg0, arg6)) {
            let v1 = storage_mut<T1>(arg0);
            let v2 = 0x2::bag::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(v1, arg6);
            let v3 = ItemPurchased<T0>{
                kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
                id    : arg6,
                price : 0x2::coin::value<0x2::sui::SUI>(&arg7),
            };
            0x2::event::emit<ItemPurchased<T0>>(v3);
            let (v4, v5) = 0x2::kiosk::purchase_with_cap<T0>(arg0, v2, arg7);
            let v6 = v5;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg8, v0);
            0x2::kiosk::place<T0>(arg1, arg2, v4);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v6);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg9, v0);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<Hyperspace>(arg4, 0x2::transfer_policy::new_request<Hyperspace>(arg6, 0x2::transfer_policy::paid<T0>(&v6), 0x2::transfer_policy::from<T0>(&v6)));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg10, v0);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T1>(arg5, 0x2::transfer_policy::new_request<T1>(arg6, 0x2::transfer_policy::paid<T0>(&v6), 0x2::transfer_policy::from<T0>(&v6)));
        } else {
            0x2::coin::join<0x2::sui::SUI>(&mut arg7, arg8);
            0x2::coin::join<0x2::sui::SUI>(&mut arg7, arg10);
            0x2::coin::join<0x2::sui::SUI>(&mut arg7, arg9);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, v0);
        };
    }

    fun storage_mut<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk) : &mut 0x2::bag::Bag {
        let v0 = Extension<T0>{dummy_field: false};
        &mut 0x2::dynamic_field::borrow_mut<Extension<T0>, Marketplace>(0x2::kiosk::uid_mut(arg0), v0).storage
    }

    // decompiled from Move bytecode v6
}

