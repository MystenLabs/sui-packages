module 0xcd3a8c25ffc94b4bba994af965a02c56cff6d887baee9f5168fbd77b12b890f3::trt {
    struct TRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRT>(arg0, 6, b"TRT", b"Trust", b"TrUsT tOkEn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_D_D_D_D_N_116f244f9c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

