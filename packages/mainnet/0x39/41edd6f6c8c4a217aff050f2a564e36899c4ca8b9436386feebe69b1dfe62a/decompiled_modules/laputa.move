module 0x3941edd6f6c8c4a217aff050f2a564e36899c4ca8b9436386feebe69b1dfe62a::laputa {
    struct LAPUTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAPUTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LAPUTA>(arg0, 9, untag(b"SLAPUTA"), untag(b"NLaputa"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeia4vqs7aiqngrcjutuyj2wi2lbtmw77zx4zzrrosamzrw6qmdn4uy"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<LAPUTA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<LAPUTA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LAPUTA>>(0x2::coin::mint<LAPUTA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

