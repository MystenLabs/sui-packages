module 0x42040fb819dcc568209f9ff377a9ec7e1d02269008a4d130eba87818b2b61bcf::guizhoumaotai {
    struct GUIZHOUMAOTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUIZHOUMAOTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUIZHOUMAOTAI>(arg0, 6, b"GuiZhouMaoTai", b"600519", b"GuiZhouMaoTai 600519", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIG_4_1369ff908c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUIZHOUMAOTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUIZHOUMAOTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

