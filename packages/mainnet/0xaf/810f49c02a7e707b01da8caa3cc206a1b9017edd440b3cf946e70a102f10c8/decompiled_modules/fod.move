module 0xaf810f49c02a7e707b01da8caa3cc206a1b9017edd440b3cf946e70a102f10c8::fod {
    struct FOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOD>(arg0, 9, b"FOD", b"Foodie", b"A meme coin for fooodies ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3166ea25-e118-4368-873e-1a03f2b3c357.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

