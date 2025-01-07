module 0x7c72bbee0d81e25f2e68e57376f1f103efd147f682c18eab9e13025a43c11b0d::GG {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG>(arg0, 18, b"GG", b"Gnomes Gold", b"Gnomes Gold, the key to the Sui Gnomes universe. Stake your NFTs, earn GG, and unlock exclusive gnome experiences!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/bafybeicahrqhqhsgaihsc5232g677ee4rjo4i7pyr5pgnzlnp72fifl4wy/7bca318e-dd1f-4bba-8983-e6557d3ff7d8.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

