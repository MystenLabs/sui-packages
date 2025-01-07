module 0x6e8ff63d61e58f718ea8d5de79e36c7f40a9762958dfaab576712018e8341d88::mitch {
    struct MITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MITCH>(arg0, 6, b"MITCH", b"Mascot Mitch", b"The official stick figure SUI mascot.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_21_6af8620c7a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

