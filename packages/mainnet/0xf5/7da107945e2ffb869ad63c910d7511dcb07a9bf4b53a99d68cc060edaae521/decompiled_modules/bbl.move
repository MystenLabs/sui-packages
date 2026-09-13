module 0xf57da107945e2ffb869ad63c910d7511dcb07a9bf4b53a99d68cc060edaae521::bbl {
    struct BBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BBL>(arg0, 9, untag(b"SBBL"), untag(b"NBBL"), untag(b"DBBL OP"), untag(b"Ihttps://gateway.pinata.cloud/ipfs/Qmco3gKEW5dKyxv1444XZxUe53sNmr6gGYxEc15Yn7ckgU"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<BBL>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<BBL>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BBL>>(0x2::coin::mint<BBL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

