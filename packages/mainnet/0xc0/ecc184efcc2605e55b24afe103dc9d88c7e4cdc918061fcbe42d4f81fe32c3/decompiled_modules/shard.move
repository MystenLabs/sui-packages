module 0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::shard {
    struct SHARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SHARD>(arg0, 7, 0x1::string::utf8(b"SHARD"), 0x1::string::utf8(b"SHARD"), 0x1::string::utf8(b"SHARD is the premium in-game currency for Cyberbrawl."), 0x1::string::utf8(b"https://static.cyberbrawl.io/shard_logo_512.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SHARD>>(0x2::coin_registry::finalize<SHARD>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

