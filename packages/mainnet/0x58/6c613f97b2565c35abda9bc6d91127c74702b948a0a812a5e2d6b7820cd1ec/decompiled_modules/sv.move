module 0x586c613f97b2565c35abda9bc6d91127c74702b948a0a812a5e2d6b7820cd1ec::sv {
    struct SV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SV>(arg0, 9, b"SV", b"Sova", b"Sova bird", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/01b842ca79b997c7c0e6dde2750de61fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

