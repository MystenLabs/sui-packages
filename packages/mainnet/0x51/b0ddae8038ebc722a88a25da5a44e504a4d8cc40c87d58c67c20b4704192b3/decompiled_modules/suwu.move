module 0x51b0ddae8038ebc722a88a25da5a44e504a4d8cc40c87d58c67c20b4704192b3::suwu {
    struct SUWU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUWU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUWU>(arg0, 6, b"SUWU", b"Suinicorn - Memojies coming to Sui", x"497420697320696e20746865206e616d65210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suinivorn_caf57166a1.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUWU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUWU>>(v1);
    }

    // decompiled from Move bytecode v6
}

