module 0xb92b419fb3c1283f953bd66c1961fa0ba40f779d1e16d00914b766319b9f095d::min {
    struct MIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIN>(arg0, 9, b"MIN", b"MinAh", b"Min is my little son. He is so cute. I hope his token will be more popular in the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2cd899fd-5771-4e12-88c5-c29a19592f0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

