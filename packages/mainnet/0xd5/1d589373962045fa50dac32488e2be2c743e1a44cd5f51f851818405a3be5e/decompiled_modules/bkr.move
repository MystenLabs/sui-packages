module 0xd51d589373962045fa50dac32488e2be2c743e1a44cd5f51f851818405a3be5e::bkr {
    struct BKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKR>(arg0, 9, b"BKR", b"Black Rose", b"A meme coin with potentials. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2fa9bfa8-138b-42fd-8e5c-e98b2e0aa9f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BKR>>(v1);
    }

    // decompiled from Move bytecode v6
}

