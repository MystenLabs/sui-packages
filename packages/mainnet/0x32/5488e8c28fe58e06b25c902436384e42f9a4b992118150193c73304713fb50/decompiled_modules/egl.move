module 0x325488e8c28fe58e06b25c902436384e42f9a4b992118150193c73304713fb50::egl {
    struct EGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGL>(arg0, 9, b"EGL", b"EAGLE", b"Eagles fly high", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/524100326afdbea191fe700104903800blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

