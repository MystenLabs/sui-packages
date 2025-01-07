module 0x82f46bfa4ef397ee6fa016c6ca18e5d6ee0dfae4c2d1ec1030ec66686ddae055::ujja {
    struct UJJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UJJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UJJA>(arg0, 9, b"UJJA", b"Jjbs", b"Jjcn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5586f3b-6406-40cd-a81d-8f220bfd011c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UJJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UJJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

