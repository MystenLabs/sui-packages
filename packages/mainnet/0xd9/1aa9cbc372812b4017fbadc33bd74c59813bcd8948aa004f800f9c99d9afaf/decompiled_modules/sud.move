module 0xd91aa9cbc372812b4017fbadc33bd74c59813bcd8948aa004f800f9c99d9afaf::sud {
    struct SUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUD>(arg0, 9, b"SUD", b"Suidogs", b"Suidogs bark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56326ae0-9a04-4826-8453-1c7c1e913851.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

