module 0x77d0dcd313ed5c2cde31864cf86d86671ad2b444cb4fc54576e742047ac20e11::scr {
    struct SCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCR>(arg0, 9, b"SCR", b"Scorpion", x"47726561742053636f7270696f6e20e2998f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/28dcee1c-f045-4196-b4a7-20f482b6347b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCR>>(v1);
    }

    // decompiled from Move bytecode v6
}

