module 0xb5ddc024ef173c43eed10ce9bb1824e6290308b1e41a1912f3052ef57c32968f::mobi {
    struct MOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBI>(arg0, 6, b"MOBI", b"MobiSuiOfc", b"The Greatest Whale of all time is coming to the Ocean of Sui !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241017_133722_584_87104da682.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

