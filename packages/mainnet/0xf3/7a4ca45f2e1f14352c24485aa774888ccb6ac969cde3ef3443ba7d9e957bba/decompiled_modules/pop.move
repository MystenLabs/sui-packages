module 0xf37a4ca45f2e1f14352c24485aa774888ccb6ac969cde3ef3443ba7d9e957bba::pop {
    struct POP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<POP>(arg0, 6, 0x1::string::utf8(b"POP"), 0x1::string::utf8(b"POPULAR"), 0x1::string::utf8(b"The official token of POPULAR, the memecoin launchpad on Sui. Every creator fee buys POP back and burns it: supply only goes down. Launched on POPULAR with the same curve and rules as every other token."), 0x1::string::utf8(b"https://popularsui.xyz/media/e8130ab8f1049c7a003cc28856d4dea26e894f39d57d9bfc16fa097ba4a45a88.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<POP>>(0x2::coin_registry::finalize<POP>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

