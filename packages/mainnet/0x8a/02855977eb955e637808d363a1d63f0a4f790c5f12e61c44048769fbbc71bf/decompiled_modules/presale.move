module 0x8a02855977eb955e637808d363a1d63f0a4f790c5f12e61c44048769fbbc71bf::presale {
    struct PresaleCreated has copy, drop {
        presale_id: 0x2::object::ID,
        admin: address,
        token_type_package_id: 0x2::object::ID,
        price_per_token: u64,
        start_time: u64,
        end_time: u64,
    }

    struct TokensBought has copy, drop {
        presale_id: 0x2::object::ID,
        buyer: address,
        sui_paid: u64,
        tokens_received: u64,
    }

    struct FundsWithdrawn has copy, drop {
        presale_id: 0x2::object::ID,
        admin: address,
        amount: u64,
    }

    struct UnsoldTokensWithdrawn has copy, drop {
        presale_id: 0x2::object::ID,
        admin: address,
        tokens_withdrawn: u64,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<T0>,
    }

    struct Presale<phantom T0> has store, key {
        id: 0x2::object::UID,
        admin: address,
        vault: Vault<T0>,
        price_per_token: u64,
        start_time: u64,
        end_time: u64,
        total_sold: u64,
        buyers: vector<address>,
        sui_funds: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun buy_tokens<T0>(arg0: &mut Presale<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.start_time, 1001);
        assert!(v0 <= arg0.end_time, 1002);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= arg0.price_per_token, 1003);
        let v2 = v1 / arg0.price_per_token;
        let v3 = v1 % arg0.price_per_token;
        assert!(0x2::coin::value<T0>(&arg0.vault.coin) >= v2, 1004);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.vault.coin, v2, arg3), 0x2::tx_context::sender(arg3));
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3, arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_funds, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_sold = arg0.total_sold + v2;
        let v4 = 0x2::tx_context::sender(arg3);
        if (!has_bought(&arg0.buyers, v4, 0)) {
            0x1::vector::push_back<address>(&mut arg0.buyers, v4);
        };
        let v5 = TokensBought{
            presale_id      : 0x2::object::id<Presale<T0>>(arg0),
            buyer           : v4,
            sui_paid        : v1,
            tokens_received : v2,
        };
        0x2::event::emit<TokensBought>(v5);
    }

    public entry fun create_presale<T0>(arg0: Vault<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = Presale<T0>{
            id              : 0x2::object::new(arg4),
            admin           : v0,
            vault           : arg0,
            price_per_token : arg1,
            start_time      : arg2,
            end_time        : arg3,
            total_sold      : 0,
            buyers          : 0x1::vector::empty<address>(),
            sui_funds       : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Presale<T0>>(v1);
        let v2 = PresaleCreated{
            presale_id            : 0x2::object::id<Presale<T0>>(&v1),
            admin                 : v0,
            token_type_package_id : xpn_type_id(),
            price_per_token       : arg1,
            start_time            : arg2,
            end_time              : arg3,
        };
        0x2::event::emit<PresaleCreated>(v2);
    }

    public entry fun create_vault<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id   : 0x2::object::new(arg1),
            coin : arg0,
        };
        0x2::transfer::transfer<Vault<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun has_bought(arg0: &vector<address>, arg1: address, arg2: u64) : bool {
        arg2 == 0x1::vector::length<address>(arg0) && false || *0x1::vector::borrow<address>(arg0, arg2) == arg1 || has_bought(arg0, arg1, arg2 + 1)
    }

    public entry fun withdraw_funds<T0>(arg0: &mut Presale<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 9999);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.end_time, 1005);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_funds), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg0.admin);
        let v1 = FundsWithdrawn{
            presale_id : 0x2::object::id<Presale<T0>>(arg0),
            admin      : arg0.admin,
            amount     : 0x2::coin::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<FundsWithdrawn>(v1);
    }

    public entry fun withdraw_unsold_tokens<T0>(arg0: Presale<T0>, arg1: &0x2::clock::Clock, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 9999);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.end_time, 1005);
        let Presale {
            id              : v0,
            admin           : v1,
            vault           : v2,
            price_per_token : _,
            start_time      : _,
            end_time        : _,
            total_sold      : _,
            buyers          : _,
            sui_funds       : v8,
        } = arg0;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        let Vault {
            id   : v9,
            coin : v10,
        } = v2;
        let v11 = v10;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, arg2);
        let v12 = UnsoldTokensWithdrawn{
            presale_id       : 0x2::object::id<Presale<T0>>(&arg0),
            admin            : v1,
            tokens_withdrawn : 0x2::coin::value<T0>(&v11),
        };
        0x2::event::emit<UnsoldTokensWithdrawn>(v12);
        0x2::object::delete(v0);
        0x2::object::delete(v9);
    }

    public fun xpn_type_id() : 0x2::object::ID {
        0x2::object::id_from_address(@0xb84629098ddc034e1eacd39915d77fd76240f18cf7fa2a3c64e0b90e07cce959)
    }

    // decompiled from Move bytecode v6
}

