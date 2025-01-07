module 0x985ed4d546e355c3770f7117367d93e9b5a3c187d936d10e6fb75da020e32f88::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPO>(arg0, 6, b"HIPPO", b"HIPPO HIPPO", x"486970706f20486970706f2069732061207472616e73706172656e74206d656d6520636f696e2070726f6a656374207468617420666f637573657320666972737420616e6420666f72656d6f7374206f6e206275696c64696e672061206c6f6e672d7465726d20636f6d6d756e6974792e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hippodeng_330f4f107b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

