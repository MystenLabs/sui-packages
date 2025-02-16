module 0x9f64a180373a6b66595025ae16a4ab701f0af1dd5c7ce1ac91dc112e52c2a3f8::scallop_sca {
    struct SCALLOP_SCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_SCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_SCA>(arg0, 9, b"sSCA", b"sSCA", b"Scallop interest-bearing token for SCA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://33u4xknxxofra3l4znfavzmktn37xy3wiubysswgxqduv3siwtna.arweave.net/3unLqbe7ixBtfMtKCuWKm3f743ZFA4lKxrwHSu5ItNo")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_SCA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_SCA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

