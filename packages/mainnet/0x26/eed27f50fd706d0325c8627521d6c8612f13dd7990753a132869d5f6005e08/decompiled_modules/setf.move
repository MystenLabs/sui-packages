module 0x26eed27f50fd706d0325c8627521d6c8612f13dd7990753a132869d5f6005e08::setf {
    struct SETF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SETF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SETF>(arg0, 6, b"Setf", b"Sonic ETF", b"SONIC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rtgtbtn_693549117b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SETF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SETF>>(v1);
    }

    // decompiled from Move bytecode v6
}

