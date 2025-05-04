module 0xecfd796f98f7ecf161d70fb9b657e25b1c81743de8d9d8c71b23408f29500525::ods_sui {
    struct ODS_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODS_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODS_SUI>(arg0, 9, b"odsSUI", b"Odessa Staked SUI", b"Odessa city staked SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/7ae1669a-cbbc-4fff-9226-d7798e04153a/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODS_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODS_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

