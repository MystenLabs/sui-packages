module 0x4eb6c16a2c92ca22ea86d90d3c5f3af1ff4a3049b1c6e433461d67aae429a972::satoshinakamotosui {
    struct SATOSHINAKAMOTOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSHINAKAMOTOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSHINAKAMOTOSUI>(arg0, 6, b"SatoshiNakamotoSui", b"Satoshi Nakamoto", b"SSSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_18_03_22_52ea73c24e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHINAKAMOTOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOSHINAKAMOTOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

