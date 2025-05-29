module 0x832c7468b8a8726e6d47283719409f5b7adecec75015d17f92fd3857e09906e::lofibaby {
    struct LOFIBABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFIBABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOFIBABY>(arg0, 6, b"LOFIBABY", b"Lofi baby", b"Memecoin about Lofi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748508749611.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOFIBABY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFIBABY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

