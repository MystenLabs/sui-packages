module 0xca49c3aa35c1e4eb1ef096080b87084f989d21e5b2896c0667a2f6c01b172371::whirlpool {
    struct WHIRLPOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHIRLPOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<WHIRLPOOL>(arg0, 9, untag(b"SWHIRLPOOL"), untag(b"NWhirlpool"), untag(b"DA maelstrom is a powerful, violent whirlpool. Hold Whirlpool earn rewards in Maelstrom."), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeidbs323sqeb7csohznujopynhoz2ljpd4jpppjunrdjo4koh4icvu"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<WHIRLPOOL>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<WHIRLPOOL>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WHIRLPOOL>>(0x2::coin::mint<WHIRLPOOL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

