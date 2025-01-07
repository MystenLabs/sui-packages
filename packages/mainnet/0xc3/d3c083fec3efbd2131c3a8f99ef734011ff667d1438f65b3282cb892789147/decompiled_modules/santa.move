module 0xc3d3c083fec3efbd2131c3a8f99ef734011ff667d1438f65b3282cb892789147::santa {
    struct SANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTA>(arg0, 9, b"SANTA", b"Santa", b"SANTA Coin is a Meme coin, SANTA released First on SUI blockchain with inspiration and main image from the SANTA.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/12a7e0d9-1e5b-4e81-bb5e-ee75ea4a1176.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

