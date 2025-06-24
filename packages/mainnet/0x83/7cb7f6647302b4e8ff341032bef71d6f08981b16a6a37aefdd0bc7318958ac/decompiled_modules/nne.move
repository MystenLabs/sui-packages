module 0x837cb7f6647302b4e8ff341032bef71d6f08981b16a6a37aefdd0bc7318958ac::nne {
    struct NNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNE>(arg0, 9, b"NNe", b"miy", b"goof", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4d2127668ef1ae4a9c80371fab093235blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

