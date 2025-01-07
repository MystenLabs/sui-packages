module 0xe0078387c454ccd9aa3cdc335725f62b3b0c0ee5b2bb60ffdf97633aac69cb6e::gra {
    struct GRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRA>(arg0, 9, b"GRA", b"Grafon ", b"Duck GRA GRA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4139e23a-252e-4407-be53-84a02cd53461.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

