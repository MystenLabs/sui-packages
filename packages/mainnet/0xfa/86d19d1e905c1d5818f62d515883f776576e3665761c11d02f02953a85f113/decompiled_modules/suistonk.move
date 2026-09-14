module 0xfa86d19d1e905c1d5818f62d515883f776576e3665761c11d02f02953a85f113::suistonk {
    struct SUISTONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUISTONK>(arg0, 9, untag(b"SSUISTONK"), untag(b"NSui Stonk"), untag(b"DStonks at Sui"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeie5u2innujw7niigj7r3fqjtnsg3spbpzzwz47d2mnowktngykznq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SUISTONK>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SUISTONK>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISTONK>>(0x2::coin::mint<SUISTONK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

