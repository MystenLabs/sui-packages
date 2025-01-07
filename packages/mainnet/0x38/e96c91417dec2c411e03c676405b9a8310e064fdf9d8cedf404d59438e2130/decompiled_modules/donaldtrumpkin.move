module 0x38e96c91417dec2c411e03c676405b9a8310e064fdf9d8cedf404d59438e2130::donaldtrumpkin {
    struct DONALDTRUMPKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONALDTRUMPKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONALDTRUMPKIN>(arg0, 6, b"DONALDTRUMPKIN", b"Donald Trumpkin", b"Donald Trumpkin ready for halloween ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031390_8428e60b85.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONALDTRUMPKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONALDTRUMPKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

