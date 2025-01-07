module 0x27475fb8854457354f05279e56a3febdf79f271ded0885499abc0d09545c47d8::gkey {
    struct GKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GKEY>(arg0, 9, b"GKey", b"KEY of Glory ", b"Key of Glory", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/11c7ccb293d54e28e73f38cc8bb3e943blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GKEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GKEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

