module 0xb73c5cd6403c6595269532676e8a5c7767b8b4d2d5d419c1d4f45e110d135990::wowrd {
    struct WOWRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOWRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOWRD>(arg0, 9, b"WOWRD", b"Wow", b"new mem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8dab2d271cdf1197bcd19f874151abb1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOWRD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOWRD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

