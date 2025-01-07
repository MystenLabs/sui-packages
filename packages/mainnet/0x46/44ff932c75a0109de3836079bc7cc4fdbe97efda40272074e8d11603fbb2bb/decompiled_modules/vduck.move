module 0x4644ff932c75a0109de3836079bc7cc4fdbe97efda40272074e8d11603fbb2bb::vduck {
    struct VDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: VDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VDUCK>(arg0, 6, b"VDUCK", b"VELTO DUCK", x"56656c746f204475636b2069732061206d656d65636f696e20696e73706972656420627920696e7465726e6574206d656d657320616e640a706f70756c61722063756c747572652c20666561747572696e672061206475636b20617320697473206d6173636f742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ssstwitter_com_1721408116903_0a699e9303.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

