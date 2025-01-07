module 0x9a2611135ea3dac3ce3ebd85f73d683a0729f3cbec96b4aad36696a4381ed7d2::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOF>(arg0, 9, b"WOOF", b"Lost Dogs", b"Lost Dogs is an NFT survival game by Notcoin, where players take on the role of stray dogs in a post-apocalyptic world, earning and using $WOOF tokens to buy, trade, and upgrade items.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5e1561a-f3e3-4867-bd3e-b7691a6d6633-IMG_5896.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

