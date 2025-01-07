module 0x28a74970185431713181c8ad5e58ba945eeabbb5a24584e1ae560454cee6238f::otu {
    struct OTU has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTU>(arg0, 9, b"OTU", b"OTUBA", b"Not happy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86c06906-9983-49b1-9b13-e41a3ce261fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTU>>(v1);
    }

    // decompiled from Move bytecode v6
}

