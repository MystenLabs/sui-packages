module 0xf601cd06b4913b07a3f8710c68100f338f21b68c49c59377c63199cdc390e053::suica {
    struct SUICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUICA>(arg0, 9, untag(b"SSUICA"), untag(b"NSuica The Rabbit"), untag(b"D||{\"twitter\":\"https://x.com/SuicaTheRabbit\",\"website\":\"https://suicatherabbit.xyz/\",\"telegram\":\"https://t.me/SuicaTheRabbit\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreig72srt36g7t6kvqzjh3bsjee4yvoz3ybtwsmsi7wlg53yr7gmagm"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SUICA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SUICA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUICA>>(0x2::coin::mint<SUICA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

