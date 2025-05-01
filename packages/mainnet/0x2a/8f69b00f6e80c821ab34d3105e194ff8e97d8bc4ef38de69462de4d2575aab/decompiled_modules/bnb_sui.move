module 0x2a8f69b00f6e80c821ab34d3105e194ff8e97d8bc4ef38de69462de4d2575aab::bnb_sui {
    struct BNB_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNB_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNB_SUI>(arg0, 9, b"bnbSUI", b"Binance Staked SUI", b"Binance Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/62ff6568-d945-44ca-9991-72fab7caaf8f/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNB_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNB_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

