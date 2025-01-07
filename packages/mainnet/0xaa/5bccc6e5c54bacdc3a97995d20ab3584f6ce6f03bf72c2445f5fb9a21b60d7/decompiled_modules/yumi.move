module 0xaa5bccc6e5c54bacdc3a97995d20ab3584f6ce6f03bf72c2445f5fb9a21b60d7::yumi {
    struct YUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUMI>(arg0, 6, b"YUMI", b"Yumi", b"The cutest dog on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIG_3_7f1d9c4687.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

