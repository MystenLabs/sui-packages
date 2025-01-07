module 0xa382e42c6c4a25532afecdad4a6943b3a447be8a59beb07450caa34dc7b606bf::signus {
    struct SIGNUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGNUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGNUS>(arg0, 6, b"SIGNUS", b"SIGNUS BOT", b"https://elitebots.pro/ - @SignusSui_bot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4f678b23_37cd_4e6c_a9c4_ee1b80e62763_60dc1ae091.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGNUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIGNUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

