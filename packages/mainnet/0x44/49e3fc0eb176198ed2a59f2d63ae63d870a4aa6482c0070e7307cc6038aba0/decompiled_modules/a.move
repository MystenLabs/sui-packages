module 0x4449e3fc0eb176198ed2a59f2d63ae63d870a4aa6482c0070e7307cc6038aba0::a {
    struct A has drop {
        dummy_field: bool,
    }

    fun init(arg0: A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A>(arg0, 9, b"A", b"Aamir", b"Aamir Coin is a meme-inspired cryptocurrency that celebrates the joy of humor and community. With a limited supply and a passionate team behind it, AAMIR is poised to become the next big thing in the world of meme coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf8f2e22-7da5-4770-985a-e94d2b02bcf4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A>>(v1);
    }

    // decompiled from Move bytecode v6
}

