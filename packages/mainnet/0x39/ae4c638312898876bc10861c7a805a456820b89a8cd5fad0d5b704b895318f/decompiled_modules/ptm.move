module 0x39ae4c638312898876bc10861c7a805a456820b89a8cd5fad0d5b704b895318f::ptm {
    struct PTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTM>(arg0, 9, b"PTM", b"puttome", b"put to talk or siren", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/19cd9b44-01b3-4237-87cc-15debcdde2cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

