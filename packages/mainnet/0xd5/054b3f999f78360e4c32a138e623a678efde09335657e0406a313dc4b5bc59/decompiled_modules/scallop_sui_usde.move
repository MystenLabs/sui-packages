module 0xd5054b3f999f78360e4c32a138e623a678efde09335657e0406a313dc4b5bc59::scallop_sui_usde {
    struct SCALLOP_SUI_USDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_SUI_USDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_SUI_USDE>(arg0, 6, b"ssuiUSDe", b"ssuiUSDe", b"Scallop interest-bearing token for Sui USDe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://4slrgnrqgp4yfwrjvvruwp75bd5fpiqvf5oqhs6eetuystc4kkja.arweave.net/5JcTNjAz-YLaKa1jSz_9CPpXohUvXQPLxCTpiUxcUpI")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_SUI_USDE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_SUI_USDE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

