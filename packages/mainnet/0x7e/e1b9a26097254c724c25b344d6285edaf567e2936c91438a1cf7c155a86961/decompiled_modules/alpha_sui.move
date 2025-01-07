module 0x7ee1b9a26097254c724c25b344d6285edaf567e2936c91438a1cf7c155a86961::alpha_sui {
    struct ALPHA_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHA_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHA_SUI>(arg0, 9, b"ALPHA", b"AlphaSui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.bluemove.io/token/alpha-coin.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALPHA_SUI>>(v1);
        0x2::coin::mint_and_transfer<ALPHA_SUI>(&mut v2, 500000000000000000, @0x8164c07e28b28176e74f208c066c80bfedcc0017b37561384de2e9f760bcd71d, arg1);
        0x2::coin::mint_and_transfer<ALPHA_SUI>(&mut v2, 300000000000000000, @0xad314aba0b87de56f7f10aa3868522fbea8135a11ca74a68af638e7d0efa01f0, arg1);
        0x2::coin::mint_and_transfer<ALPHA_SUI>(&mut v2, 100000000000000000, @0xa2f39c6b90fbeb22e5f12dd9e84cbe5ad92bac045e1cf16f2e012c5a024b83ba, arg1);
        0x2::coin::mint_and_transfer<ALPHA_SUI>(&mut v2, 100000000000000000, @0x13deb587a30a03c524bf1d5e69fc312f0764b24f285ba584c8fd01b31263f959, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA_SUI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

