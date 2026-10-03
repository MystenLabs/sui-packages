module 0x5e5e36685f1ab8b49e8421850e2e45a83d52d00f86e996806f158789a743eb82::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MOON>(arg0, 9, untag(b"SMOON"), untag(b"NMoonFun"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreig55g6lzdtud7rpgcmzeue2y7xhp4ebk3btq5opya766jbif73i7m"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<MOON>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<MOON>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOON>>(0x2::coin::mint<MOON>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

