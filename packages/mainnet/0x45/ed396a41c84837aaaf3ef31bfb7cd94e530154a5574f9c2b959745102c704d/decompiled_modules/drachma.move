module 0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::drachma {
    struct DRACHMA has drop {
        dummy_field: bool,
    }

    struct Minted has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct Spent has copy, drop {
        user: address,
        amount: u64,
    }

    struct Transferred has copy, drop {
        recipient: address,
        sender: address,
        amount: u64,
    }

    public fun from_coin(arg0: &0x2::token::TokenPolicy<DRACHMA>, arg1: 0x2::coin::Coin<DRACHMA>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<DRACHMA> {
        let (v0, v1) = 0x2::token::from_coin<DRACHMA>(arg1, arg2);
        let v2 = v1;
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::deny_list::verify<DRACHMA>(arg0, &mut v2, arg2);
        let (_, _, _, _) = 0x2::token::confirm_request<DRACHMA>(arg0, v2, arg2);
        v0
    }

    public entry fun spend(arg0: &mut 0x2::token::TokenPolicy<DRACHMA>, arg1: &mut 0x2::token::Token<DRACHMA>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::token::spend<DRACHMA>(0x2::token::split<DRACHMA>(arg1, arg2, arg3), arg3);
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::deny_list::verify<DRACHMA>(arg0, &mut v0, arg3);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<DRACHMA>(arg0, v0, arg3);
        let v5 = Spent{
            user   : 0x2::tx_context::sender(arg3),
            amount : arg2,
        };
        0x2::event::emit<Spent>(v5);
    }

    public fun split(arg0: &mut 0x2::token::Token<DRACHMA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<DRACHMA> {
        0x2::token::split<DRACHMA>(arg0, arg1, arg2)
    }

    public fun to_coin(arg0: &0x2::token::TokenPolicy<DRACHMA>, arg1: 0x2::token::Token<DRACHMA>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DRACHMA> {
        let (v0, v1) = 0x2::token::to_coin<DRACHMA>(arg1, arg2);
        let v2 = v1;
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::deny_list::verify<DRACHMA>(arg0, &mut v2, arg2);
        let (_, _, _, _) = 0x2::token::confirm_request<DRACHMA>(arg0, v2, arg2);
        v0
    }

    public fun transfer(arg0: &0x2::token::TokenPolicy<DRACHMA>, arg1: 0x2::token::Token<DRACHMA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::token::transfer<DRACHMA>(arg1, arg2, arg3);
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::deny_list::verify<DRACHMA>(arg0, &mut v0, arg3);
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::allow_list::verify<DRACHMA>(arg0, &mut v0, arg3);
        let (_, _, _, _) = 0x2::token::confirm_request<DRACHMA>(arg0, v0, arg3);
        let v5 = Transferred{
            recipient : arg2,
            sender    : 0x2::tx_context::sender(arg3),
            amount    : 0x2::token::value<DRACHMA>(&arg1),
        };
        0x2::event::emit<Transferred>(v5);
    }

    public fun get_balance(arg0: &0x2::token::Token<DRACHMA>) : u64 {
        0x2::token::value<DRACHMA>(arg0)
    }

    fun init(arg0: DRACHMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRACHMA>(arg0, 9, b"DP", b"DRACHMA POINT", x"44726163686d6120506f696e7420284450292069732064657369676e656420746f20656e636f757261676520636f6d6d756e6974792070617274696369706174696f6e20696e20746865204f6c796d7069616e2047616d65732065636f73797374656d207072696f7220746f20746865206f6666696369616c20546f6b656e2047656e65726174696f6e204576656e74202854474529206f6620534f582c20746865206f6666696369616c20746f6b656e206f66204f6c796d7069616e2047616d65732e2044502077696c6c20656e61626c652067616d65727320746f20656e74657220696e746f20746865204c6561677565206f6620534b5948494c4c20746f20706172746963697061746520696e2074686520426574612073657276696365206f6620746865204f6c796d7069616e2047616d65732e204450207574696c697a657320436c6f736564204c6f6f7020546f6b656e2028434c542920746563686e6f6c6f67792c2066756e6374696f6e696e67206578636c75736976656c7920666f72206561726c7920616363657373206f662067616d657320616e642073657276696365732077697468696e20746865204f6c796d7069616e2047616d657320706c6174666f726d2e2042792064657369676e2c2044502063616e6e6f74206265207472616e73666572726564206f7220747261646564206265747765656e206163636f756e747320616e642077696c6c206f6e6c7920626520617661696c61626c6520756e74696c20534f58205447452e20486f77657665722c206561726c7920616363657373207061727469636970616e7473207574696c697a696e672044502077696c6c20686176652066756c6c2061636365737320746f207468652067616d65e2809973207265776172642073797374656d2061732077656c6c2061732061636365737320746f20436f726e75636f706961206465706f736974732e20416c6c20445020616363756d756c6174656420627920656163682067616d657220647572696e67207468652041697264726f702043616d706169676e2c2077696c6c2062652065786368616e67656420746f20534f582075706f6e205447452e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://web-asset.unitedgames.com/tokens/dp.png"))), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<DRACHMA>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::add_rule_for_action<DRACHMA, 0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::allow_list::Allowlist>(&mut v6, &v5, 0x2::token::transfer_action(), arg1);
        0x2::token::add_rule_for_action<DRACHMA, 0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::deny_list::Denylist>(&mut v6, &v5, 0x2::token::transfer_action(), arg1);
        0x2::token::add_rule_for_action<DRACHMA, 0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::deny_list::Denylist>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        0x2::token::add_rule_for_action<DRACHMA, 0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::deny_list::Denylist>(&mut v6, &v5, 0x2::token::to_coin_action(), arg1);
        0x2::token::add_rule_for_action<DRACHMA, 0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::deny_list::Denylist>(&mut v6, &v5, 0x2::token::from_coin_action(), arg1);
        let v7 = 0x1::vector::empty<address>();
        let v8 = &mut v7;
        0x1::vector::push_back<address>(v8, 0x2::tx_context::sender(arg1));
        0x1::vector::push_back<address>(v8, @0x3b0601b8a1e62e43860cc93d1fc51d2d0b44c67a0db2d4d375dddc01e6b79d36);
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::allow_list::add_records<DRACHMA>(&mut v6, &v5, v7, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRACHMA>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<DRACHMA>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRACHMA>>(v1);
        0x2::token::share_policy<DRACHMA>(v6);
    }

    public entry fun merge(arg0: &mut 0x2::token::Token<DRACHMA>, arg1: 0x2::token::Token<DRACHMA>) {
        0x2::token::join<DRACHMA>(arg0, arg1);
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<DRACHMA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 100);
        let v0 = total_supply(arg0);
        assert!(v0 + arg1 <= 10000000000000000000, 101);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<DRACHMA>(arg0, 0x2::token::transfer<DRACHMA>(0x2::token::mint<DRACHMA>(arg0, arg1, arg3), arg2, arg3), arg3);
        let v5 = Minted{
            recipient : arg2,
            amount    : arg1,
        };
        0x2::event::emit<Minted>(v5);
    }

    public entry fun split_and_transfer(arg0: &0x2::token::TokenPolicy<DRACHMA>, arg1: &mut 0x2::token::Token<DRACHMA>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::token::transfer<DRACHMA>(0x2::token::split<DRACHMA>(arg1, arg2, arg4), arg3, arg4);
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::deny_list::verify<DRACHMA>(arg0, &mut v0, arg4);
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::allow_list::verify<DRACHMA>(arg0, &mut v0, arg4);
        let (_, _, _, _) = 0x2::token::confirm_request<DRACHMA>(arg0, v0, arg4);
        let v5 = Transferred{
            recipient : arg3,
            sender    : 0x2::tx_context::sender(arg4),
            amount    : arg2,
        };
        0x2::event::emit<Transferred>(v5);
    }

    public fun total_supply(arg0: &mut 0x2::coin::TreasuryCap<DRACHMA>) : u64 {
        0x2::balance::supply_value<DRACHMA>(0x2::coin::supply<DRACHMA>(arg0))
    }

    // decompiled from Move bytecode v6
}

