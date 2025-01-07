module 0xd406dadb48ad7c2b987e91473cabe5419b7d1b9f9240183f3ce32e34afc8f64a::darkmove {
    struct DARKMOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARKMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARKMOVE>(arg0, 6, b"DARKMOVE", b"DARK MOVEPUMP", b"BUY BACK $MOVEPUMP THEN BURN!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Move_Pump_APT_1f0b9010c8_1_copy_75f4563c91.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARKMOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARKMOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

