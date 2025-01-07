module 0xc43c9fead6c9f5841d59e9858123559067c7c11283eb1a6ed857423769c97005::eel {
    struct EEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEL>(arg0, 6, b"EEL", b"EEL on sui", b"eel is going to electrocute all the fishes in the sui waters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_65_771aaf11b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

