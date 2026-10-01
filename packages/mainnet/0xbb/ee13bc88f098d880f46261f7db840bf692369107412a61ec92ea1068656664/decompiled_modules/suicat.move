module 0xbbee13bc88f098d880f46261f7db840bf692369107412a61ec92ea1068656664::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUICAT>(arg0, 9, untag(b"SSUICAT"), untag(b"NSuicat"), untag(b"D||{\"twitter\":\"https://x.com/Suicatdotsui\",\"website\":\"https://www.suicatcoin.com/\",\"telegram\":\"https://t.me/suicatdotsui\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreifjjbvw4265ehoqwql4vzi4lgdvghnfpsnjwkr4bhwzjagar6jpzi"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SUICAT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SUICAT>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUICAT>>(0x2::coin::mint<SUICAT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

