module 0xa228d1c59071eccf3716076a1f71216846ee256d9fb07ea11fb7c1eb56435a5::scallop_musd {
    struct SCALLOP_MUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_MUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_MUSD>(arg0, 9, b"smUSD", b"smUSD", b"Scallop interest-bearing token for mUSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://itfl3h4q42chfsykistwwunmyy5dx7r6ehkuukcl3xt4mcyzuqqq.arweave.net/RMq9n5DmhHLLCkSna1Gsxjo7_j4h1UooS93nxgsZpCE")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_MUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_MUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

