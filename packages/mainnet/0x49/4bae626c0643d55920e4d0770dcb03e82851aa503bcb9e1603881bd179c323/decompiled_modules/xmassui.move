module 0x494bae626c0643d55920e4d0770dcb03e82851aa503bcb9e1603881bd179c323::xmassui {
    struct XMASSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMASSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMASSUI>(arg0, 6, b"XMASsui", b"XMAS", b"XMAS coin for holiday", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/christmas_new_year_typography_on_600nw_2478804581_22426731ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMASSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XMASSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

