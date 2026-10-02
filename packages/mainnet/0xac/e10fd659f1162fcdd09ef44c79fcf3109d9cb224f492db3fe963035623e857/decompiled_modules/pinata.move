module 0xace10fd659f1162fcdd09ef44c79fcf3109d9cb224f492db3fe963035623e857::pinata {
    struct PINATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PINATA>(arg0, 9, untag(b"SPINATA"), untag(x"4e5069c3b1617461"), untag(b"D||{\"website\":\"https://pinatasol.fun/\",\"telegram\":\"https://t.me/PinataSol\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiet26ncun6mprq4ojs4sk3fqvkvvojhmyjbm2hs2cxn3ug5unipxi"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<PINATA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<PINATA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PINATA>>(0x2::coin::mint<PINATA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

