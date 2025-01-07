module 0x4b6ec7fbaae4932758b9301b1941d02988a0e57059c41191c36825838c42d48::olaf {
    struct OLAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLAF>(arg0, 6, b"OLAF", b"Merry OLAF", b"Olaf swimming in money pools and causing absolute Christmas chaos. Warm hugs? Nah. Were here for the wild ride!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_22_23_23_00_065c2cd8e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

