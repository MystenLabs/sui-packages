module 0x7f70feca0548f1f59cf1b3744456979cc5ac7208ea51a3abbf5b0c9dcdeb0cdc::marketplace_ext {
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

    public fun install<T0: drop>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Extension<T0>{dummy_field: false};
        let v1 = Marketplace{
            storage            : 0x2::bag::new(arg3),
            transfer_policy_id : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg2),
        };
        0x2::dynamic_field::add<Extension<T0>, Marketplace>(0x2::kiosk::uid_mut(arg0), v0, v1);
    }

    public fun list<T0: store + key, T1: drop>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, arg3, arg4);
        let v1 = ItemListed<T0, T1>{
            kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            id    : arg2,
            price : arg3,
        };
        0x2::event::emit<ItemListed<T0, T1>>(v1);
        0x2::bag::add<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(storage_mut<T1>(arg0), arg2, v0);
    }

    public fun purchase<T0: store + key, T1: drop>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>) : (T0, 0x2::transfer_policy::TransferRequest<T0>, 0x2::transfer_policy::TransferRequest<T1>) {
        let v0 = storage_mut<T1>(arg0);
        let (v1, v2) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::bag::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(v0, arg1), arg2);
        let v3 = v2;
        (v1, v3, 0x2::transfer_policy::new_request<T1>(arg1, 0x2::transfer_policy::paid<T0>(&v3), 0x2::transfer_policy::from<T0>(&v3)))
    }

    fun storage_mut<T0: drop>(arg0: &mut 0x2::kiosk::Kiosk) : &mut 0x2::bag::Bag {
        let v0 = Extension<T0>{dummy_field: false};
        &mut 0x2::dynamic_field::borrow_mut<Extension<T0>, Marketplace>(0x2::kiosk::uid_mut(arg0), v0).storage
    }

    // decompiled from Move bytecode v6
}

