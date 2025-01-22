module 0x57e8ce9227f83bf79c2ba93c445963e90f82bdb751995ad07c668dcb735582fc::barron {
    struct BARRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARRON>(arg0, 9, b"barron", b"BARRON TRUMP", b"OFFICIAL TOKEN BARRON TRUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.app.goo.gl/miAX4m7GNSkpNEq59")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BARRON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

