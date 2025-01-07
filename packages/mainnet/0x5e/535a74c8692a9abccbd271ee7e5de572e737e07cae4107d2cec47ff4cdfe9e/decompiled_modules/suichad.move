module 0x5e535a74c8692a9abccbd271ee7e5de572e737e07cae4107d2cec47ff4cdfe9e::suichad {
    struct SUICHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHAD>(arg0, 9, b"SUICHAD", b"CHAD ON SUI", b"ONLY FOR SUI CHADS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bc63162464cf0221f6ddbfea5dcf2e19blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICHAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

