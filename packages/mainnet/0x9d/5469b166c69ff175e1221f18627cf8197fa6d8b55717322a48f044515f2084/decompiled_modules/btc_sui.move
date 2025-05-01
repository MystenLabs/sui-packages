module 0x9d5469b166c69ff175e1221f18627cf8197fa6d8b55717322a48f044515f2084::btc_sui {
    struct BTC_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC_SUI>(arg0, 9, b"btcSUI", b"Bitcoin Staked SUI", b"Bitcoin Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/d49fee04-37d6-4bd3-8397-0083f2bc687a/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

