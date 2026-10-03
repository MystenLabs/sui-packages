module 0x559434bb0b08390b082cecba36d4cfef557e550f81a57032fea61ac3fada5ca2::goated {
    struct GOATED has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GOATED>(arg0, 9, untag(b"SGOATED"), untag(b"NGOAT Network"), untag(b"D||{\"twitter\":\"https://x.com/GOATRollup\",\"website\":\"https://www.goat.network/\",\"telegram\":\"https://t.me/GOATrollup\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreic6bvktbheik6s4sn4y5vhgawyx4ld64zu7y4rgzxgnazk3flwsa4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<GOATED>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<GOATED>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GOATED>>(0x2::coin::mint<GOATED>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

