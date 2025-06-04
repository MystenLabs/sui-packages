module 0x4f518273ee34c788a97bdde1685c3b8b74840ce97b0d2e9136eca5a8b945fc7a::sts {
    struct STS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STS>(arg0, 6, b"STS", b"Stitch On Sui", b"STITCH on SUI ($STS) is a meme coin built on the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidymnfdf6avzmccgoqwaichacgqmjoyxrvgaufsrjam73n7ptvy6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

