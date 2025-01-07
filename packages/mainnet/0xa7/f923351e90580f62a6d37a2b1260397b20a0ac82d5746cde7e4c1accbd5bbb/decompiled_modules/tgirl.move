module 0xa7f923351e90580f62a6d37a2b1260397b20a0ac82d5746cde7e4c1accbd5bbb::tgirl {
    struct TGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGIRL>(arg0, 9, b"TGIRL", b"TattoGirl", b"Meme of AI TATTO GIRL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6bc2cf89-c28e-4588-9314-3fc4b84ec057.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

