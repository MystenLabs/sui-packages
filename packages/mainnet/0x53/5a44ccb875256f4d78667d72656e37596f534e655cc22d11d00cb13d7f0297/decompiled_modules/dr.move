module 0x535a44ccb875256f4d78667d72656e37596f534e655cc22d11d00cb13d7f0297::dr {
    struct DR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DR>(arg0, 9, b"DR", b"Drippo", x"f09f92a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/16a44e81ba22008b69f8e7a157aebfa9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

