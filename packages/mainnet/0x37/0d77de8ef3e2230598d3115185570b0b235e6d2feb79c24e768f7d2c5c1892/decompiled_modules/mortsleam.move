module 0x370d77de8ef3e2230598d3115185570b0b235e6d2feb79c24e768f7d2c5c1892::mortsleam {
    struct MORTSLEAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORTSLEAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MORTSLEAM>(arg0, 9, untag(b"SMORTSLEAM"), untag(b"NmortsleaM"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeibte2efksf65xeacp4uuawphrdgxxhq4vkstwcex5z4kwql5dtb4u"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<MORTSLEAM>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<MORTSLEAM>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MORTSLEAM>>(0x2::coin::mint<MORTSLEAM>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

