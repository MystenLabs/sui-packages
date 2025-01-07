module 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::pyth {
    public entry fun create_price() : 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_info::PriceInfo {
        0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_info::new_price_info(1663680747, 1663074349, 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_feed::new(0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::from_byte_vec(x"c6c75c89f14810ec1c54c03ab8f1864a4c4032791f05747f560faec380a695d1"), 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price::new(0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::i64::new(1557, false), 7, 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::i64::new(5, true), 1663680740), 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price::new(0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::i64::new(1500, false), 3, 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::i64::new(5, true), 1663680740)))
    }

    public entry fun get_price_unsafe(arg0: &0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_info::PriceInfoObject) : 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price::Price {
        let v0 = 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_info::get_price_info_from_price_info_object(arg0);
        0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_feed::get_price(0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_info::get_price_feed(&v0))
    }

    // decompiled from Move bytecode v6
}

