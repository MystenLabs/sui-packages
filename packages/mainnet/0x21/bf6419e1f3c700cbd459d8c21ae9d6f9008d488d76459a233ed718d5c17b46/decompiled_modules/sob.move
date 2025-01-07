module 0x21bf6419e1f3c700cbd459d8c21ae9d6f9008d488d76459a233ed718d5c17b46::sob {
    struct SOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOB>(arg0, 6, b"SOB", b"Sobbing Suippy", b"On the Sui blockchain, there was a crypto dog, lost among the countless tokens, wandering aimlessly in search of a home. Once a loyal companion in a world of smart contracts, it now drifted through wallets, forgotten and unloved. With every transaction, it yearned for a shelter, a place where it could belong once more.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/logo_Sui_31b5e1707e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

