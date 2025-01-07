module 0x69123edaf7ae907ad66b7094c76aeeccac01265756ddaf0c201ffc9c8462b6dd::omgsui {
    struct OMGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMGSUI>(arg0, 9, b"OMGSUI", b"OMG SP", b"OMG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e2edfbc5ce70701df4330fdec2a6dea8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OMGSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMGSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

