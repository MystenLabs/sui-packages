module 0x864e4ff30c9b03828e38c5d0d280b68548d19cb74dbdf6ae1d764c6495cb3a76::jawad {
    struct JAWAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAWAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAWAD>(arg0, 9, b"JAWAD", b"Rana", b"This is a nice coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/08ea29c9-e623-406f-b862-70636e921666.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAWAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAWAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

