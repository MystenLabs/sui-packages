module 0xadfc88f5a86657f706b6520cf7202f5fa1780d21222923307d6fe1b520d381e7::one {
    struct ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ONE>(arg0, 9, untag(b"SONE"), untag(b"NJustOneSui"), untag(b"D||{\"twitter\":\"https://x.com/just1sui\",\"website\":\"https://justonesui.com/\",\"telegram\":\"https://t.me/justonesuicto\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreighwvjgciroocwyuiw2e55mmp47yk3h7jdnthctwqxo2nnaarvgmi"), arg1);
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

