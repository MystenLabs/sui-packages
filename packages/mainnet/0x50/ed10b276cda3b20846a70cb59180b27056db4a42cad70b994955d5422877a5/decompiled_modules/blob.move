module 0x50ed10b276cda3b20846a70cb59180b27056db4a42cad70b994955d5422877a5::blob {
    struct BLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BLOB>(arg0, 9, untag(b"SBLOB"), untag(b"NBlobfish"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreifbk5zygho3zzitk22lple5gyo5kber54ewbvrin2q4p2efggtqy4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<BLOB>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<BLOB>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BLOB>>(0x2::coin::mint<BLOB>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

