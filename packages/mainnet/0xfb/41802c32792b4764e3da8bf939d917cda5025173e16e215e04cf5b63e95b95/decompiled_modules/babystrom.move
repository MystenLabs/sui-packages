module 0xfb41802c32792b4764e3da8bf939d917cda5025173e16e215e04cf5b63e95b95::babystrom {
    struct BABYSTROM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSTROM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BABYSTROM>(arg0, 9, untag(b"SBABYSTROM"), untag(b"NBaby Strom"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreibg75yukdqskbt2ztiroxl4grjhclxoua7wpn6cwt2h643euv5mtq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<BABYSTROM>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<BABYSTROM>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BABYSTROM>>(0x2::coin::mint<BABYSTROM>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

