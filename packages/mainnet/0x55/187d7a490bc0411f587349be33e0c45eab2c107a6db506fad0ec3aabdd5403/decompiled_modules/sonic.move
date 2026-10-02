module 0x55187d7a490bc0411f587349be33e0c45eab2c107a6db506fad0ec3aabdd5403::sonic {
    struct SONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SONIC>(arg0, 9, untag(b"SSonic"), untag(b"NSonic Snipe Bot"), untag(b"D||{\"twitter\":\"https://x.com/SonicSnipeBot\",\"website\":\"https://www.sonicsnipebot.com/\",\"telegram\":\"https://t.me/SonicSnipePortal\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreibepdjsv7jbtjtoxxoxplijugcf7tqyljlb7zuffgvvdsiaf7gbzq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SONIC>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SONIC>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SONIC>>(0x2::coin::mint<SONIC>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

