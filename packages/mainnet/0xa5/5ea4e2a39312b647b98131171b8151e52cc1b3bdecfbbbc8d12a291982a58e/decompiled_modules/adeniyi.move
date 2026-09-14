module 0xa55ea4e2a39312b647b98131171b8151e52cc1b3bdecfbbbc8d12a291982a58e::adeniyi {
    struct ADENIYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADENIYI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ADENIYI>(arg0, 9, untag(b"SADENIYI"), untag(b"NSui Bull"), untag(b"DSui Bull"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreigcqmj4iu2cpnzcwi5v4re6ffyuqceclagx5m4rkpytq76zrakooi"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ADENIYI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ADENIYI>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ADENIYI>>(0x2::coin::mint<ADENIYI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

