module 0x8d7042eff93908304507c28cf43e927bbeef04746de767e0b43156f14e3d6668::suint {
    struct SUINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINT>(arg0, 6, b"Suint", b"Suint on Sui", x"4c6574277320736d6f6b652061205355494e54210a0a446f207467206966206e65656465642c20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_15_22_33_21_0b78874e1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

