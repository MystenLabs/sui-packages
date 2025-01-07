module 0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_safe {
    struct LotterySafe<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun balance<T0>(arg0: &LotterySafe<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun delete<T0>(arg0: LotterySafe<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let LotterySafe {
            id      : v0,
            balance : v1,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v1);
        0x2::object::delete(v0);
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : LotterySafe<T0> {
        LotterySafe<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        }
    }

    public(friend) fun balance_mut<T0>(arg0: &mut LotterySafe<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.balance
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LotterySafe<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::memefi::MEMEFI>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::memefi::MEMEFI>(),
        };
        0x2::transfer::share_object<LotterySafe<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::memefi::MEMEFI>>(v0);
    }

    public fun put<T0: drop>(arg0: &mut LotterySafe<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::package::Publisher) {
        0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::assert_publisher_from_package(arg2);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun share<T0>(arg0: LotterySafe<T0>) {
        0x2::transfer::share_object<LotterySafe<T0>>(arg0);
    }

    public fun withdraw<T0: drop>(arg0: &mut LotterySafe<T0>, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::assert_publisher_from_package(arg1);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg2)
    }

    // decompiled from Move bytecode v6
}

