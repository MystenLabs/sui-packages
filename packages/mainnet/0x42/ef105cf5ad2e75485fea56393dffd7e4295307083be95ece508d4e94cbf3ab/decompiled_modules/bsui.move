module 0x42ef105cf5ad2e75485fea56393dffd7e4295307083be95ece508d4e94cbf3ab::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUI>(arg0, 6, b"Bsui", b"BogdSui", b"The community token of web3.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_22_24_03_3eab8984b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

