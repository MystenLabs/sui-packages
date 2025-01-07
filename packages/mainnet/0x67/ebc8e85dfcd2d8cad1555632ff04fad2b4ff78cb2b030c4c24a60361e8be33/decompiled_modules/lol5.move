module 0x67ebc8e85dfcd2d8cad1555632ff04fad2b4ff78cb2b030c4c24a60361e8be33::lol5 {
    struct LOL5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL5>(arg0, 9, b"LOL5", b"gggg", b"tooooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/45c0551c-a3e1-4eed-ba26-c0ab0b47b63a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOL5>>(v1);
    }

    // decompiled from Move bytecode v6
}

