module 0xbecf7860d30cd946d4a8c6a27212b9a2b70ae3a82d4e35e49f3aab52e5fc924d::feet {
    struct FEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FEET>(arg0, 9, untag(b"SFEET"), untag(b"NFeet"), untag(b"D||{\"twitter\":\"https://x.com/cussysss/status/2106035650256626080?s=46\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreihxmjensxesee7k6h6b5xdjuqxbjnzqkb75zwz5ig7ldwqvfo22xu"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<FEET>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<FEET>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FEET>>(0x2::coin::mint<FEET>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

