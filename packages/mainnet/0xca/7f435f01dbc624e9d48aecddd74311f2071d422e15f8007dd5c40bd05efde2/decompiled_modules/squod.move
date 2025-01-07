module 0xca7f435f01dbc624e9d48aecddd74311f2071d422e15f8007dd5c40bd05efde2::squod {
    struct SQUOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUOD>(arg0, 6, b"SQUOD", b"SQUOD SUI", b"Squod Sui is a new memecoin built on the Sui blockchain. Designed with a strong community focus, Squid Sui aims to be a leading meme coin within the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_195732758_75e4549002.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

