module 0xf75fcb3f1598df11c71af580d8df05f551ed8f2c318c6f354c6c2c953eb09404::zuk {
    struct ZUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ZUK>(arg0, 9, untag(b"SZUK"), untag(b"NZuk"), untag(b"D||{\"website\":\"https://perpsplexity.app/zuk\",\"telegram\":\"https://t.me/perpsplexity\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreidia5skrlduvwyrqhlq23uss6rcokek4jjweppcfrbfqeonsjffvq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ZUK>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ZUK>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ZUK>>(0x2::coin::mint<ZUK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

