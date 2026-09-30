module 0xce6e02edec2244d514c758abd14f8f0a3a949b0acffd2a3b8e47183dcd903999::esui {
    struct ESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ESUI>(arg0, 9, untag(b"SeSUI"), untag(b"NEmber SUI"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreibrkq7qlexugjocrsgxqnoq7ilulv2wvggqz5ku5kjlkmq6q2zyoq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ESUI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ESUI>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ESUI>>(0x2::coin::mint<ESUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

