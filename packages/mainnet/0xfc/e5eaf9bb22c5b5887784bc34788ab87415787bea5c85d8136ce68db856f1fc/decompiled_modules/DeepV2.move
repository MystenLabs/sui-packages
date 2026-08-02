module 0xfce5eaf9bb22c5b5887784bc34788ab87415787bea5c85d8136ce68db856f1fc::DeepV2 {
    struct DEEPV2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPV2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPV2>(arg0, 9, b"DEEP", b"DeepV2", b"Token Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s3.coinmarketcap.com/static-gravity/image/7d04b329239e487cb8ea865ec5c2b7a1.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEEPV2>(&mut v2, 1000 * 0x1::u64::pow(10, 9), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPV2>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEPV2>>(v1);
    }

    // decompiled from Move bytecode v6
}

