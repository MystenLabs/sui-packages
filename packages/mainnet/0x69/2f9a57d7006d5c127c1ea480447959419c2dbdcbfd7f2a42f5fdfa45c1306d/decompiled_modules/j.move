module 0x692f9a57d7006d5c127c1ea480447959419c2dbdcbfd7f2a42f5fdfa45c1306d::j {
    struct J has drop {
        dummy_field: bool,
    }

    fun init(arg0: J, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<J>(arg0, 9, b"J", b"Joker", b"Joker Soul", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ece984b9-c90d-4128-b9d2-9d0bbe03fddb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<J>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<J>>(v1);
    }

    // decompiled from Move bytecode v6
}

