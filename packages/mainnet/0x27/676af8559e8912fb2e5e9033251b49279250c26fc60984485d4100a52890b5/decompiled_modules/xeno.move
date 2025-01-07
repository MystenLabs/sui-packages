module 0x27676af8559e8912fb2e5e9033251b49279250c26fc60984485d4100a52890b5::xeno {
    struct XENO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XENO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XENO>(arg0, 6, b"XENO", b"XENOBOT", x"496e2061206675747572652077686572652068756d616e697479206861732065766f6c766564206265796f6e64206974732062696f6c6f676963616c206c696d69746174696f6e732c2058656e6f626f747320656d657267652061732074686520657069746f6d65206f662068756d616e20706f74656e7469616c2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241128_054653_124_5aee3f3213.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XENO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XENO>>(v1);
    }

    // decompiled from Move bytecode v6
}

