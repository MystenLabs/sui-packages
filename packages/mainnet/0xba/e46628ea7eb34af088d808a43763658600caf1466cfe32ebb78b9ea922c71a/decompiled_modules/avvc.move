module 0xbae46628ea7eb34af088d808a43763658600caf1466cfe32ebb78b9ea922c71a::avvc {
    struct AVVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVVC>(arg0, 6, b"AVVC", b"Avvc", b"aavc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/moonlitebot_x_rachop_ce74dcd8cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVVC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVVC>>(v1);
    }

    // decompiled from Move bytecode v6
}

