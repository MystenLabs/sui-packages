module 0x73d8aa335e10de5965b35237cbc31251b7d563b452d67d22a4075cf11b03627b::hhh {
    struct HHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHH>(arg0, 9, b"HHH", b"Tancoin", b"Tajcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d2f695b2-141d-4c8c-927e-852b24d2fec1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

