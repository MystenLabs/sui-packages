module 0xdd31afedfde1b65c819b21c5d07dcc16e4647c2c7b4e570d3e427bc12758acc::uss {
    struct USS has drop {
        dummy_field: bool,
    }

    fun init(arg0: USS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USS>(arg0, 9, b"USS", b"usa", b"usa ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7171e071-d017-4e0a-ad5c-96d24bdfb0e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USS>>(v1);
    }

    // decompiled from Move bytecode v6
}

