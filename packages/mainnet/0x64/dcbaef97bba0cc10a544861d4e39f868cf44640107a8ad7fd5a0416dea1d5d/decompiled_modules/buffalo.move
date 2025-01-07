module 0x64dcbaef97bba0cc10a544861d4e39f868cf44640107a8ad7fd5a0416dea1d5d::buffalo {
    struct BUFFALO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUFFALO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUFFALO>(arg0, 9, b"BUFFALO", b"BuffaloCy", b"\"Buffalo Cyber Coin is a fast and secure digital currency. Follow us for updates on crypto, blockchain, and smart investing!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d40e977d-ad25-49fb-a472-02566099b4b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUFFALO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUFFALO>>(v1);
    }

    // decompiled from Move bytecode v6
}

