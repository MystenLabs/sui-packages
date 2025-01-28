module 0x8b419bcbd3022b4931d9c569e71bbe4f7e6f9da52077f22cc2a0b67dc2e80b1c::haha {
    struct HAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHA>(arg0, 6, b"HAHA", b"HAHA", b"HAHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/94b0b6b0-dd61-11ef-a403-694c756e712a")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAHA>>(v1);
        0x2::coin::mint_and_transfer<HAHA>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

