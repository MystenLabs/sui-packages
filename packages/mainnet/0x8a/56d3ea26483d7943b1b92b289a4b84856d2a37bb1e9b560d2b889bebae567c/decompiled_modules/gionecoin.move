module 0x8a56d3ea26483d7943b1b92b289a4b84856d2a37bb1e9b560d2b889bebae567c::gionecoin {
    struct GIONECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIONECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIONECOIN>(arg0, 9, b"GIONECOIN", b"GIONE", b"Top meme gione coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e894d29e-f1e1-4a51-9cf0-a62c99f2db6a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIONECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIONECOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

