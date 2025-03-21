module 0x3ef8400c9c635202601b832acf33e9f52fc20b75b21669b9719af8d0f42d103c::flux_zone_utils {
    struct TokensTransferredWithTax has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
        tax_amount: u64,
        tax_recipient: address,
        is_buy: bool,
        is_sell: bool,
        is_whitelisted: bool,
        is_tax_enabled: bool,
    }

    public fun check_balance(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        0
    }

    public fun format_amount(arg0: u64) : 0x1::string::String {
        let v0 = arg0 % 1000000000;
        let v1 = num_to_string(arg0 / 1000000000);
        if (v0 > 0) {
            0x1::string::append(&mut v1, 0x1::string::utf8(b"."));
            let v2 = num_to_string(v0);
            let v3 = 0x1::string::length(&v2);
            if (v3 < 9) {
                let v4 = 0x1::vector::empty<u8>();
                let v5 = 0;
                while (v5 < 9 - v3) {
                    0x1::vector::push_back<u8>(&mut v4, 48);
                    v5 = v5 + 1;
                };
                0x1::string::append(&mut v1, 0x1::string::utf8(v4));
            };
            0x1::string::append(&mut v1, v2);
            while (0x1::string::length(&v1) > 0 && 0x1::string::utf8(b"0") == 0x1::string::substring(&v1, 0x1::string::length(&v1) - 1, 0x1::string::length(&v1))) {
                let v6 = &v1;
                let v7 = 0x1::string::length(&v1) - 1;
                v1 = 0x1::string::substring(v6, 0, v7);
            };
            if (0x1::string::length(&v1) > 0 && 0x1::string::utf8(b".") == 0x1::string::substring(&v1, 0x1::string::length(&v1) - 1, 0x1::string::length(&v1))) {
                let v8 = &v1;
                let v9 = 0x1::string::length(&v1) - 1;
                v1 = 0x1::string::substring(v8, 0, v9);
            };
        };
        v1
    }

    fun num_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun transfer_tokens_with_tax(arg0: 0x2::coin::Coin<0x3ef8400c9c635202601b832acf33e9f52fc20b75b21669b9719af8d0f42d103c::flux_coin::FLUX_COIN>, arg1: address, arg2: bool, arg3: bool, arg4: u64, arg5: &0x3ef8400c9c635202601b832acf33e9f52fc20b75b21669b9719af8d0f42d103c::flux_coin::GlobalConfig, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x3ef8400c9c635202601b832acf33e9f52fc20b75b21669b9719af8d0f42d103c::flux_coin::FLUX_COIN>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg6);
        let (_, _, _, v5, v6) = 0x3ef8400c9c635202601b832acf33e9f52fc20b75b21669b9719af8d0f42d103c::flux_coin::get_tax_config(arg5);
        let v7 = 0x3ef8400c9c635202601b832acf33e9f52fc20b75b21669b9719af8d0f42d103c::flux_coin::is_whitelisted(arg5, v1) || 0x3ef8400c9c635202601b832acf33e9f52fc20b75b21669b9719af8d0f42d103c::flux_coin::is_whitelisted(arg5, arg1);
        let v8 = if (!v6 || v7) {
            0
        } else {
            0x3ef8400c9c635202601b832acf33e9f52fc20b75b21669b9719af8d0f42d103c::flux_coin::calculate_tax(v0, arg4)
        };
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x3ef8400c9c635202601b832acf33e9f52fc20b75b21669b9719af8d0f42d103c::flux_coin::FLUX_COIN>>(0x2::coin::split<0x3ef8400c9c635202601b832acf33e9f52fc20b75b21669b9719af8d0f42d103c::flux_coin::FLUX_COIN>(&mut arg0, v8, arg6), v5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x3ef8400c9c635202601b832acf33e9f52fc20b75b21669b9719af8d0f42d103c::flux_coin::FLUX_COIN>>(arg0, arg1);
        let v9 = TokensTransferredWithTax{
            sender         : v1,
            recipient      : arg1,
            amount         : v0,
            tax_amount     : v8,
            tax_recipient  : v5,
            is_buy         : arg2,
            is_sell        : arg3,
            is_whitelisted : v7,
            is_tax_enabled : v6,
        };
        0x2::event::emit<TokensTransferredWithTax>(v9);
    }

    // decompiled from Move bytecode v6
}

