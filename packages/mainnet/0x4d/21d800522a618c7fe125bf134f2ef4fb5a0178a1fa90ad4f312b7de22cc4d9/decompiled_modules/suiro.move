module 0x4d21d800522a618c7fe125bf134f2ef4fb5a0178a1fa90ad4f312b7de22cc4d9::suiro {
    struct SUIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRO>(arg0, 6, b"SUIRO", b"Suiro", b"Neiro meets Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BLN_od_GS_400x400_45ade9d886.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

