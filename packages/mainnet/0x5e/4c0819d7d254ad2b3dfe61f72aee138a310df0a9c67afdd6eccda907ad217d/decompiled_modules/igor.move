module 0x5e4c0819d7d254ad2b3dfe61f72aee138a310df0a9c67afdd6eccda907ad217d::igor {
    struct IGOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: IGOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IGOR>(arg0, 6, b"IGOR", b"Igor the Tiger", b"THE OLD FRIEND'S OF PEPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/igor_ezgif_com_gif_maker_48621d85fa.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IGOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

