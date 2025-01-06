module 0x930ddc07b38771a3288712c82cfee81d4b8a6cd80144a3f12a46ed4bf35a1f12::bbb {
    struct BBB has drop {
        dummy_field: bool,
    }

    struct Burner has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<BBB>,
    }

    fun init(arg0: BBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBB>(arg0, 9, b"HAHAHA", b"Testing BBB Token", b"AA BBB CCCCC", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BBB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BBB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

