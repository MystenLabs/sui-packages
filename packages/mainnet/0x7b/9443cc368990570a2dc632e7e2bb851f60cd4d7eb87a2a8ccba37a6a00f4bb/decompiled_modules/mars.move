module 0x7b9443cc368990570a2dc632e7e2bb851f60cd4d7eb87a2a8ccba37a6a00f4bb::mars {
    struct MARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARS>(arg0, 9, b"MARS", b"mars", b"To Mars.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1498674368179752961/pxpja-GA_400x400.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MARS>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

