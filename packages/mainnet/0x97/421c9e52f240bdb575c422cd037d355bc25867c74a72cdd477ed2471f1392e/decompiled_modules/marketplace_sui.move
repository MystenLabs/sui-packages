module 0x97421c9e52f240bdb575c422cd037d355bc25867c74a72cdd477ed2471f1392e::marketplace_sui {
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
            coin  : 0x45f7707bfcb8a6135490324e20abc2b80a326df1f4bc86da2cff5da0d2eb7abe::config::token_sui(),
            price : arg3,
        };
        0x2::event::emit<ItemListed<T0>>(v0);
    }

    public fun purchase<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let (v0, v1) = 0x2::kiosk::purchase<T0>(arg0, arg1, arg3);
        let v2 = ItemPurchased<T0>{
            kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            id    : arg1,
            coin  : 0x45f7707bfcb8a6135490324e20abc2b80a326df1f4bc86da2cff5da0d2eb7abe::config::token_sui(),
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

