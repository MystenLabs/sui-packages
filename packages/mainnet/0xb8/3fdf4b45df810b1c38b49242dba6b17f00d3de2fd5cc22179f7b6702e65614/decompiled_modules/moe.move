module 0xb83fdf4b45df810b1c38b49242dba6b17f00d3de2fd5cc22179f7b6702e65614::moe {
    struct MOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOE>(arg0, 6, b"MOE", b"It's moe", x"4d6f65206973206120636861726d696e672c206769616e74206361742d6769726c2077686f2061727269766564206f6e2045617274682066726f6d20612064697374616e742067616c6178792e20576974682063617420656172732c2061206c6f6e67207461696c2c20616e642061207761726d20736d696c652c20736865206578706c6f726573206f757220776f726c642c207768657265207368652063617074757265732074686520637572696f7369747920616e6420686561727473206f66207468652070656f706c6520616e64206d656d65206372656174757265732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048631_f93556adb9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

