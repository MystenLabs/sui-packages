module 0x3922ac7a06056c435ad038bdfb3d9fc5d6de6397df8a92c90860e5c95ba0d76c::mori {
    struct MORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MORI>(arg0, 9, untag(b"SMORI"), untag(b"NMORI COIN"), untag(b"D||{\"twitter\":\"https://x.com/moricoinmeme\",\"website\":\"https://morico.in/\",\"telegram\":\"https://t.me/moricoineng\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreig5mxu7sjxxfn7wpide5de5q2sxeo27xuhktgi6mv2dlxsye2p3xm"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<MORI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<MORI>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MORI>>(0x2::coin::mint<MORI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

