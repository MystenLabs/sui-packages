module 0x2fd68a3e88dc0faa313369aacd80609da3c7666d99eacb23503691a5a47c9e95::pdc {
    struct PDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDC>(arg0, 9, b"PDC", b"PedeCoin", b"PedeCoin is a meme token representing confidence. Its logo features a cartoon character standing tall with arms raised, surrounded by positive elements like a rising sun. Bright colors reflect optimism and strength. Tagline: Be Confident, Be Pede!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/317371e7-7846-481e-8b7f-b7c6b3d9e172-IMG_1921.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

