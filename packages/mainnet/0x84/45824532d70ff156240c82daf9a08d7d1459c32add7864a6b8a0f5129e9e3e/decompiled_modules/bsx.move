module 0x8445824532d70ff156240c82daf9a08d7d1459c32add7864a6b8a0f5129e9e3e::bsx {
    struct BSX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSX>(arg0, 6, b"BSX", b"BabySUIREX", b"Something big and blue is coming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zi_Bh_VL_Wc_As_ZSTS_138af3389b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSX>>(v1);
    }

    // decompiled from Move bytecode v6
}

