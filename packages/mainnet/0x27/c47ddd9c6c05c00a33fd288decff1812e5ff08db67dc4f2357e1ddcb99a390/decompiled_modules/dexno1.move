module 0x27c47ddd9c6c05c00a33fd288decff1812e5ff08db67dc4f2357e1ddcb99a390::dexno1 {
    struct DEXNO1 has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SaleConfig has store, key {
        id: 0x2::object::UID,
        rate: u64,
        admin_wallet: address,
    }

    public entry fun buy_token(arg0: &SaleConfig, arg1: &mut 0x2::coin::TreasuryCap<DEXNO1>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.admin_wallet);
        0x2::coin::mint_and_transfer<DEXNO1>(arg1, 0x2::coin::value<0x2::sui::SUI>(&arg2) * arg0.rate, 0x2::tx_context::sender(arg3), arg3);
    }

    fun init(arg0: DEXNO1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEXNO1>(arg0, 9, b"DEXNO1", b"Dexcoin top 1 Sui", b"Dexcoin top 1 Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/6QhChHF0/dexcoin.png")), arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = SaleConfig{
            id           : 0x2::object::new(arg1),
            rate         : 100,
            admin_wallet : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEXNO1>>(v1);
        0x2::transfer::public_share_object<SaleConfig>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEXNO1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

