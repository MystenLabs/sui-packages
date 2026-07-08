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

    public fun size(arg0: &Vault) : u64 {
        arg0.size
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

