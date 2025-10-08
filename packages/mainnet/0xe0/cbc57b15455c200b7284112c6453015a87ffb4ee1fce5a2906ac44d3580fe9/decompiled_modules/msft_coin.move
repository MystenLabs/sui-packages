module 0xe0cbc57b15455c200b7284112c6453015a87ffb4ee1fce5a2906ac44d3580fe9::msft_coin {
    struct MSFT_COIN has drop {
        dummy_field: bool,
    }

    struct MSFTTreasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<MSFT_COIN>,
    }

    public entry fun burn(arg0: &mut MSFTTreasury, arg1: &mut 0xe0cbc57b15455c200b7284112c6453015a87ffb4ee1fce5a2906ac44d3580fe9::registry::StockRegistry, arg2: 0x2::coin::Coin<MSFT_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<MSFT_COIN>(&arg2);
        0x2::coin::burn<MSFT_COIN>(&mut arg0.cap, arg2);
        0xe0cbc57b15455c200b7284112c6453015a87ffb4ee1fce5a2906ac44d3580fe9::registry::update_supply(arg1, v0, false);
        0xe0cbc57b15455c200b7284112c6453015a87ffb4ee1fce5a2906ac44d3580fe9::registry::emit_burn_event(0x1::string::utf8(b"MSFT"), v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun mint(arg0: &0xe0cbc57b15455c200b7284112c6453015a87ffb4ee1fce5a2906ac44d3580fe9::registry::MinterCap, arg1: &mut MSFTTreasury, arg2: &mut 0xe0cbc57b15455c200b7284112c6453015a87ffb4ee1fce5a2906ac44d3580fe9::registry::StockRegistry, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"MSFT");
        0xe0cbc57b15455c200b7284112c6453015a87ffb4ee1fce5a2906ac44d3580fe9::registry::verify_mint_authorization(arg0, arg2, &v0, arg7);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&arg4)) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg4, v2));
            v2 = v2 + 1;
        };
        0xe0cbc57b15455c200b7284112c6453015a87ffb4ee1fce5a2906ac44d3580fe9::registry::record_backing_proof(arg2, arg4, arg5, arg3, arg6, v0, arg7);
        0xe0cbc57b15455c200b7284112c6453015a87ffb4ee1fce5a2906ac44d3580fe9::registry::update_supply(arg2, arg3, true);
        0xe0cbc57b15455c200b7284112c6453015a87ffb4ee1fce5a2906ac44d3580fe9::registry::emit_mint_event(0x1::string::utf8(b"MSFT"), arg3, arg6, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MSFT_COIN>>(0x2::coin::mint<MSFT_COIN>(&mut arg1.cap, arg3, arg7), arg6);
    }

    fun init(arg0: MSFT_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSFT_COIN>(arg0, 8, b"MSFTx", b"Microsoft Synthetic Stock", b"Synthetic Microsoft stock backed 1:1 by Backed Finance MSFT tokens on Solana", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSFT_COIN>>(v1);
        let v2 = MSFTTreasury{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::share_object<MSFTTreasury>(v2);
    }

    // decompiled from Move bytecode v6
}

