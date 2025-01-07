module 0x4a98ce23ba41797f8855f58f24b93b65a89ff3ad76122ec3c8ca3d1b81d40bf9::terminus {
    struct TERMINUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMINUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERMINUS>(arg0, 6, b"Terminus", b"TERMINUS", b"First City MARS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_FB_60880_EC_9313118_FF_334_A9_A91561_EA_87c484a73a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMINUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TERMINUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

