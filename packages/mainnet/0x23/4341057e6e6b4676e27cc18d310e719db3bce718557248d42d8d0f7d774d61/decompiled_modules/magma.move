module 0x234341057e6e6b4676e27cc18d310e719db3bce718557248d42d8d0f7d774d61::magma {
    struct MAGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MAGMA>(arg0, 9, untag(b"SMAGMA"), untag(b"NMagma Token"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreihzqruw2jhz4sihh2oorwyq44cragyhngrxvprdespoguyu7vejbi"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<MAGMA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<MAGMA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MAGMA>>(0x2::coin::mint<MAGMA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

