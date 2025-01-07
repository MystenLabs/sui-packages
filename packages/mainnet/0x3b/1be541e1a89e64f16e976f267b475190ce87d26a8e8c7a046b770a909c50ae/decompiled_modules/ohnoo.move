module 0x3b1be541e1a89e64f16e976f267b475190ce87d26a8e8c7a046b770a909c50ae::ohnoo {
    struct OHNOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OHNOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OHNOO>(arg0, 6, b"OhNoo", b"OhNoo!", x"4f68204e6f6f212054686520636f696e207468617427732061730a756e7072656469637461626c652061732061207275626265720a6475636b20696e20612073746f726d21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005320_429c305684.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OHNOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OHNOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

