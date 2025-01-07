module 0x72ac59cd5ee9ba1c6f42e3e727f4008316d0c79629857f395d6bf7ef830cf83d::rtrd {
    struct RTRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTRD>(arg0, 6, b"RTRD", b"Retardeng", b"We are the Retardeng, bringing in the combination of two popular Solana memecoins (The retardios and moodeng) into the $SUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6512_f1f742b510.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RTRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

