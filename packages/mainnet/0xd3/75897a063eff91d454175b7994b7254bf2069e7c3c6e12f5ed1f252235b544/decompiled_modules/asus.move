module 0xd375897a063eff91d454175b7994b7254bf2069e7c3c6e12f5ed1f252235b544::asus {
    struct ASUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUS>(arg0, 9, b"ASUS", b"asus", b"Introducing ASUS Memecoin, a digital currency that combines the spirit of ASUS technology with meme culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed53e67d-1a24-4b14-b096-751f43d97f89.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

