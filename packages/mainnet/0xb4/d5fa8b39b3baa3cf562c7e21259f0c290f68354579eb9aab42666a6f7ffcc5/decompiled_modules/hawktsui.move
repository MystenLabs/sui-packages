module 0xb4d5fa8b39b3baa3cf562c7e21259f0c290f68354579eb9aab42666a6f7ffcc5::hawktsui {
    struct HAWKTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWKTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAWKTSUI>(arg0, 6, b"HawktSUI", b"Hawk Tsui", b"Hawktsui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hawktsui_d978221141.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAWKTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAWKTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

