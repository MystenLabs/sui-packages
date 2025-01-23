module 0xb7b6d09d020f5b3bf18a56e032d276ad388288527b5a296b6125a03f501ae717::trump_9771 {
    struct TRUMP_9771 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP_9771, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP_9771>(arg0, 9, b"TRUMP_9771", b"Trump", b"Tocem meme Tramp ticet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1271d1b-38aa-4d69-a324-406082f1cb63.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP_9771>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP_9771>>(v1);
    }

    // decompiled from Move bytecode v6
}

