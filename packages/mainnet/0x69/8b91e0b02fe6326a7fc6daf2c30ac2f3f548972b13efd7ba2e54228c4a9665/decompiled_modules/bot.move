module 0x698b91e0b02fe6326a7fc6daf2c30ac2f3f548972b13efd7ba2e54228c4a9665::bot {
    struct BOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOT>(arg0, 9, b"BOT", b"SUIBotics", b"In the year 2050, SuiBotics ruled the blockchain. These AI agents traded, governed, and outwitted humans on Sui, leaving us to cheer for their efficiency while they optimized everything - except us. The future was not human, it was protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQpQ52Eow1eFTaR8y8crT7AU3eosVq4mfVtqwKW5oiLqv")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOT>(&mut v2, 1000000000000000000, @0xae42d2ec4d8ad9708972e523c8aad72bdd89ee7df04afc8a221545ac9577763c, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

