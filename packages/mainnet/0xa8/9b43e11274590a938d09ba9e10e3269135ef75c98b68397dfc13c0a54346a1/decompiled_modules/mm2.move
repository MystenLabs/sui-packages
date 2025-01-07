module 0xa89b43e11274590a938d09ba9e10e3269135ef75c98b68397dfc13c0a54346a1::mm2 {
    struct MM2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MM2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MM2>(arg0, 9, b"MM2", b"Meme 2", b"MMF, Meme 2, mmm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f3c6c2d-5357-407f-a248-35e52263bccf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MM2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MM2>>(v1);
    }

    // decompiled from Move bytecode v6
}

