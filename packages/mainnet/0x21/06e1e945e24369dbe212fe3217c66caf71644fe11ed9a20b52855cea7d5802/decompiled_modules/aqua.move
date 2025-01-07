module 0x2106e1e945e24369dbe212fe3217c66caf71644fe11ed9a20b52855cea7d5802::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUA>(arg0, 6, b"AQUA", b"AQUA Goddess of Water", x"41717561206973206120636861726163746572206f66204a6170616e657365206c69676874206e6f76656c2073657269657320616e6420616e696d65204b6f6e6f537562612e204120776174657220676f64646573732c2041717561206163636f6d70616e6965732070726f7461676f6e697374206f662074686520736572696573204b617a756d61205361746f7520696e20686973206a6f75726e6579732e0a0a4e6f2054472c204e6f20582c204e6f20536974652e204e6f7420636f6e74726f6c6c656420627920636162616c2e20436f6d6d756e6974792064656369646520627920697473656c662e2069206a7573742073746172742069742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_ec3c2a4b5b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

