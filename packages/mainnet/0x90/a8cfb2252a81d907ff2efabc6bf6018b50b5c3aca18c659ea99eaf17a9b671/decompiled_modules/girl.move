module 0x90a8cfb2252a81d907ff2efabc6bf6018b50b5c3aca18c659ea99eaf17a9b671::girl {
    struct GIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIRL>(arg0, 6, b"GIRL", b"Cosmic Girl", x"436f736d6963204769726c20546f6b656e2069732061206469676974616c206173736574206275696c74206f6e207468652053756920626c6f636b636861696e2c2073796d626f6c697a696e6720696e6e6f766174696f6e2c20636f6d6d756e6974792c20616e64206120627269676874657220646563656e7472616c697a6564206675747572652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737484650755.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIRL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIRL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

