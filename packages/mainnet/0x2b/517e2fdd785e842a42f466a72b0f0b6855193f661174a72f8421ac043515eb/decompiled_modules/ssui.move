module 0x2b517e2fdd785e842a42f466a72b0f0b6855193f661174a72f8421ac043515eb::ssui {
    struct SSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SSUI>(arg0, 9, untag(b"SsSUI"), untag(b"NSpring SUI"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreid33ivolrf3kvj3sthc3flifgwangejgyk5bgmtmh5r5ibezwmvk4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SSUI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SSUI>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SSUI>>(0x2::coin::mint<SSUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

