module 0x80842e0384d914127ac51a6b2282b07a0d46ee1c3ab2961f0b0e528790b5a2b1::santaclaus {
    struct SANTACLAUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTACLAUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTACLAUS>(arg0, 6, b"Santaclaus", b"2025", b"2025 is coming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sfdfsdfsd_3ba99d8c33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTACLAUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANTACLAUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

