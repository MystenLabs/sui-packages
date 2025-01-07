module 0x46e85b4037eef12d0a705d3a0e7014f1ec730bb9f5facde00a549bf3d16a62f4::dzilla {
    struct DZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DZILLA>(arg0, 6, b"DZILLA", b"Duckzilla", b"Duckzilla is slow, but its coming. when it arrives.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dys0_Mti_K_400x400_c96f0f5afb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

