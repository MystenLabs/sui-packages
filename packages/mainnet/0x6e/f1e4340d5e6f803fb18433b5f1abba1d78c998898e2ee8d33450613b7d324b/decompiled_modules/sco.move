module 0x6ef1e4340d5e6f803fb18433b5f1abba1d78c998898e2ee8d33450613b7d324b::sco {
    struct SCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCO>(arg0, 9, b"SCO", b"sui cloud", b"sui cloud is cloud type and love apple, sui cloud love art too.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/afbb3091b27b374831b0c890cabc27f4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

