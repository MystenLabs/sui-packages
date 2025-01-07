module 0xd263f5d2b593dbb4ff901f192f0d8b10b77a1dad054bb1fc426ad23d35318334::lol {
    struct LOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL>(arg0, 9, b"LOL", b"LaughCoin", x"4c61756768436f696e2020697320612063727970746f63757272656e6379207468617420636f6d62696e65732066696e616e63652077697468206a6f7921205065726665637420666f7220726577617264696e67206d656d65732c20636f6d65647920636f6e74656e742c20616e6420676f6f642066756e2e204c61756768746572206973207468652063757272656e6379206f6620746865206675747572650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/880e3839-780b-4898-8e34-514a24ebfa1b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

