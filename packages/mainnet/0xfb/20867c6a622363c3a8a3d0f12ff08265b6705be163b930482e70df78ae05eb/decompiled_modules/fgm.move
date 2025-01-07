module 0xfb20867c6a622363c3a8a3d0f12ff08265b6705be163b930482e70df78ae05eb::fgm {
    struct FGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGM>(arg0, 9, b"FGM", b"Frog meme ", b"Frog meme is a good token to buy now because its higher value and also driving by the community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba385f67-c629-4992-a495-9a0de4e5213a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FGM>>(v1);
    }

    // decompiled from Move bytecode v6
}

