module 0x6668d244f664fbb475fb288e5d6f9d1fcaac785ad24e3550375680fb208037f5::tryfuck {
    struct MagicCoin<phantom T0> has drop {
        dummy_field: bool,
    }

    struct DebtCoin<phantom T0> has drop {
        dummy_field: bool,
    }

    struct VaultInfo<phantom T0> has store {
        config_addr: address,
        vault_debt_share: u64,
        vault_debt_val: u64,
        last_accrue_time: u64,
        reserve_pool: u64,
        decimals: u8,
        coin: 0x2::balance::Balance<T0>,
        magic_coin_supply: 0x2::balance::Supply<MagicCoin<T0>>,
        debt_coin_supply: 0x2::balance::Supply<DebtCoin<T0>>,
        next_position_id: u64,
    }

    struct WwEvent<phantom T0> has copy, drop {
        account: address,
        share: u64,
        amount: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun testwiths<T0>(arg0: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_shared<VaultInfo<T0>>(arg0);
    }

    // decompiled from Move bytecode v6
}

