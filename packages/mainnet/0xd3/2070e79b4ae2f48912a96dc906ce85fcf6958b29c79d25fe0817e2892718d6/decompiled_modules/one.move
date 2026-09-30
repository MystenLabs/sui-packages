module 0xd32070e79b4ae2f48912a96dc906ce85fcf6958b29c79d25fe0817e2892718d6::one {
    struct ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ONE>(arg0, 9, untag(b"SONE"), untag(b"NJustOneSui"), untag(b"D||{\"twitter\":\"https://x.com/just1sui\",\"website\":\"https://justonesui.com\",\"telegram\":\"https://t.me/justonesuicto\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreic54m3i72ecxix6iqygtwwp2xa6uvbwnftzrikebahecy6xo2ydcy"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ONE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ONE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ONE>>(0x2::coin::mint<ONE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

