module 0x1cf2cc37585716f1c86f49b09ffebfcb334d672998cbcb0300c59d3073c436e2::animecoin {
    struct ANIMECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIMECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANIMECOIN>(arg0, 9, b"ANIMECOIN", b"AnimeWorld", b"Anime Coin Create is completed. Project is Anime Episodes And Movies. Toys Products is Sell Trading is future is Pumping for Coin Up Successfully.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9fd4a2b-f860-438d-9300-1a32316d4520.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIMECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANIMECOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

