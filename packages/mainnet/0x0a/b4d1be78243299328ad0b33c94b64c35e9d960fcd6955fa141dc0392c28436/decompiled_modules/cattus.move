module 0xab4d1be78243299328ad0b33c94b64c35e9d960fcd6955fa141dc0392c28436::cattus {
    struct CATTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CATTUS>(arg0, 9, untag(b"SCATTUS"), untag(b"NCattus"), untag(x"44436574757320686173206120636174206e6f772e20596f7572206661766f726974652061717561746963206361742e20f09f8c8af09f90b1"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeiedv5ekrymi7xsvhkid7c5snnvdi2x4avlr7l72wrs6k6t2uwzc2y"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<CATTUS>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<CATTUS>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CATTUS>>(0x2::coin::mint<CATTUS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

