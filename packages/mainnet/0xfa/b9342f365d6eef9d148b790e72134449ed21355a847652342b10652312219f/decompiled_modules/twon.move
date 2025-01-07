module 0xfab9342f365d6eef9d148b790e72134449ed21355a847652342b10652312219f::twon {
    struct TWON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWON>(arg0, 6, b"Twon", b"Trumpwon", b"Trumpwon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4241_dc6a2cd962.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWON>>(v1);
    }

    // decompiled from Move bytecode v6
}

