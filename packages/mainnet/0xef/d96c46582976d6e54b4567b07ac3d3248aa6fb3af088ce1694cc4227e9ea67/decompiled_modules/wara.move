module 0xefd96c46582976d6e54b4567b07ac3d3248aa6fb3af088ce1694cc4227e9ea67::wara {
    struct WARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARA>(arg0, 6, b"WARA", b"wara", b"sui alpha degen, my pronouns: max/bet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wara_025e54e32b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

