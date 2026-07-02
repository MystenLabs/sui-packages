module 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::treasury {
    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        balance: 0x2::balance::Balance<T0>,
        lifetime_collected: u64,
        lifetime_withdrawn: u64,
    }

    struct TreasuryOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeCollected has copy, drop {
        treasury: 0x2::object::ID,
        amount: u64,
        kind: u8,
        market: 0x1::option::Option<0x2::object::ID>,
        source: address,
    }

    struct TreasuryWithdrawal has copy, drop {
        treasury: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    public fun available<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun create_treasury<T0>(arg0: &TreasuryOwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id                 : 0x2::object::new(arg1),
            version            : 1,
            balance            : 0x2::balance::zero<T0>(),
            lifetime_collected : 0,
            lifetime_withdrawn : 0,
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u8, arg3: 0x1::option::Option<0x2::object::ID>, arg4: address) {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::balance::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        arg0.lifetime_collected = arg0.lifetime_collected + v0;
        let v1 = FeeCollected{
            treasury : 0x2::object::id<Treasury<T0>>(arg0),
            amount   : v0,
            kind     : arg2,
            market   : arg3,
            source   : arg4,
        };
        0x2::event::emit<FeeCollected>(v1);
    }

    public fun deposit_coin<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: 0x1::option::Option<0x2::object::ID>, arg4: address) {
        deposit<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2, arg3, arg4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        setup(arg0);
    }

    public fun kind_other() : u8 {
        3
    }

    public fun kind_settlement() : u8 {
        1
    }

    public fun kind_slashed_bond() : u8 {
        2
    }

    public fun kind_trade() : u8 {
        0
    }

    public fun lifetime_collected<T0>(arg0: &Treasury<T0>) : u64 {
        arg0.lifetime_collected
    }

    public fun lifetime_withdrawn<T0>(arg0: &Treasury<T0>) : u64 {
        arg0.lifetime_withdrawn
    }

    public fun migrate<T0>(arg0: &TreasuryOwnerCap, arg1: &mut Treasury<T0>) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    fun setup(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<TreasuryOwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun version<T0>(arg0: &Treasury<T0>) : u64 {
        arg0.version
    }

    public fun withdraw<T0>(arg0: &TreasuryOwnerCap, arg1: &mut Treasury<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.version == 1, 0);
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 1);
        arg1.lifetime_withdrawn = arg1.lifetime_withdrawn + arg2;
        let v0 = TreasuryWithdrawal{
            treasury  : 0x2::object::id<Treasury<T0>>(arg1),
            amount    : arg2,
            recipient : arg3,
        };
        0x2::event::emit<TreasuryWithdrawal>(v0);
        0x2::coin::take<T0>(&mut arg1.balance, arg2, arg4)
    }

    // decompiled from Move bytecode v7
}

