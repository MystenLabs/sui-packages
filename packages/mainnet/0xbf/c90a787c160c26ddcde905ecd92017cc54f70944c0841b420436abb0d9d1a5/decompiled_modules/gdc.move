module 0xbfc90a787c160c26ddcde905ecd92017cc54f70944c0841b420436abb0d9d1a5::gdc {
    struct GDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDC>(arg0, 9, b"GDC", b"GoddesCoin", b"MEME COIN FOR BLESSING THE GODDES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/449262ce-e42c-46bd-af32-246ba6b399c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

