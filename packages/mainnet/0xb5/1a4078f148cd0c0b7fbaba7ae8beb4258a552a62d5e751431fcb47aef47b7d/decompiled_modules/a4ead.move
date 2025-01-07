module 0xb51a4078f148cd0c0b7fbaba7ae8beb4258a552a62d5e751431fcb47aef47b7d::a4ead {
    struct A4EAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: A4EAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A4EAD>(arg0, 9, b"A4EAD", b"AHEAD", b"AHEAD case", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ce0647c-9c36-46cb-a2b1-4ade2e1baad4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A4EAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A4EAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

