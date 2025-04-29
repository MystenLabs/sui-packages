module 0xc1ed3c14de424e38dd542cb7a00a1056e61196a2688b81aea347759fc0f6d1cc::fiqfr3e {
    struct FIQFR3E has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIQFR3E, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIQFR3E>(arg0, 9, b"Fiqfr3e", b"vikrfi", b"Ffqew", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fbde58054b2ca3d5b282523f1a286465blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIQFR3E>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIQFR3E>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

