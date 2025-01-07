module 0x432a4d029db9e58f508186f010619bd7232aefdc0bfbdcb120bfcfaf41379001::tothesui {
    struct TOTHESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTHESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOTHESUI>(arg0, 6, b"TOTHESUI", b"To The Sui", b"I don't know where you're going, but I'm going #totheSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_8_a2a5260875.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTHESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOTHESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

