module 0xb8572786c26c686b352148c89f81762a69a67645255a610597427be1e57a0a0::bender {
    struct BENDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENDER>(arg0, 6, b"BENDER", b"SUIBENDER", b"The Last SuiBender", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mascotx_1a082612d7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

