module 0xdb716b5711cd4309fc5e89b6089e615dd7a801a8927f63f56db1b1d219d6dfc3::windows {
    struct WINDOWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINDOWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINDOWS>(arg0, 6, b"WINDOWS", b"Windows on Sui", b"First Windows on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/text_307ef9785b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINDOWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINDOWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

