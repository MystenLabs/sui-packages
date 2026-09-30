module 0x60329bd1f85838b1230c14cec28763dfe70db83033350684821af5b327668f8::golden {
    struct GOLDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GOLDEN>(arg0, 9, untag(b"SGOLDEN"), untag(b"NGolden Kitty"), untag(b"D||{\"twitter\":\"https://x.com/golden_kitty_rh\",\"website\":\"https://goldenkitty.vip/\",\"telegram\":\"https://t.me/golden_kitty\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiblbftfsyrekozmbpy5vnct2oa3mwrbgm2mvs3mhut25z53zlwlge"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<GOLDEN>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<GOLDEN>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GOLDEN>>(0x2::coin::mint<GOLDEN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

