module 0x7f485a11dd9d12d6daa7c2edfa9ef8ad941e47a2bbfafed35578d1c58c6c74e::suiii {
    struct SUIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIII>(arg0, 6, b"SUIII", b"Suinaldo", b"SIUUUU *ahem* SUIIIIIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4156_f193a959e1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

