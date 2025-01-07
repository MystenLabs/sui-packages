module 0xed6cf653c7d01894e6e3be699c4427f6e161448c5a294b40dad72ab64f249638::size {
    struct SIZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIZE>(arg0, 6, b"SIZE", b"Size poker", b"The first poker platform on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038941_aeefac04dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

