module 0x10e7f9594e0f718ad8a57856be2cf698fc80c450bcffd6b6fa371b9defba2d21::mefi {
    struct MEFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEFI>(arg0, 6, b"Mefi", b"Memefi", b"Memefi community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055614_af409f51c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

