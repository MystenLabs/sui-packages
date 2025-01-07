module 0xeef0583870ebfef6c05907684c1c572e2fd764f627eaaa028f9734c45f6f2468::suiwukong {
    struct SUIWUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWUKONG>(arg0, 9, b"SUIWUKONG", b" SuiWukong", x"496e204368696e657365206d7974686f6c6f67792c202c20746865204d6f6e6b6579204b696e672c206973206120747269636b7374657220676f642063656e7472616c20746f205775204368656e67e28099656ee2809973204a6f75726e657920746f2074686520576573742e204b6e6f776e20666f722068697320756e6d61746368656420737472656e67746820616e64206162696c69747920746f207472616e73666f726d20696e746f20373220666f726d732c2057756b6f6e672063616e20616c736f206d616e6970756c6174652074686520656c656d656e74732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6ac985c8-6657-40b8-a2a3-fbc48c349a42.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWUKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIWUKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

