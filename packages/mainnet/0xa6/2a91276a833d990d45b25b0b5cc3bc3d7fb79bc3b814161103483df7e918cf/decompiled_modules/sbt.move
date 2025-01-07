module 0xa62a91276a833d990d45b25b0b5cc3bc3d7fb79bc3b814161103483df7e918cf::sbt {
    struct SBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBT>(arg0, 6, b"SBT", b"Sui Baby Tiger", b"First Reflexive Meme Coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731161017089.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

