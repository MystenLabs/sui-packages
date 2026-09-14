module 0xe6e4ca61330c94917b1e460277d8db60e93121787e753271bbce4c42eb7731ea::barc {
    struct BARC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BARC>(arg0, 9, untag(b"SBARC"), untag(b"NBARC"), untag(x"44537569e28099732042696c6c696f6e2d446f6c6c6172204261726b2e"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreidqmw2jdey3jghdf7wl3mvxztq6u5movnzxd4fqz5htzk3wl55wpi"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<BARC>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<BARC>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BARC>>(0x2::coin::mint<BARC>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

