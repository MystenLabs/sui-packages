module 0x919315646d69fd803b57c37d6c8a76c2bdd440f9033158b627ff9265b5b711b6::fukk {
    struct FUKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUKK>(arg0, 9, b"FUKK", b"Fukkkkkk", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3af5277e-9ad2-4b9c-a52d-440386f36927.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

