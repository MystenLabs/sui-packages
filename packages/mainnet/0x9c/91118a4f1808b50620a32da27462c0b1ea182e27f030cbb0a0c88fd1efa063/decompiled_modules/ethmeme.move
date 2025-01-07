module 0x9c91118a4f1808b50620a32da27462c0b1ea182e27f030cbb0a0c88fd1efa063::ethmeme {
    struct ETHMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETHMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETHMEME>(arg0, 9, b"ETHMEME", b"EHT", b"This image depicts a cheerful, animated Ethereum logo wearing sunglasses, giving it a fun and confident persona. It is surrounded by gold Bitcoin coins, creating a vibrant and energetic cryptocurrency theme. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9b209e0-a810-4a21-bc27-c947336bb214.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETHMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETHMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

