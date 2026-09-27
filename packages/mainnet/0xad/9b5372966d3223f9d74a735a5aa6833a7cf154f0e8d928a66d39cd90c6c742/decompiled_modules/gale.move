module 0xad9b5372966d3223f9d74a735a5aa6833a7cf154f0e8d928a66d39cd90c6c742::gale {
    struct GALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GALE>(arg0, 9, untag(b"SGALE"), untag(b"NGale Cat"), untag(x"4447616c652043617420e28094206c61756e63686564206f6e204d61656c7374726f6d20766961204f7572426c6173742e"), untag(b"I"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<GALE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<GALE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GALE>>(0x2::coin::mint<GALE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

