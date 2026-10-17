module 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow {
    struct OutflowRegistry has key {
        id: 0x2::object::UID,
    }

    struct WindowKey has copy, drop, store {
        payee: address,
    }

    struct Sent has drop, store {
        hour: u64,
        amount: u64,
    }

    struct Held has drop, store {
        amount: u64,
        release_after_ms: u64,
    }

    struct OutflowWindow has key {
        id: 0x2::object::UID,
        payee: address,
        sent: vector<Sent>,
        held: vector<Held>,
        held_funds: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    struct PayoutHeldV1 has copy, drop {
        payee: address,
        amount: u64,
        release_after_ms: u64,
    }

    struct PayoutReleasedV1 has copy, drop {
        payee: address,
        amount: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OutflowRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<OutflowRegistry>(v0);
    }

    fun new_window(arg0: &mut OutflowRegistry, arg1: address) : OutflowWindow {
        let v0 = WindowKey{payee: arg1};
        OutflowWindow{
            id         : 0x2::derived_object::claim<WindowKey>(&mut arg0.id, v0),
            payee      : arg1,
            sent       : 0x1::vector::empty<Sent>(),
            held       : 0x1::vector::empty<Held>(),
            held_funds : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
        }
    }

    public(friend) fun open(arg0: &mut OutflowRegistry, arg1: address) {
        let v0 = WindowKey{payee: arg1};
        if (0x2::derived_object::exists<WindowKey>(&arg0.id, v0)) {
            return
        };
        0x2::transfer::share_object<OutflowWindow>(new_window(arg0, arg1));
    }

    public(friend) fun pay(arg0: &mut OutflowWindow, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x2::clock::Clock) : u64 {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        release_matured(arg0, v0);
        let v1 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::payout_limit_24h(arg1);
        let v2 = sent_in_window(arg0, v0);
        let v3 = if (v1 == 0) {
            0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2)
        } else if (v2 >= v1) {
            0
        } else {
            v1 - v2
        };
        split_and_send(arg0, arg2, v3, v0)
    }

    public(friend) fun pay_new(arg0: &mut OutflowRegistry, arg1: address, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg3: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::clock::Clock) : u64 {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg2);
        let v0 = WindowKey{payee: arg1};
        assert!(!0x2::derived_object::exists<WindowKey>(&arg0.id, v0), 0);
        let v1 = new_window(arg0, arg1);
        let v2 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::payout_limit_24h(arg2);
        let v3 = if (v2 == 0) {
            0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3)
        } else {
            v2
        };
        let v4 = &mut v1;
        0x2::transfer::share_object<OutflowWindow>(v1);
        split_and_send(v4, arg3, v3, 0x2::clock::timestamp_ms(arg4))
    }

    public fun payee(arg0: &OutflowWindow) : address {
        arg0.payee
    }

    entry fun release_delayed(arg0: &mut OutflowWindow, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0x2::deny_list::DenyList, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        if (0x2::coin::deny_list_v2_contains_current_epoch<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0.payee, arg4) || 0x2::coin::deny_list_v2_contains_next_epoch<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0.payee)) {
            return
        };
        release_matured(arg0, 0x2::clock::timestamp_ms(arg3));
    }

    fun release_matured(arg0: &mut OutflowWindow, arg1: u64) {
        let v0 = 0;
        while (!0x1::vector::is_empty<Held>(&arg0.held) && 0x1::vector::borrow<Held>(&arg0.held, 0).release_after_ms <= arg1) {
            let v1 = 0x1::vector::remove<Held>(&mut arg0.held, 0);
            v0 = v0 + v1.amount;
        };
        if (v0 > 0) {
            0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.held_funds, v0), arg0.payee);
            let v2 = PayoutReleasedV1{
                payee  : arg0.payee,
                amount : v0,
            };
            0x2::event::emit<PayoutReleasedV1>(v2);
        };
    }

    fun sent_in_window(arg0: &mut OutflowWindow, arg1: u64) : u64 {
        while (!0x1::vector::is_empty<Sent>(&arg0.sent) && 0x1::vector::borrow<Sent>(&arg0.sent, 0).hour + 24 < arg1 / 3600000) {
            0x1::vector::remove<Sent>(&mut arg0.sent, 0);
        };
        let v0 = 0;
        let v1 = &arg0.sent;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Sent>(v1)) {
            v0 = v0 + 0x1::vector::borrow<Sent>(v1, v2).amount;
            v2 = v2 + 1;
        };
        v0
    }

    fun split_and_send(arg0: &mut OutflowWindow, arg1: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: u64) : u64 {
        let v0 = arg3 / 3600000;
        let v1 = 0x1::u64::min(arg2, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1));
        if (v1 > 0) {
            let v2 = 0x1::vector::length<Sent>(&arg0.sent);
            if (v2 > 0 && 0x1::vector::borrow<Sent>(&arg0.sent, v2 - 1).hour == v0) {
                let v3 = 0x1::vector::borrow_mut<Sent>(&mut arg0.sent, v2 - 1);
                v3.amount = v3.amount + v1;
            } else {
                let v4 = Sent{
                    hour   : v0,
                    amount : v1,
                };
                0x1::vector::push_back<Sent>(&mut arg0.sent, v4);
            };
            0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1, v1), arg0.payee);
        };
        let v5 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        if (v5 == 0) {
            0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1);
            return v1
        };
        let v6 = (v0 + 1) * 3600000 + 86400000;
        let v7 = 0x1::vector::length<Held>(&arg0.held);
        if (v7 > 0 && 0x1::vector::borrow<Held>(&arg0.held, v7 - 1).release_after_ms == v6) {
            let v8 = 0x1::vector::borrow_mut<Held>(&mut arg0.held, v7 - 1);
            v8.amount = v8.amount + v5;
        } else {
            let v9 = Held{
                amount           : v5,
                release_after_ms : v6,
            };
            0x1::vector::push_back<Held>(&mut arg0.held, v9);
        };
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.held_funds, arg1);
        let v10 = PayoutHeldV1{
            payee            : arg0.payee,
            amount           : v5,
            release_after_ms : v6,
        };
        0x2::event::emit<PayoutHeldV1>(v10);
        v1
    }

    // decompiled from Move bytecode v7
}

