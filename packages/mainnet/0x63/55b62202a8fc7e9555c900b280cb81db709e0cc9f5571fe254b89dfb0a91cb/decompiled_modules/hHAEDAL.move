module 0x6355b62202a8fc7e9555c900b280cb81db709e0cc9f5571fe254b89dfb0a91cb::hHAEDAL {
    struct HHAEDAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHAEDAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHAEDAL>(arg0, 9, b"hHAEDAL", b"hHAEDAL Coin", b"test-init-desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lv-curator.haedal.xyz/Lendvault/lpt/hhaedal_75fab7dd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HHAEDAL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHAEDAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

