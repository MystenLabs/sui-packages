module 0x2656fdcd75b2fc5e54554e173a357ecce037524e52a4a1b9c6d95dfe60b542b8::stonks {
    struct STONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<STONKS>(arg0, 9, untag(b"SSTONKS"), untag(b"NStonks"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeifhv53gcljy62jzflwwefqka4spnj2hxdn4atomgpdy2qhql567pe"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<STONKS>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<STONKS>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<STONKS>>(0x2::coin::mint<STONKS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

