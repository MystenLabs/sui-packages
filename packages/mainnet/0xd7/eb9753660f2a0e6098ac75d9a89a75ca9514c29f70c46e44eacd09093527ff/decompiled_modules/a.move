module 0xd7eb9753660f2a0e6098ac75d9a89a75ca9514c29f70c46e44eacd09093527ff::a {
    struct A has drop {
        dummy_field: bool,
    }

    fun init(arg0: A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A>(arg0, 9, b"A", b"Aamir", b"Aamir Coin is a meme-inspired cryptocurrency that celebrates the joy of humor and community. With a limited supply and a passionate team behind it, AAMIR is poised to become the next big thing in the world of meme coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc7b55d1-bcba-4aa4-a6b3-2a7e7e4ebfd2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A>>(v1);
    }

    // decompiled from Move bytecode v6
}

