module 0x356ef22e7e60ed317cba0de80e05e8a65872ee6d1b296ca2e84dfcd768e57aaf::zaza {
    struct ZAZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAZA>(arg0, 6, b"ZAZA", b"ZAZA THE CAT", b"Cat On The ZA!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xaxawxaxaxaxax_3b73902f8e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZAZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

