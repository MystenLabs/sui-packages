module 0xa5afe847536c7de6531e4e4680368cc8496ccc4af72ba0ed0c7f915eb381f412::krilltoken {
    struct KRILLTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRILLTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRILLTOKEN>(arg0, 9, b"KRILLTOKEN", b"Krill ", b"Meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5225b9fd-9249-49c0-bf49-eb971d611e4b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRILLTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRILLTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

