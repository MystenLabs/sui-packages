module 0xf43279683536f150162e7b98557155ee25a9e7faa528c16c9c709f1f97090f96::wcat {
    struct WCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCAT>(arg0, 6, b"WCAT", b"Water cat", x"43617420696e2077617465720a0a4e6f20736f6369616c732c20736f6369616c206578706572696d656e7420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731384634172.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

