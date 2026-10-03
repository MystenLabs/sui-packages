module 0x6f9c4e2de4f86ec51c69c7149125b4e1e9120dd56d9b2c6f904a0770c1e65337::chirp {
    struct CHIRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHIRP>(arg0, 9, untag(b"SCHIRP"), untag(b"NChirp Token"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreidchoygbtoabpo2buduyuz4vrym5zxosclpyp6kn4qrihkush3yxu"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<CHIRP>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<CHIRP>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHIRP>>(0x2::coin::mint<CHIRP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

