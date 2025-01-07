module 0xfacf3378ea8526174d4955e1db38c65d9744b98820344821390029f842dc540a::tnb {
    struct TNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNB>(arg0, 6, b"TNB", b"Test no buy", b"nobuy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F_Zo_Wcx_WVUAIAGDF_3e3abc6e69.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

