module 0xf35e9d581785391c4703604fe7dbc13b3b81268d45791dbaae0e301555b49957::abd {
    struct ABD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABD>(arg0, 9, b"ABD", b"Abdulla", b"Nnjuy bhu bgggh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/932b4b2f-f35d-4eb5-a240-4ad28f213a94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABD>>(v1);
    }

    // decompiled from Move bytecode v6
}

