module 0xee7c5374fe8de6e31637705cccbe89607d59ac30d5c788717f3335cce48e0741::stt {
    struct STT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STT>(arg0, 9, b"STT", b"SEA TURTLE", b"SAVE THE SEA TURTLES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c956b6b1d34bf0fd69066843b6ee8273blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

