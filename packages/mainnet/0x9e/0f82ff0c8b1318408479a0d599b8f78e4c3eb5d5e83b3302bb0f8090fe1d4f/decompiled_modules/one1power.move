module 0x9e0f82ff0c8b1318408479a0d599b8f78e4c3eb5d5e83b3302bb0f8090fe1d4f::one1power {
    struct ONE1POWER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE1POWER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE1POWER>(arg0, 9, b"ONE1POWER", x"445241474f4e20f09f908920", b"Dragon is the first appreciative token of meme digital", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/994fec83-9880-4dbf-9bd7-a01e20d32868.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE1POWER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONE1POWER>>(v1);
    }

    // decompiled from Move bytecode v6
}

