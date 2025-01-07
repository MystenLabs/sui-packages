module 0x2a013088f43109617da9ef9a8d374706eca63d0c74cc65af75c83a8c31cdaee4::punt {
    struct PUNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNT>(arg0, 6, b"Punt", b"Punt on sui", b"For punt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241103_024236_21e8e43c3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

