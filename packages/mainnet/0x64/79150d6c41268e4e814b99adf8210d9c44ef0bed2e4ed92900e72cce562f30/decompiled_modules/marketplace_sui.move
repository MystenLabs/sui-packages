module 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_sui {
    struct ItemListed<phantom T0> has copy, drop {
        kiosk: 0x2::object::ID,
        id: 0x2::object::ID,
        coin: vector<u8>,
        price: u64,
    }

    struct ItemDelisted<phantom T0> has copy, drop {
        kiosk: 0x2::object::ID,
        id: 0x2::object::ID,
    }

    struct ItemPurchased<phantom T0> has copy, drop {
        kiosk: 0x2::object::ID,
        id: 0x2::object::ID,
        coin: vector<u8>,
        price: u64,
        buyer: address,
    }

    public fun delist<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) {
        assert!(0x2::kiosk::is_listed(arg0, arg2), 13906834457811222529);
        0x2::kiosk::delist<T0>(arg0, arg1, arg2);
        let v0 = ItemDelisted<T0>{
            kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            id    : arg2,
        };
        0x2::event::emit<ItemDelisted<T0>>(v0);
    }

    public fun list<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        assert!(!0x2::kiosk::is_listed(arg0, arg2), 13906834384796909571);
        0x2::kiosk::list<T0>(arg0, arg1, arg2, arg3);
        let v0 = ItemListed<T0>{
            kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            id    : arg2,
            coin  : 0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::token_sui(),
            price : arg3,
        };
        0x2::event::emit<ItemListed<T0>>(v0);
    }

    public fun purchase<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let (v0, v1) = 0x2::kiosk::purchase<T0>(arg0, arg1, arg3);
        let v2 = ItemPurchased<T0>{
            kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            id    : arg1,
            coin  : 0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::token_sui(),
            price : arg2,
            buyer : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ItemPurchased<T0>>(v2);
        (v0, v1)
    }

    public fun withdraw(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::kiosk::withdraw(arg0, arg1, 0x1::option::none<u64>(), arg2)
    }

    // decompiled from Move bytecode v6
}

