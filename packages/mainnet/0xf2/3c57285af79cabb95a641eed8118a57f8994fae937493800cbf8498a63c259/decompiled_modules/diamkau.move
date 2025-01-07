module 0xf23c57285af79cabb95a641eed8118a57f8994fae937493800cbf8498a63c259::diamkau {
    struct DIAMKAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIAMKAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAMKAU>(arg0, 9, b"DIAMKAU", b"Tolongkaki", b"Stupid meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6f0f7ce-80ef-40a0-8d9b-3c000f3f0ce3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIAMKAU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIAMKAU>>(v1);
    }

    // decompiled from Move bytecode v6
}

