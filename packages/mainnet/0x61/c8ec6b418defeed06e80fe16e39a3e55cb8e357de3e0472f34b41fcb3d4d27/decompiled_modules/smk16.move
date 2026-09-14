module 0x61c8ec6b418defeed06e80fe16e39a3e55cb8e357de3e0472f34b41fcb3d4d27::smk16 {
    struct SMK16 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMK16, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"-";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"-"))
        };
        let (v2, v3) = 0x2::coin::create_currency<SMK16>(arg0, 9, b"SMK16", b"SplitSmoke", b"v16 lock split smoke", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMK16>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMK16>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SMK16>>(0x2::coin::mint<SMK16>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

