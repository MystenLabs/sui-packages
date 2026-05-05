module 0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::koju {
    struct KOJU has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        balance_usdc: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        balance_warped: 0x2::balance::Balance<0x50c9c77f29de11a2abdbe60e0869a026dc47c94bfc4e7d461c80313b079d44d2::warped::WARPED>,
        treasury_cap: 0x2::coin::TreasuryCap<KOJU>,
    }

    struct PurchaseKojuWithFiatRequest has drop {
        koju_amount: u64,
        price: u64,
        fiat_currency: 0x1::string::String,
        nonce: vector<u8>,
        timestamp: u64,
        recipient: address,
    }

    struct PurchaseKojuRequest has drop {
        koju_amount: u64,
        price: u64,
        nonce: vector<u8>,
        timestamp: u64,
        recipient: address,
    }

    struct MintKojuRequest has drop {
        koju_amount: u64,
        nonce: vector<u8>,
        timestamp: u64,
        recipient: address,
    }

    struct KojuPurchasedEvent has copy, drop {
        recipient: address,
        koju_amount: u64,
        payment_price: u64,
        payment_currency: 0x1::string::String,
        purchaser: address,
    }

    struct KojuMintedEvent has copy, drop {
        recipient: address,
        koju_amount: u64,
        minted_by: address,
    }

    struct KojuSpentEvent has copy, drop {
        spender: address,
        amount: u64,
    }

    public fun admin_mint_koju(arg0: &mut Treasury, arg1: vector<u8>, arg2: &0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::mint_authority::MintAuthority, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::nonces::UsedNonces, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = MintKojuRequest{
            koju_amount : arg5,
            nonce       : arg3,
            timestamp   : arg4,
            recipient   : arg6,
        };
        0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::nonces::check_and_mark_nonce(&arg3, arg4, arg7, arg8);
        assert!(0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::mint_authority::verify_ed25519_signature<MintKojuRequest>(&v0, &arg1, arg2), 1);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<KOJU>(&mut arg0.treasury_cap, 0x2::token::transfer<KOJU>(0x2::token::mint<KOJU>(&mut arg0.treasury_cap, arg5, arg9), arg6, arg9), arg9);
        let v5 = KojuMintedEvent{
            recipient   : arg6,
            koju_amount : arg5,
            minted_by   : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<KojuMintedEvent>(v5);
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<T0>, 0x2::coin_registry::MetadataCap<T0>) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<T0>(arg0, 0, 0x1::string::utf8(b"KOJU"), 0x1::string::utf8(b"KOJU"), 0x1::string::utf8(b"The Warped Universe in-game currency"), 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDYiIGhlaWdodD0iNDYiIHZpZXdCb3g9IjAgMCA0NiA0NiIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTI1LjAwOTEgNDUuMjY3TDIxLjI5NzEgNDUuMjU2MkMyMC4yNzMxIDQ1LjI1MzIgMTkuNDQzNSA0NC40MTg4IDE5LjQ0NjUgNDMuMzk0OEwxOS41MTEgMjEuMTIyOUMxOS41MTQgMjAuMDk4OSAyMC4zNDg0IDE5LjI2OTQgMjEuMzcyNCAxOS4yNzIzTDI1LjA4NDQgMTkuMjgzMUMyNi4xMDgzIDE5LjI4NiAyNi45Mzc5IDIwLjEyMDUgMjYuOTM1IDIxLjE0NDRMMjYuODcwNCA0My40MTY0QzI2Ljg2NzUgNDQuNDQwNCAyNi4wMzMxIDQ1LjI2OTkgMjUuMDA5MSA0NS4yNjdaTTM4LjA5NzggMTEuODk2N0MzNi43NTM4IDExLjg5MjkgMzUuODUzOSAxMy4yMzQzIDM2LjM2MjIgMTQuNTE1N0w0NS4zMjc2IDM0Ljc2NThDNDUuNDU1IDM0Ljk1ODIgNDUuNDU0MyAzNS4yMTQyIDQ1LjQ1MzUgMzUuNDcwMkw0NS40MzA0IDQzLjQ3MDFDNDUuNDI3NCA0NC40OTQxIDQ0LjU5MyA0NS4zMjM3IDQzLjU2OSA0NS4zMjA3TDQzLjA1NyA0NS4zMTkzQzQyLjM1MyA0NS4zMTcyIDQxLjcxNDEgNDQuOTMxNCA0MS4zOTYyIDQ0LjIyNjRMMjcuNTk4NyAxMi45NTQzQzI3LjI4MDYgMTIuMzEzNCAyNi42NDE5IDExLjg2MzYgMjUuODczOSAxMS44NjEzTDEzLjk2OTkgMTEuODI2OEMxMi45NDU5IDExLjgyMzkgMTIuMTExNSAxMi42NTM1IDEyLjEwODUgMTMuNjc3NUwxMi4wMjI1IDQzLjM3MzNDMTIuMDE5NSA0NC4zOTczIDExLjE4NTEgNDUuMjI2OSAxMC4xNjExIDQ1LjIyNEwyLjczNzE2IDQ1LjIwMjRDMS43MTMxNyA0NS4xOTk1IDAuODgzNTggNDQuMzY1MSAwLjg4NjU0NyA0My4zNDExTDEuMDA0ODQgMi41MDkyNEMxLjAwNzgxIDEuNDg1MjUgMS44NDIyMiAwLjY1NTY2MSAyLjg2NjIxIDAuNjU4NjI4TDEwLjI5MDIgMC42ODAxMzdDMTEuMzE0MiAwLjY4MzEwMyAxMi4xNDM4IDEuNTE3NTEgMTIuMTQwOCAyLjU0MTVDMTIuMTM3OCAzLjU2NTUgMTIuOTY3NCA0LjM5OTkxIDEzLjk5MTQgNC40MDI4OEw0My42ODczIDQuNDg4OTFDNDQuNzExMyA0LjQ5MTg4IDQ1LjU0MDkgNS4zMjYyOSA0NS41Mzc5IDYuMzUwMjhMNDUuNTI3MiAxMC4wNjIzQzQ1LjUyNDIgMTEuMDg2MyA0NC42ODk4IDExLjkxNTggNDMuNjY1OCAxMS45MTI5TDM4LjA5NzggMTEuODk2N1oiIGZpbGw9IndoaXRlIi8+Cjwvc3ZnPg=="), arg1);
        (v1, 0x2::coin_registry::finalize<T0>(v0, arg1))
    }

    fun init(arg0: KOJU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_currency<KOJU>(arg0, arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<KOJU>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::allow<KOJU>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        0x2::token::share_policy<KOJU>(v6);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<KOJU>>(v5, 0x2::tx_context::sender(arg1));
        let v7 = Treasury{
            id             : 0x2::object::new(arg1),
            balance_sui    : 0x2::balance::zero<0x2::sui::SUI>(),
            balance_usdc   : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            balance_warped : 0x2::balance::zero<0x50c9c77f29de11a2abdbe60e0869a026dc47c94bfc4e7d461c80313b079d44d2::warped::WARPED>(),
            treasury_cap   : v2,
        };
        0x2::transfer::share_object<Treasury>(v7);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<KOJU>>(v1, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint_koju(arg0: &mut Treasury, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<KOJU>(&mut arg0.treasury_cap, 0x2::token::transfer<KOJU>(0x2::token::mint<KOJU>(&mut arg0.treasury_cap, arg1, arg3), arg2, arg3), arg3);
    }

    fun process_payment<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::utils::join_coins<T0>(arg0);
        assert!(0x2::coin::value<T0>(&v0) >= arg1, 0);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg1, arg2))
    }

    fun purchase_koju(arg0: &mut Treasury, arg1: vector<u8>, arg2: &0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::mint_authority::MintAuthority, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: 0x1::string::String, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::nonces::UsedNonces, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0, 3);
        0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::nonces::check_and_mark_nonce(&arg3, arg4, arg10, arg11);
        if (arg9) {
            let v0 = PurchaseKojuWithFiatRequest{
                koju_amount   : arg5,
                price         : arg7,
                fiat_currency : arg8,
                nonce         : arg3,
                timestamp     : arg4,
                recipient     : arg6,
            };
            assert!(0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::mint_authority::verify_ed25519_signature<PurchaseKojuWithFiatRequest>(&v0, &arg1, arg2), 1);
        } else {
            let v1 = PurchaseKojuRequest{
                koju_amount : arg5,
                price       : arg7,
                nonce       : arg3,
                timestamp   : arg4,
                recipient   : arg6,
            };
            assert!(0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::mint_authority::verify_ed25519_signature<PurchaseKojuRequest>(&v1, &arg1, arg2), 1);
        };
        mint_koju(arg0, arg5, arg6, arg12);
        let v2 = KojuPurchasedEvent{
            recipient        : arg6,
            koju_amount      : arg5,
            payment_price    : arg7,
            payment_currency : arg8,
            purchaser        : 0x2::tx_context::sender(arg12),
        };
        0x2::event::emit<KojuPurchasedEvent>(v2);
    }

    public fun purchase_koju_with_fiat(arg0: &mut Treasury, arg1: vector<u8>, arg2: &0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::mint_authority::MintAuthority, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::nonces::UsedNonces, arg11: &mut 0x2::tx_context::TxContext) {
        purchase_koju(arg0, arg1, arg2, arg3, arg4, arg5, arg8, arg6, arg7, true, arg9, arg10, arg11);
    }

    public fun purchase_koju_with_sui(arg0: &mut Treasury, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: vector<u8>, arg3: &0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::mint_authority::MintAuthority, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::nonces::UsedNonces, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = process_payment<0x2::sui::SUI>(arg1, arg7, arg11);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_sui, v0);
        purchase_koju(arg0, arg2, arg3, arg4, arg5, arg6, arg8, arg7, 0x1::string::utf8(b"SUI"), false, arg9, arg10, arg11);
    }

    public fun purchase_koju_with_usdc(arg0: &mut Treasury, arg1: vector<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg2: vector<u8>, arg3: &0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::mint_authority::MintAuthority, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::nonces::UsedNonces, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = process_payment<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg7, arg11);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance_usdc, v0);
        purchase_koju(arg0, arg2, arg3, arg4, arg5, arg6, arg8, arg7, 0x1::string::utf8(b"USDC"), false, arg9, arg10, arg11);
    }

    public fun purchase_koju_with_warped(arg0: &mut Treasury, arg1: vector<0x2::coin::Coin<0x50c9c77f29de11a2abdbe60e0869a026dc47c94bfc4e7d461c80313b079d44d2::warped::WARPED>>, arg2: vector<u8>, arg3: &0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::mint_authority::MintAuthority, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::nonces::UsedNonces, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = process_payment<0x50c9c77f29de11a2abdbe60e0869a026dc47c94bfc4e7d461c80313b079d44d2::warped::WARPED>(arg1, arg7, arg11);
        0x2::balance::join<0x50c9c77f29de11a2abdbe60e0869a026dc47c94bfc4e7d461c80313b079d44d2::warped::WARPED>(&mut arg0.balance_warped, v0);
        purchase_koju(arg0, arg2, arg3, arg4, arg5, arg6, arg8, arg7, 0x1::string::utf8(b"WARPED"), false, arg9, arg10, arg11);
    }

    public(friend) fun spend_koju(arg0: vector<0x2::token::Token<KOJU>>, arg1: &mut 0x2::token::TokenPolicy<KOJU>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::utils::join_tokens<KOJU>(arg0);
        assert!(0x2::token::value<KOJU>(&v0) >= arg2, 2);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<KOJU>(arg1, 0x2::token::spend<KOJU>(0x2::token::split<KOJU>(&mut v0, arg2, arg3), arg3), arg3);
        let v5 = KojuSpentEvent{
            spender : 0x2::tx_context::sender(arg3),
            amount  : arg2,
        };
        0x2::event::emit<KojuSpentEvent>(v5);
        if (0x2::token::value<KOJU>(&v0) > 0) {
            0x2::token::keep<KOJU>(v0, arg3);
        } else {
            0x2::token::destroy_zero<KOJU>(v0);
        };
    }

    fun withdraw_currency<T0>(arg0: &0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::admin::AdminCap, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg1, arg2), arg4), arg3);
    }

    public fun withdraw_sui(arg0: &0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::admin::AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.balance_sui;
        withdraw_currency<0x2::sui::SUI>(arg0, v0, arg2, arg3, arg4);
    }

    public fun withdraw_usdc(arg0: &0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::admin::AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.balance_usdc;
        withdraw_currency<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, v0, arg2, arg3, arg4);
    }

    public fun withdraw_warped(arg0: &0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::admin::AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.balance_warped;
        withdraw_currency<0x50c9c77f29de11a2abdbe60e0869a026dc47c94bfc4e7d461c80313b079d44d2::warped::WARPED>(arg0, v0, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

