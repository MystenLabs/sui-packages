module 0xc15757e78b8fa01fa92db62e33d0d74f6d57b1dd23c64e6953ac582437370e7::pkl {
    struct PKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKL>(arg0, 6, b"PKL", b"PINK FFF", b"123432423", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/448300731_486669777270265_809316766956183801_n_0e17c9e173.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

