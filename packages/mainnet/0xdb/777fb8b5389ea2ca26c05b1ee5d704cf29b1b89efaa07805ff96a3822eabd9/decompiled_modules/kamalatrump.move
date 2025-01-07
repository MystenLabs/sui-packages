module 0xdb777fb8b5389ea2ca26c05b1ee5d704cf29b1b89efaa07805ff96a3822eabd9::kamalatrump {
    struct KAMALATRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMALATRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMALATRUMP>(arg0, 6, b"KAMALATRUMP", b"Presidents", b"Kamala Vs Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MA_2o_GO_4g_SDFSDFSD_09b616a064.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMALATRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAMALATRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

