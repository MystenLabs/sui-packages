module 0x5c2f00abfaa668d8fc71bdc82561d1090395918f3c255776d17d8874ffe34d51::StakeManagement {
    struct TreasuryWallet has copy, drop {
        signer_addr: address,
        treasury_addr: address,
        version: u64,
        proof: u64,
    }

    struct ManageAccount has copy, drop {
        kind: u8,
        signer_addr: address,
        acccount_addr: address,
    }

    struct RewardRate has copy, drop {
        rate: u64,
        signer_addr: address,
    }

    struct DepositLimit has copy, drop {
        minimum: u64,
        maximum: u64,
        signer_addr: address,
    }

    struct StakeSetting has copy, drop {
        kind: u8,
        value: u8,
        signer_addr: address,
    }

    struct TokenType has copy, drop {
        token_type: 0x1::string::String,
        signer_addr: address,
    }

    struct PoolID has copy, drop {
        id: u64,
        signer_addr: address,
    }

    struct PoolStatus has copy, drop {
        id: u64,
        kind: u8,
        signer_addr: address,
    }

    struct PaymentFee has copy, drop {
        id: u64,
        recipient: address,
        value: u64,
        signer_addr: address,
    }

    struct Staker<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        lender: address,
        start_time: u64,
    }

    struct StakeAdded<phantom T0> has copy, drop, store {
        id: address,
        pool_id: u64,
        lender: address,
        token_type: 0x1::string::String,
        amount: u64,
        start_time: u64,
    }

    struct StakeWithdrawn<phantom T0> has copy, drop, store {
        pool_id: u64,
        id: address,
        lender: address,
        withdraw_time: u64,
        amount_withdrawn: u64,
    }

    struct StakeReward has copy, drop {
        stake_id: address,
        treasury_addr: address,
        lender_addr: address,
        reward_amount: u64,
    }

    struct PlatformCommission has copy, drop {
        stake_id: address,
        commission_addr: address,
        commission_amount: u64,
    }

    public fun Account(arg0: u8, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ManageAccount{
            kind          : arg0,
            signer_addr   : 0x2::tx_context::sender(arg2),
            acccount_addr : arg1,
        };
        0x2::event::emit<ManageAccount>(v0);
    }

    public fun GetStakeInfo<T0>(arg0: &Staker<T0>) : (address, u64, u64) {
        (arg0.lender, 0x2::balance::value<T0>(&arg0.balance), arg0.start_time)
    }

    public fun Limit(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DepositLimit{
            minimum     : arg0,
            maximum     : arg1,
            signer_addr : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DepositLimit>(v0);
    }

    public fun Payment(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 == arg3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg2);
        let v1 = PaymentFee{
            id          : arg1,
            recipient   : arg2,
            value       : v0,
            signer_addr : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PaymentFee>(v1);
    }

    public fun Pool(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolID{
            id          : arg0,
            signer_addr : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<PoolID>(v0);
    }

    public fun Rate(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardRate{
            rate        : arg0,
            signer_addr : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<RewardRate>(v0);
    }

    public fun Reward(arg0: address, arg1: address, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = StakeReward{
            stake_id      : arg0,
            treasury_addr : 0x2::tx_context::sender(arg5),
            lender_addr   : arg1,
            reward_amount : arg2,
        };
        0x2::event::emit<StakeReward>(v0);
        let v1 = PlatformCommission{
            stake_id          : arg0,
            commission_addr   : arg3,
            commission_amount : arg4,
        };
        0x2::event::emit<PlatformCommission>(v1);
    }

    public fun Setting(arg0: u8, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StakeSetting{
            kind        : arg0,
            value       : arg1,
            signer_addr : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<StakeSetting>(v0);
    }

    public fun Stake<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::coin::into_balance<T0>(arg0);
        let v3 = 0x2::balance::value<T0>(&v2);
        let v4 = 0x2::object::new(arg3);
        assert!(v3 > 0, 2);
        let v5 = Staker<T0>{
            id         : v4,
            balance    : v2,
            lender     : v1,
            start_time : v0,
        };
        0x2::transfer::transfer<Staker<T0>>(v5, v1);
        let v6 = StakeAdded<T0>{
            id         : 0x2::object::uid_to_address(&v4),
            pool_id    : arg1,
            lender     : v1,
            token_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            amount     : v3,
            start_time : v0,
        };
        0x2::event::emit<StakeAdded<T0>>(v6);
    }

    public fun Status(arg0: u64, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolStatus{
            id          : arg0,
            kind        : arg1,
            signer_addr : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PoolStatus>(v0);
    }

    public fun Token<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenType{
            token_type  : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            signer_addr : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<TokenType>(v0);
    }

    public fun Treasury(arg0: address, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryWallet{
            signer_addr   : 0x2::tx_context::sender(arg3),
            treasury_addr : arg0,
            version       : arg1,
            proof         : arg2,
        };
        0x2::event::emit<TreasuryWallet>(v0);
    }

    public fun Withdraw<T0>(arg0: Staker<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let Staker {
            id         : v1,
            balance    : v2,
            lender     : _,
            start_time : _,
        } = arg0;
        let v5 = v2;
        let v6 = 0x2::balance::value<T0>(&v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v5, v6, arg3), v0);
        let v7 = StakeWithdrawn<T0>{
            pool_id          : arg1,
            id               : 0x2::object::uid_to_address(&arg0.id),
            lender           : v0,
            withdraw_time    : 0x2::clock::timestamp_ms(arg2),
            amount_withdrawn : v6,
        };
        0x2::event::emit<StakeWithdrawn<T0>>(v7);
        0x2::balance::destroy_zero<T0>(v5);
        0x2::object::delete(v1);
    }

    // decompiled from Move bytecode v6
}

