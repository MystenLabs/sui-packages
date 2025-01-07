module 0x14ae994cbc49d7338a16815fb1e0254535dff1631999fe7b67ef3c670cd1cce5::rsw {
    struct RSW has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSW>(arg0, 6, b"RSW", b"Russian Spy Whale", x"5472696275746520746f20746865205275737369616e20737079207768616c65204876616c64696d6972206b696c6c65642062792067756e73686f74732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241228_024014_400_f415c9c1ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RSW>>(v1);
    }

    // decompiled from Move bytecode v6
}

