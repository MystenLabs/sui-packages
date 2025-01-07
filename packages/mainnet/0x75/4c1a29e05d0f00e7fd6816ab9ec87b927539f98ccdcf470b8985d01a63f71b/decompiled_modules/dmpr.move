module 0x754c1a29e05d0f00e7fd6816ab9ec87b927539f98ccdcf470b8985d01a63f71b::dmpr {
    struct DMPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMPR>(arg0, 9, b"DMPR", b"Dumper", b"Meme Coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c1fec01-f992-40fc-a426-37d98560d3b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

