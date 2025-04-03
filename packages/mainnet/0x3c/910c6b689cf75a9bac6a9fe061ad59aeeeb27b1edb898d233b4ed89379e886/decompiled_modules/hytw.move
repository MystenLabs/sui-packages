module 0x3c910c6b689cf75a9bac6a9fe061ad59aeeeb27b1edb898d233b4ed89379e886::hytw {
    struct HYTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYTW>(arg0, 9, b"HYTW", b"jt7yj", b"jytwj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fffe31524fc7a0a52a7250bc62c01b01blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYTW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYTW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

