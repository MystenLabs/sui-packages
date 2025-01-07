module 0xbfd6687c269634fe2ce5bc9cb057e9a2eea171a31e8f560278c99546a14d10d5::mvc {
    struct MVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MVC>(arg0, 9, b"MVC", b"HD", b"BCXV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bd6ba87a-7e04-43f2-b6d8-2cc3fdc91df4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MVC>>(v1);
    }

    // decompiled from Move bytecode v6
}

