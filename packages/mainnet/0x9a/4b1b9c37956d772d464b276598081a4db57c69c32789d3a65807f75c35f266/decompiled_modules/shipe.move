module 0x9a4b1b9c37956d772d464b276598081a4db57c69c32789d3a65807f75c35f266::shipe {
    struct SHIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIPE>(arg0, 9, b"SHIPE", b"Shiba Pepe", b"Shiba Pepe is the ultimate fusion of Shiba Inu and Pepe the Frog, creating a hilarious meme token with a strong community! Join the meme revolution on the blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c2c6a9c3-8de7-45c5-8c07-96c0a5f78c44.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

