module 0xeb2ee6e39644120989681dce6eec8dd8d42219122bb34419ea55d645929601eb::boy {
    struct BOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOY>(arg0, 9, b"BOY", b"boy", x"64656c69766572696e6720706c617966756c2070726f6669747320616e642061206275727374206f6620626f7969736820636861726d2120f09fa792f09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76887d2b-e21c-4163-a7b0-244a3432b7e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

