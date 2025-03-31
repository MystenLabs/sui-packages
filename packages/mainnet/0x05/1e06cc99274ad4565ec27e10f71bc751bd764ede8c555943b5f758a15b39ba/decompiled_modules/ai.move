module 0x51e06cc99274ad4565ec27e10f71bc751bd764ede8c555943b5f758a15b39ba::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI>(arg0, 9, b"AI", b"AI9999", b"AI9999", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/31976150-0e12-11f0-b9d7-f53a460d3d28")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AI>>(v1);
        0x2::coin::mint_and_transfer<AI>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

