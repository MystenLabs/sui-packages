module 0xeab6961b8b7e364607fecfaf3b39d3b49db50adb64e2521983277361a17cde79::sbluesky {
    struct SBLUESKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBLUESKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBLUESKY>(arg0, 6, b"Sbluesky", b"Sui Bluesky", x"496e73706972656420627920426c7565536b7920706c6174666f726d207468617420697320726973696e6720746f20636f6d7065746520776974682058202854776974746572292e0a31386d696c20557365727320616e6420726973696e67206f6e204e6f76656d6265722031362c2032303234", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6419ae76_c841_4e54_972f_182d8a4c27b8_f68484292b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBLUESKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBLUESKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

