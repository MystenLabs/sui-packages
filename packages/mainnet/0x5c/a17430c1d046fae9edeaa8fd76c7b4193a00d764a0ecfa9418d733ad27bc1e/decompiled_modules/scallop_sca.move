module 0x5ca17430c1d046fae9edeaa8fd76c7b4193a00d764a0ecfa9418d733ad27bc1e::scallop_sca {
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

