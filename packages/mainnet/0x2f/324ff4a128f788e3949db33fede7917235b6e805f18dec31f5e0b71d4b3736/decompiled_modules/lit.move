module 0x2f324ff4a128f788e3949db33fede7917235b6e805f18dec31f5e0b71d4b3736::lit {
    struct LIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIT>(arg0, 6, b"LIT", b"LIT THE CAT", b"$LIT is a burned Entity born from the fire of the blockchain. The brother of Wet. A flare. A movement. Burning through Sui, rare, untamed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaq25cmmgswrv5cthkga6mgwwaiciblhfmjfexopvdilhpsja7eoe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LIT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

