module 0x373b793c465acabd1d3bb1dced1f0f6fc9f368e5ba334e70cee7f4e0480e3418::seadog {
    struct SEADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEADOG>(arg0, 6, b"SEADOG", b"CAPTAIN SEADOG", b"Everyh chain need dog SEADOG is CAPTAIN DOG SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CBB_2_B146_DCD_7_455_C_BEE_6_C884_FD_93_FB_9_C_9c628db745.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

