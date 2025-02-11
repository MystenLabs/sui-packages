module 0xdaf903bde7ea081b9d97bf0118b7798439e41f94df6bd570a3e4d22ce05dfece::mumi {
    struct MUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMI>(arg0, 6, b"MUMI", b"mumimon", b"Lets go, mumimon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/quality_restoration_20250210234312074_3b854cdd08.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

