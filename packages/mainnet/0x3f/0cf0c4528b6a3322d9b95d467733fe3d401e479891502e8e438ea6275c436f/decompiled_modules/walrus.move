module 0x3f0cf0c4528b6a3322d9b95d467733fe3d401e479891502e8e438ea6275c436f::walrus {
    struct WALRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALRUS>(arg0, 9, b"WALRUS", b"Walrus", b"WALRUS Coin is a Meme coin, WALRUS released First on SUI blockchain with inspiration and main image from the WALRUS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0553989-2bcd-4fbc-88d7-a973227c799c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALRUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALRUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

