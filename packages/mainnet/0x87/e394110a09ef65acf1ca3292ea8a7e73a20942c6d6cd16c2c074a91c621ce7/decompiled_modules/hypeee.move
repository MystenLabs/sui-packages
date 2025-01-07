module 0x87e394110a09ef65acf1ca3292ea8a7e73a20942c6d6cd16c2c074a91c621ce7::hypeee {
    struct HYPEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPEEE>(arg0, 9, b"HYPEEE", b" HYPEEE  ON FUN", x"4120467265616b696e67204e61756768747920506972616e686120696e2074686520537569204f6365616e20f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/21e568a6afd1afe41c3ed50674bf21a0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYPEEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPEEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

