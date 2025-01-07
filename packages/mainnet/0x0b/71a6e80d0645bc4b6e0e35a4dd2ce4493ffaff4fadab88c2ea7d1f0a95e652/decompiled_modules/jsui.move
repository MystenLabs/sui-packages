module 0xb71a6e80d0645bc4b6e0e35a4dd2ce4493ffaff4fadab88c2ea7d1f0a95e652::jsui {
    struct JSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JSUI>(arg0, 9, b"JSUI", b"JeSUI", x"4a652073756973205355492e0a4920616d205355490a536f79205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b662143759dd45fade1a7534894e0869blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

