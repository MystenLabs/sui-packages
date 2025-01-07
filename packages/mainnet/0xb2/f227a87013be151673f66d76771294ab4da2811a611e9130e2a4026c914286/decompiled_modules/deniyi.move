module 0xb2f227a87013be151673f66d76771294ab4da2811a611e9130e2a4026c914286::deniyi {
    struct DENIYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENIYI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENIYI>(arg0, 6, b"DENIYI", b"AAAA", b"AAAAAAAAAAAAAAAAAAAAAAA can't stop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_06_23_00_01_8a7d9320c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENIYI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENIYI>>(v1);
    }

    // decompiled from Move bytecode v6
}

