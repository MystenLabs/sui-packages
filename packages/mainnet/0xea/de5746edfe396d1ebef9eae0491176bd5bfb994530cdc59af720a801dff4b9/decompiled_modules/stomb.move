module 0xeade5746edfe396d1ebef9eae0491176bd5bfb994530cdc59af720a801dff4b9::stomb {
    struct STOMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STOMB>(arg0, 6, b"STOMB", b"SUITOMB", b"Tomb token is a foundation that the ecosystem by tomb.finance is going to be build around", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w_GNE_5_Yd_W_400x400_598747188f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STOMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

