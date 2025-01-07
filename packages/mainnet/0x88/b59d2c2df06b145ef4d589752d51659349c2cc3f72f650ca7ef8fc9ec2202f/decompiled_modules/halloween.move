module 0x88b59d2c2df06b145ef4d589752d51659349c2cc3f72f650ca7ef8fc9ec2202f::halloween {
    struct HALLOWEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOWEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLOWEEN>(arg0, 9, b"HALLOWEEN", b"Halloween", b"HALLOWEEN Coin is a Meme coin, released on SUI blockchain with inspiration and main image from the HALLOWEEN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/40cc0b3c-a115-4fe3-b62e-e306b74d2465.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLOWEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HALLOWEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

