module 0xc71f92d2c4a943438eca9342b9c03a6ba2e2038d38fcf5d9a9cbb1d52238c1d9::dmc {
    struct DMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMC>(arg0, 9, b"DMC", b"Doggy ", b"When people like to become dogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c91194a7-4de7-4eab-924f-f5b52ea39b12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

