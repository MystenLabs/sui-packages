module 0xde6d486ddc9cdf23ec7fa3f1902152c50e7d5b7b86ad8565ef30cfeef5ac659b::fairyai {
    struct FAIRYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAIRYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAIRYAI>(arg0, 9, b"FAIRYAI", b"FAIRY", b"FAIRY is a meme inspired by AI that can create pictures by prompt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5cca725-e702-49c5-82d1-b864e8b889c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAIRYAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAIRYAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

