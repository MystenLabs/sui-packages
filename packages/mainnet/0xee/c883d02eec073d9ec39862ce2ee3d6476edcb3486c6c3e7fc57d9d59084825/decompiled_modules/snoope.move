module 0xeec883d02eec073d9ec39862ce2ee3d6476edcb3486c6c3e7fc57d9d59084825::snoope {
    struct SNOOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOPE>(arg0, 6, b"Snoope", b"Snoope Doge SUI", b"Meet Snoope Doge: The coolest pupper in town. Such style, much swagger, wow!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asd21312xcvbvbcv_bea81f71ec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

