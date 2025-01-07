module 0xf7bf345f21a3457be1f7d5f7c5a3a3e7a2b54fd32f4f5e0810ac66aa851a27b5::doog {
    struct DOOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOG>(arg0, 6, b"DOOG", b"SUIDOOG", b"$DOOG is Matt_Furie's Dog!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/doog_pfp_2cecac0ffc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

