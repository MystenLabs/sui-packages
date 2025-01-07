module 0xaeb209bda65987b44e73b5ba5172ac8ebe6df969ef6fc1419c292ec369a0ab29::mauni {
    struct MAUNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAUNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAUNI>(arg0, 6, b"MAUNI", b"Matts Universe", b"Matt's Universe is a realm where fun and creativity know no bounds, and characters shape the world around them", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/M3_EV_Hzel_400x400_3e37a96796.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAUNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAUNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

