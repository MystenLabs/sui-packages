module 0xd22044b3f5789d25347f5ea814329376b4df6af7945d92f394be0f44037ce576::msh {
    struct MSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSH>(arg0, 9, b"MSH", b"Mushrooms", b"Panter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c6ee617-8350-48f5-860a-f6b2dfea526a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

