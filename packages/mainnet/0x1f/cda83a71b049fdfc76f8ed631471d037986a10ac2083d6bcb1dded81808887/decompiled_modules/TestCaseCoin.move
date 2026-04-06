module 0x79640821abd61d507bd8f197757faa8310bee8d514cce2bd50688527f8120ff3::TestCaseCoin {
    struct TESTCASECOIN has drop {
        dummy_field: bool,
    }

    struct CapGraveyard has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<TESTCASECOIN>,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTCASECOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTCASECOIN>>(0x2::coin::mint<TESTCASECOIN>(arg0, arg1, arg3), arg2);
    }

    public entry fun bury_cap(arg0: 0x2::coin::TreasuryCap<TESTCASECOIN>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CapGraveyard{
            id  : 0x2::object::new(arg1),
            cap : arg0,
        };
        0x2::transfer::public_share_object<CapGraveyard>(v0);
    }

    public entry fun exhume_and_freeze_cap(arg0: CapGraveyard) {
        let CapGraveyard {
            id  : v0,
            cap : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTCASECOIN>>(v1);
    }

    fun init(arg0: TESTCASECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCASECOIN>(arg0, 9, b"SRM", b"SuiRewards.Me", b"It's time you got a piece!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeif5r3biiwsylqsjkkwh4yrsbltbeetq5w3snuodcw56b7iaaglxoa.ipfs.w3s.link/logo_blk.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTCASECOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCASECOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

