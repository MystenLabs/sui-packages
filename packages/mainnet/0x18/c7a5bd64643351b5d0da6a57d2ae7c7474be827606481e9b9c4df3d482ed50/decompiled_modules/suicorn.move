module 0x18c7a5bd64643351b5d0da6a57d2ae7c7474be827606481e9b9c4df3d482ed50::suicorn {
    struct SUICORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICORN>(arg0, 6, b"Suicorn", b"Sui Unicorn", b"The only Sui Unicorn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUJO_5_1_133bdb88c8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

