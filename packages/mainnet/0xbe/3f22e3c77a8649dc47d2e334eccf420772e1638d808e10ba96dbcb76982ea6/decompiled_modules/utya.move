module 0xbe3f22e3c77a8649dc47d2e334eccf420772e1638d808e10ba96dbcb76982ea6::utya {
    struct UTYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UTYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<UTYA>(arg0, 9, untag(b"SUTYA"), untag(b"NUtya"), untag(b"D||{\"twitter\":\"https://x.com/TonUtyacoin\",\"website\":\"https://tonutya.com/\",\"telegram\":\"https://t.me/UtyaDuck\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreibxjkvbzv2vps4ffd46sshwcnk7fw4dxbhjnydkbinrfvt5xxoqge"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<UTYA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<UTYA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<UTYA>>(0x2::coin::mint<UTYA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

