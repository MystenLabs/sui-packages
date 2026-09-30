module 0x32938224996d8329956a129e087f4add0e23dd643e4b04c465925ad7ef58edaf::pop {
    struct POP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POP>(arg0, 9, b"POP", b"POPULAR", b"The official token of POPULAR, the memecoin launchpad on Sui. Every creator fee buys POP back and burns it: supply only goes down. Launched on POPULAR with the same curve and rules as every other token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://popularsui.xyz/media/e8130ab8f1049c7a003cc28856d4dea26e894f39d57d9bfc16fa097ba4a45a88.webp")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<POP>>(0x2::coin::mint<POP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

