module 0xa6a4f311cd91de07bf35bc6a43f110071db4961535f1850837b0172fe29e97::aypm {
    struct AYPM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYPM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYPM>(arg0, 9, b"AYPM", b"Ayunpameme", b"Ayunpa Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5bb95d35-de7f-46b8-83e8-b32a99fdd7d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYPM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AYPM>>(v1);
    }

    // decompiled from Move bytecode v6
}

