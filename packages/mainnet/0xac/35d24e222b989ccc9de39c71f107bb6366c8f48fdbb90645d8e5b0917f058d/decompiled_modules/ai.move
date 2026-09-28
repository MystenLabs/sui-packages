module 0xac35d24e222b989ccc9de39c71f107bb6366c8f48fdbb90645d8e5b0917f058d::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AI>(arg0, 9, 0x1::string::utf8(b"AI"), 0x1::string::utf8(b"Artificial Inu"), 0x1::string::utf8(x"546865206f6e2d636861696e20414920636f6d6d756e6974792e0d0a200d0a24414920706169726564207769746820636f6d7075746520706f7765722e0d0a457665727920747261646520666565647320746865205661756c742e0d0a457665727920666565206275726e6564206f72206c6f636b656420666f72657665722e0d0a200d0a54686520446f67204973204c6f6e6720436f6d707574652e20f09f90b6f09f928e"), 0x1::string::utf8(b"https://gateway.irys.xyz/bZoBflzGNjvHk01iFbOMv3w-NPLApKSjvxQQ8rVY7x4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<AI>>(0x2::coin::mint<AI>(&mut v2, 1000000000000000000, arg1), @0xaee02011bf4d87f12883268194b90c00c274b9dc191d06964467532e7aa947c0);
        0x2::coin_registry::make_supply_fixed_init<AI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<AI>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

