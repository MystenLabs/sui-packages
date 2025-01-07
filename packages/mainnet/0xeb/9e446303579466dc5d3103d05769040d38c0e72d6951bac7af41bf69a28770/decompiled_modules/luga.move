module 0xeb9e446303579466dc5d3103d05769040d38c0e72d6951bac7af41bf69a28770::luga {
    struct LUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUGA>(arg0, 6, b"LUGA", b"Luga", x"2068616c6c6f200a697420612062656c756761207768616c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Luga_1754729c86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

