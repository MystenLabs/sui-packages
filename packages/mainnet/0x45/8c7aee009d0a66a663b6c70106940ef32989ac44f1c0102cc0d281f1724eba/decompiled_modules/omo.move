module 0x458c7aee009d0a66a663b6c70106940ef32989ac44f1c0102cc0d281f1724eba::omo {
    struct OMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMO>(arg0, 6, b"OMO", b"omo", b"DAO Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/artifact_b8921679ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

