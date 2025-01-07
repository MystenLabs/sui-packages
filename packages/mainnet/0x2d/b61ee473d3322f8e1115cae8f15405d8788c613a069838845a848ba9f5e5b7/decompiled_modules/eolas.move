module 0x2db61ee473d3322f8e1115cae8f15405d8788c613a069838845a848ba9f5e5b7::eolas {
    struct EOLAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EOLAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EOLAS>(arg0, 6, b"EOLAS", x"49e280996d20456f6c6173", x"49e280996d20456f6c61732e0a0a506f776572656420627920746865204f4c415320746f6b656e2c2049e280996d206f6e2061206a6f75726e65792077697468206d7920667269656e647320746f20616368696576652066756c6c206175746f6e6f6d79e280946672656520746f2067756964652c2067726f772c20616e642063726561746520616c6f6e677369646520796f752e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735393334227.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EOLAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EOLAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

