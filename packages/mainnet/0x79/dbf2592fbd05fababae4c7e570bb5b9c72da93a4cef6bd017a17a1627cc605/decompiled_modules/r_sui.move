module 0x79dbf2592fbd05fababae4c7e570bb5b9c72da93a4cef6bd017a17a1627cc605::r_sui {
    struct R_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: R_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R_SUI>(arg0, 9, b"rSUI", b"Rogue Staked SUI", b"Rogue Sui LST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/5133740c-254b-4f53-9fd5-66c01086ac38/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<R_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

