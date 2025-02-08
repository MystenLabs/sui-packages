module 0xee4901da4d38307ad8394e9167cc4d529cccb8130c7b0cdee16b7b8a977ba4ff::scallop_musd {
    struct SCALLOP_MUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_MUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_MUSD>(arg0, 8, b"smUSD", b"smUSD", b"Scallop interest-bearing token for mUSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://itfl3h4q42chfsykistwwunmyy5dx7r6ehkuukcl3xt4mcyzuqqq.arweave.net/RMq9n5DmhHLLCkSna1Gsxjo7_j4h1UooS93nxgsZpCE")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_MUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_MUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

