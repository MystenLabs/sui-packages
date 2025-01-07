module 0x220ba0b616236ba495785631b4f843b8ae626a50bd888d976f2783bc3c5c5a56::cct {
    struct CCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCT>(arg0, 9, b"CCT", b"cocoa", b"cocoachain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/04a76130-fc5a-47e0-b678-f46c44899e4d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

