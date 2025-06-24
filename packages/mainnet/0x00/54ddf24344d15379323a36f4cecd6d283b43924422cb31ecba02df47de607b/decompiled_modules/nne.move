module 0x54ddf24344d15379323a36f4cecd6d283b43924422cb31ecba02df47de607b::nne {
    struct NNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNE>(arg0, 9, b"NNe", b"miyiip", b"goof", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/252a009111a1c353b44f76f4c4f0e523blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

