module 0x534016177b13dcd6e3a5a559ec1bdd8018dcfc1f83f22131f759ea904cc51743::cas {
    struct CAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAS>(arg0, 9, b"CAS", b"Cash-Out", b"The best meme coin to boost the joy of cash out", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba45693b-69d8-47b0-9b9e-2c1b28f939e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

