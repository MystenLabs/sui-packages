module 0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::vault {
    struct DepositKey has copy, drop, store {
        pos0: address,
    }

    struct Deposit has store, key {
        id: 0x2::object::UID,
        amount: u64,
        owner: address,
    }

    struct VaultKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        deposits: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        size: u64,
    }

    public fun address_has_idle_deposits(arg0: &Vault, arg1: address) : bool {
        0x2::dynamic_object_field::exists<address>(&arg0.id, arg1)
    }

    public(friend) fun create_vault_and_share<T0: drop>(arg0: &T0, arg1: &mut 0x2::object::UID) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        let v0 = VaultKey{dummy_field: false};
        assert!(!0x2::derived_object::exists<VaultKey>(arg1, v0), 0);
        let v1 = Vault{
            id       : 0x2::derived_object::claim<VaultKey>(arg1, v0),
            deposits : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            size     : 0,
        };
        0x2::transfer::public_share_object<Vault>(v1);
    }

    public fun deposit(arg0: &mut Vault, arg1: &0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::config::Config, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) {
        0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::config::assert_package_version(arg1);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2);
        0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.deposits, arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        if (!0x2::dynamic_object_field::exists<address>(&arg0.id, v1)) {
            arg0.size = arg0.size + 1;
            let v2 = DepositKey{pos0: v1};
            let v3 = Deposit{
                id     : 0x2::derived_object::claim<DepositKey>(&mut arg0.id, v2),
                amount : v0,
                owner  : v1,
            };
            0x2::dynamic_object_field::add<address, Deposit>(&mut arg0.id, v1, v3);
        } else {
            let v4 = 0x2::dynamic_object_field::borrow_mut<address, Deposit>(&mut arg0.id, v1);
            v4.amount = v4.amount + v0;
        };
        0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::events::emit_deposit_event(v1, v0);
    }

    public fun migrate_deposit_to_vault<T0, T1, T2>(arg0: &mut Vault, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::authority::PACKAGE, T1>, arg2: &0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::config::Config, arg3: 0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::vault::Vault<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::authority::PACKAGE, T2>, arg5: &mut 0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::config::Config, arg6: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::config::assert_package_version(arg2);
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::assert_is_admin_or_assistant<T1>();
        0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::config::assert_package_authority_cap_is_valid<T1>(arg2, arg1);
        let v0 = take_deposit_for_migration(arg0, arg9, arg11);
        let v1 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v0);
        if (v1 == 0) {
            0x2::coin::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0);
            0x2::transfer::public_share_object<0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::vault::Vault<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg3);
            0x2::transfer::public_share_object<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg6);
            return
        };
        if (v1 <= 1000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(v0, arg9);
            0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::events::emit_withdraw_event(arg9, v1);
            0x2::transfer::public_share_object<0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::vault::Vault<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg3);
            0x2::transfer::public_share_object<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg6);
            return
        };
        let v2 = start_deposit_session_for_migration<T0, T2>(arg3, arg4, arg5, arg6, arg7, v0, arg9, arg10, arg11);
        0x2::transfer::public_transfer<0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::vault::UserLpCoin<T0>>(0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::interface::end_deposit_session<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v2, arg5, 0, arg8, arg11), arg9);
    }

    public fun size(arg0: &Vault) : u64 {
        arg0.size
    }

    fun start_deposit_session_for_migration<T0, T1>(arg0: 0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::vault::Vault<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::authority::PACKAGE, T1>, arg2: &0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::config::Config, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::vault::DepositSession<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let v0 = 0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::interface::start_deposit_session<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg2, arg3, arg4, arg5, arg7, arg8);
        0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::interface::set_deposit_session_sender<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T1>(&mut v0, arg1, arg2, arg6);
        0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::events::emit_migrate_event(arg6, 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg5), 0x2::object::id<0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::vault::Vault<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&arg0));
        v0
    }

    public fun start_migrate_session<T0, T1, T2>(arg0: &mut Vault, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::authority::PACKAGE, T1>, arg2: &0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::config::Config, arg3: 0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::vault::Vault<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::authority::PACKAGE, T2>, arg5: &0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::config::Config, arg6: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::vault::DepositSession<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::config::assert_package_version(arg2);
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::assert_is_admin_or_assistant<T1>();
        0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::config::assert_package_authority_cap_is_valid<T1>(arg2, arg1);
        let v0 = take_deposit_for_migration(arg0, arg8, arg10);
        let v1 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v0);
        assert!(v1 > 0, 1);
        assert!(v1 > 1000000, 2);
        start_deposit_session_for_migration<T0, T2>(arg3, arg4, arg5, arg6, arg7, v0, arg8, arg9, arg10)
    }

    fun take_deposit_for_migration(arg0: &mut Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        if (!0x2::dynamic_object_field::exists<address>(&arg0.id, arg1)) {
            return 0x2::coin::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2)
        };
        let v0 = 0x2::dynamic_object_field::borrow_mut<address, Deposit>(&mut arg0.id, arg1);
        v0.amount = 0;
        0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.deposits, v0.amount, arg2)
    }

    public fun total_idle_deposits(arg0: &Vault) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.deposits)
    }

    public fun total_idle_deposits_for_address(arg0: &Vault, arg1: address) : u64 {
        if (address_has_idle_deposits(arg0, arg1)) {
            0x2::dynamic_object_field::borrow<address, Deposit>(&arg0.id, arg1).amount
        } else {
            0
        }
    }

    public fun withdraw_for_owner<T0>(arg0: &mut Vault, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::authority::PACKAGE, T0>, arg2: &0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::config::Config, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::config::assert_package_version(arg2);
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::assert_is_admin_or_assistant<T0>();
        0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::config::assert_package_authority_cap_is_valid<T0>(arg2, arg1);
        if (!0x2::dynamic_object_field::exists<address>(&arg0.id, arg3)) {
            return
        };
        let v0 = 0x2::dynamic_object_field::borrow_mut<address, Deposit>(&mut arg0.id, arg3);
        let v1 = 0x1::u64::min(arg4, v0.amount);
        if (v1 == 0) {
            return
        };
        v0.amount = v0.amount - v1;
        let v2 = v0.owner;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.deposits, v1, arg5), v2);
        0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::events::emit_withdraw_event(v2, v1);
    }

    // decompiled from Move bytecode v7
}

