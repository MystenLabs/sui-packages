module 0xb7d5d39a9c7e06ee408debb418bd4c44177de33290b333a1b647e4e2dc646dbe::wtfmew {
    struct WTFMEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTFMEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTFMEW>(arg0, 9, b"WTFMEW", b"WTF-MEW", b"mew", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/7319a43089d96ddc2e16d0891b0dc557blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTFMEW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTFMEW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

