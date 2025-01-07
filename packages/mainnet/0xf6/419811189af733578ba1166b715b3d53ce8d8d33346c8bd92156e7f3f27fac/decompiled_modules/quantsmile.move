module 0xf6419811189af733578ba1166b715b3d53ce8d8d33346c8bd92156e7f3f27fac::quantsmile {
    struct QUANTSMILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANTSMILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANTSMILE>(arg0, 6, b"QUANTSMILE", b"QUANT SMILE", b"Always smile!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gc0ap_Djbk_AA_Ocf_K_bf506ea260.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANTSMILE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUANTSMILE>>(v1);
    }

    // decompiled from Move bytecode v6
}

