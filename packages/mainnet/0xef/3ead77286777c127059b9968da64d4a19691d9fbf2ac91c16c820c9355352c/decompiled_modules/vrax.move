module 0xef3ead77286777c127059b9968da64d4a19691d9fbf2ac91c16c820c9355352c::vrax {
    struct VRAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: VRAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<VRAX>(arg0, 9, untag(b"SVRAX"), untag(b"NCommander VRAX"), untag(b"D||{\"twitter\":\"https://x.com/CommVRAX\",\"website\":\"https://commandervrax.space/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreie7c5ul6p6eeyvzn5bznbcpzmk227nyvtzluetaovewitqv3ducpy"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<VRAX>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<VRAX>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<VRAX>>(0x2::coin::mint<VRAX>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

