module 0xaa60e0a1647992cc0cf1e845cdafe125042bb16d2e0f57e891368f189bb53c26::crying {
    struct CRYING has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYING>(arg0, 6, b"CRYING", b"Crying Cat", b"cat crying, please adopt me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014197_981b42b985.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRYING>>(v1);
    }

    // decompiled from Move bytecode v6
}

