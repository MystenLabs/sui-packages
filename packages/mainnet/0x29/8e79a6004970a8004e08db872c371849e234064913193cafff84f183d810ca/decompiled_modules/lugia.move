module 0x298e79a6004970a8004e08db872c371849e234064913193cafff84f183d810ca::lugia {
    struct LUGIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUGIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LUGIA>(arg0, 9, untag(b"SLUGIA"), untag(b"NSilver Strom 0x577a8addf60a34d4c705914ad066a3b28c3fc40d365ed0d9d"), untag(x"44404f7572626c617374626f742054657374696e67206f6e20406d61656c7374726f6d646f7478797a0a2e2e200a404f7572626c617374626f74206465706c6f7920244c55474941206e616d652053696c766572205374726f6d206f6e206d61656c7374726f6d207061697265642077697468203078353737613861646466363061333464346337303539313461643036366133623238633366633430643336356564306439646663343038663239623437323564333a3a626c6173743a3a424c4153542068747470733a2f2f742e636f2f6831653449395245784e"), untag(b"Ihttps://pbs.twimg.com/media/HTTx7VgawAAcxE4.jpg"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<LUGIA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<LUGIA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LUGIA>>(0x2::coin::mint<LUGIA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

