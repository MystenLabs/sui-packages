module 0x4ed816abb33715958dbccf324e7e209f1f82e30d133cc20d052a673cc8574fbb::suso {
    struct SUSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSO>(arg0, 9, b"SUSO", b"SuiSoccer ", b"Sui Gaming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.resimlink.com/DHcEzo.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUSO>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

