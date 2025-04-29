module 0x4f83f1cd85aefd0254e5b6f93bd344f49dd434269af698998dd5f4baec612898::choir {
    struct CHOIR has drop {
        dummy_field: bool,
    }

    struct TreasuryCapability has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<CHOIR>,
        total_minted: u64,
    }

    public fun mint(arg0: &mut TreasuryCapability, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.total_minted + arg1 <= 10000000000000000000, 0);
        arg0.total_minted = arg0.total_minted + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<CHOIR>>(0x2::coin::mint<CHOIR>(&mut arg0.cap, arg1, arg3), arg2);
    }

    fun init(arg0: CHOIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOIR>(arg0, 9, b"CHOIR", b"Choir", b"Token for collective intelligence", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = TreasuryCapability{
            id           : 0x2::object::new(arg1),
            cap          : v0,
            total_minted : 0,
        };
        0x2::transfer::transfer<TreasuryCapability>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHOIR>>(v1);
    }

    public fun total_minted(arg0: &TreasuryCapability) : u64 {
        arg0.total_minted
    }

    // decompiled from Move bytecode v6
}

