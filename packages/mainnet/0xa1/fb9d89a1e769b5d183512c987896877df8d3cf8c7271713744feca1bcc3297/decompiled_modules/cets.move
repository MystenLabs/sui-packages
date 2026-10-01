module 0xa1fb9d89a1e769b5d183512c987896877df8d3cf8c7271713744feca1bcc3297::cets {
    struct CETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CETS>(arg0, 9, untag(b"SCETS"), untag(b"NCets On Gold"), untag(b"D||{\"twitter\":\"https://x.com/cetsongold\",\"telegram\":\"https://t.me/https://t.me/cetsongold\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreibvtwlez7utb5wnwjlxfbf4ir6xyi6k3jrw7dkprasowfhdc3owci"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<CETS>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<CETS>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CETS>>(0x2::coin::mint<CETS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

