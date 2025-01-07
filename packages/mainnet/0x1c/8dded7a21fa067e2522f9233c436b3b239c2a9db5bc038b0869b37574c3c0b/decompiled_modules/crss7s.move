module 0x1c8dded7a21fa067e2522f9233c436b3b239c2a9db5bc038b0869b37574c3c0b::crss7s {
    struct CRSS7S has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRSS7S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRSS7S>(arg0, 6, b"CRSS7S", b"CristianoRonaldoSpeedSmurf7Sui", b"RoadMap to $100bn ( + % )", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_06_20_52_24_d421c83630.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRSS7S>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRSS7S>>(v1);
    }

    // decompiled from Move bytecode v6
}

