module 0x22c04923147996f9deb088a81c5ca538f2e0ad8da7343a9c22c5411b31ec4ea7::smoji {
    struct SMOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOJI>(arg0, 6, b"SMOJI", b"SUIMOJI", b"this is the emoji of a fish ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fish_b6d7596b0e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

