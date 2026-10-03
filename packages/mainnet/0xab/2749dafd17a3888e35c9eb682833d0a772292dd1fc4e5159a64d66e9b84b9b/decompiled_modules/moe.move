module 0xab2749dafd17a3888e35c9eb682833d0a772292dd1fc4e5159a64d66e9b84b9b::moe {
    struct MOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MOE>(arg0, 9, untag(b"SMOE"), untag(b"NMOE"), untag(b"D||{\"twitter\":\"https://x.com/nebula_moemate\",\"website\":\"https://www.moemate.io/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreihz46jflf3c4ka5zcdflmcuvsqa5fgkpzn43bgb4y6hnbdb6n7t2m"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<MOE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<MOE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOE>>(0x2::coin::mint<MOE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

