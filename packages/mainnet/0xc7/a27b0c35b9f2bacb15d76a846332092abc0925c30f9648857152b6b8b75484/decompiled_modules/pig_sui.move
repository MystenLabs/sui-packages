module 0xc7a27b0c35b9f2bacb15d76a846332092abc0925c30f9648857152b6b8b75484::pig_sui {
    struct PIG_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIG_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIG_SUI>(arg0, 9, b"pigSUI", b"Rootlets Staked SUI", b"Rootlets Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/03eff2db-2c41-4153-b161-17cdfb5c4ca1/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIG_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIG_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

