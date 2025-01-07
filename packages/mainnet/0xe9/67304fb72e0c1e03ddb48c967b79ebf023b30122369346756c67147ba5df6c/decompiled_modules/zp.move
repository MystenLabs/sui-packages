module 0xe967304fb72e0c1e03ddb48c967b79ebf023b30122369346756c67147ba5df6c::zp {
    struct ZP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZP>(arg0, 9, b"ZP", b"Zapia meme", b"This hotest meme in the market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/13defdfb-138d-4975-a4ae-d5eb3da602f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZP>>(v1);
    }

    // decompiled from Move bytecode v6
}

