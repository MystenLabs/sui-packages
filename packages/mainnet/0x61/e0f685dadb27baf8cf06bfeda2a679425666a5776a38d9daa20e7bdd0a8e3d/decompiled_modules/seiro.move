module 0x61e0f685dadb27baf8cf06bfeda2a679425666a5776a38d9daa20e7bdd0a8e3d::seiro {
    struct SEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEIRO>(arg0, 6, b"SEIRO", b"Seiro", b"hajkakakalslal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241111_121403_dc455531e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

