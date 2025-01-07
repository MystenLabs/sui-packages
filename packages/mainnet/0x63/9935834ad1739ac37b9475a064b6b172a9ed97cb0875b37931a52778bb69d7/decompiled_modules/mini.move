module 0x639935834ad1739ac37b9475a064b6b172a9ed97cb0875b37931a52778bb69d7::mini {
    struct MINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINI>(arg0, 6, b"MINI", b"MINI GANG", b"mini gang now on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8438_2920ce3f85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

