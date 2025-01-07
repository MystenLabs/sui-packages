module 0x3bfa1f975b4808d576a86e635aae3acc132bda674ed5e997432cb7d33bee390c::ronda {
    struct RONDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONDA>(arg0, 6, b"Ronda", b"Ronda On Sui", b"Ronda on sui the first billion dollar meme coin on sui network on the road to bigger and better things never looking back!! Woof Woof", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/631_FAA_46_D2_C6_4187_B6_C3_C6_B59_A150_CBB_4d75104bf3.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

