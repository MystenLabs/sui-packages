module 0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::vault {
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

    public fun deposit(arg0: &mut Vault, arg1: &0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::config::Config, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) {
        0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::config::assert_package_version(arg1);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2);
        0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.deposits, arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        if (!0x2::dynamic_object_field::exists_<address>(&arg0.id, v1)) {
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
        0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::events::emit_deposit_event(v1, v0);
    }

    // decompiled from Move bytecode v6
}

