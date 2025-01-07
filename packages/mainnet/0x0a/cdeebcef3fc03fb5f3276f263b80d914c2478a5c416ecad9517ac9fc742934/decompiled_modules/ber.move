module 0xacdeebcef3fc03fb5f3276f263b80d914c2478a5c416ecad9517ac9fc742934::ber {
    struct BER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BER>(arg0, 9, b"BER", b"BERA", b"Berachain meme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bb856178-ec65-4504-88ba-9e1c8a45bb23.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BER>>(v1);
    }

    // decompiled from Move bytecode v6
}

