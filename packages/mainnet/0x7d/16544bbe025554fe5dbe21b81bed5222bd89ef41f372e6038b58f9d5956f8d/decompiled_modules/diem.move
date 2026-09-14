module 0x7d16544bbe025554fe5dbe21b81bed5222bd89ef41f372e6038b58f9d5956f8d::diem {
    struct DIEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DIEM>(arg0, 9, untag(b"SDIEM"), untag(b"Ndiem"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreifwpodcug7tvyrzzy74wdzk3vhruafr3t4x2z6v3modnlg74yjn54"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<DIEM>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<DIEM>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DIEM>>(0x2::coin::mint<DIEM>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

