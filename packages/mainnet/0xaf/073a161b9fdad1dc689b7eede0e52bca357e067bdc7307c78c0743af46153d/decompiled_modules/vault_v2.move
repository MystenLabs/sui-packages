module 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::vault_v2 {
    struct RewardRole has drop {
        dummy_field: bool,
    }

    struct PenaltyRole has drop {
        dummy_field: bool,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>,
    }

    struct VaultDepositedV2 has copy, drop {
        vault_id: 0x2::object::ID,
        kind: u8,
        user: address,
        amount: u64,
    }

    struct VaultWithdrawnV2 has copy, drop {
        vault_id: 0x2::object::ID,
        kind: u8,
        user: address,
        amount: u64,
    }

    public(friend) fun claim_reward(arg0: &mut Vault<RewardRole>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE> {
        withdraw_internal<RewardRole>(arg0, arg1, 1, arg2)
    }

    public fun create_penalty(arg0: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<PenaltyRole>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(),
        };
        0x2::transfer::public_share_object<Vault<PenaltyRole>>(v0);
    }

    public fun create_reward(arg0: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<RewardRole>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(),
        };
        0x2::transfer::public_share_object<Vault<RewardRole>>(v0);
    }

    fun deposit_internal<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&arg1);
        assert!(v0 > 0, 0);
        0x2::balance::join<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut arg0.balance, 0x2::coin::into_balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(arg1));
        let v1 = VaultDepositedV2{
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
            kind     : arg2,
            user     : 0x2::tx_context::sender(arg3),
            amount   : v0,
        };
        0x2::event::emit<VaultDepositedV2>(v1);
    }

    public fun deposit_penalty(arg0: &mut Vault<PenaltyRole>, arg1: 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>, arg2: &0x2::tx_context::TxContext) {
        deposit_internal<PenaltyRole>(arg0, arg1, 2, arg2);
    }

    public fun deposit_reward(arg0: &mut Vault<RewardRole>, arg1: 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>, arg2: &0x2::tx_context::TxContext) {
        deposit_internal<RewardRole>(arg0, arg1, 1, arg2);
    }

    public fun get_penalty_vault_id(arg0: &Vault<PenaltyRole>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_reward_vault_id(arg0: &Vault<RewardRole>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun withdraw_internal<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE> {
        assert!(0x2::balance::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&arg0.balance) >= arg1, 1);
        let v0 = VaultWithdrawnV2{
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
            kind     : arg2,
            user     : 0x2::tx_context::sender(arg3),
            amount   : arg1,
        };
        0x2::event::emit<VaultWithdrawnV2>(v0);
        0x2::coin::from_balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(0x2::balance::split<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut arg0.balance, arg1), arg3)
    }

    // decompiled from Move bytecode v6
}

