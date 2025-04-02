module 0xc0b3f5aa0f1f26d22d9d03d48b69782176c4741e2ddf13be685b59156e91183b::voviet {
    struct VOVIET has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOVIET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOVIET>(arg0, 9, b"Voviet", b"Avengers1", b"love team", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/57184742b868da57443f1b494e56b5e7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOVIET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOVIET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

