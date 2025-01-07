module 0x52158f8f20eab9cbc10c41d1627f85bfe5dc5fe578965029b3cc9fe3a60106f7::spank {
    struct SPANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPANK>(arg0, 6, b"SPANK", b"Spank That Bitch", b"We spankin' all day.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ezgif_1_771e6316dc_0e9db86a09.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

