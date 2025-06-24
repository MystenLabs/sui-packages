module 0xabfa2d5e1d0d75779a8f33bd7415d6fc348416dd028cb0e8156c4d8496e4ab::nne {
    struct NNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNE>(arg0, 9, b"NNe", b"miyopi", b"goof", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/90be3e6509678971987e39bc08311ad6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

