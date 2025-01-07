module 0xb7ebae4bec9ffb1e6d08a32bd6a65e9582ad84ffe39314b4561a8154a33d4644::pdc {
    struct PDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDC>(arg0, 9, b"PDC", b"PedeCoin", b"PedeCoin is a meme token representing confidence. Its logo features a cartoon character standing tall with arms raised, surrounded by positive elements like a rising sun. Bright colors reflect optimism and strength. Tagline: Be Confident, Be Pede!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e620a967-b0a6-441e-9c29-09ab3e12ea23-IMG_1921.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

