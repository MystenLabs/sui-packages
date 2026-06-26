module 0x7ae454ddee04d24634981df08a856927dfd28b0ca5f28aea5dcb06fcb6913a85::babank {
    struct BABANK has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct BabankRegistry has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<BABANK>,
        total_minted: u64,
        max_supply: u64,
    }

    fun init(arg0: BABANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABANK>(arg0, 6, b"BABANK", b"Babank", b"The official Babank token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/2O9mRzT.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABANK>>(v1);
        let v3 = 0x2::tx_context::sender(arg1);
        let v4 = 200000000000000000 + 150000000000000000 + 100000000000000000 + 50000000000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<BABANK>>(0x2::coin::mint<BABANK>(&mut v2, v4, arg1), v3);
        let v5 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v5, v3);
        let v6 = BabankRegistry{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
            total_minted : v4,
            max_supply   : 1000000000000000000,
        };
        0x2::transfer::share_object<BabankRegistry>(v6);
    }

    public entry fun mint_rewards(arg0: &AdminCap, arg1: &mut BabankRegistry, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.total_minted + arg2 <= arg1.max_supply, 0);
        arg1.total_minted = arg1.total_minted + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<BABANK>>(0x2::coin::mint<BABANK>(&mut arg1.treasury_cap, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v7
}

