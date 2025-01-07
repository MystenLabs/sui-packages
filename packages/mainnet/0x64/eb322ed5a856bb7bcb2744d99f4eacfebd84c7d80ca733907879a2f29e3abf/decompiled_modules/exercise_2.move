module 0x64eb322ed5a856bb7bcb2744d99f4eacfebd84c7d80ca733907879a2f29e3abf::exercise_2 {
    struct SuiMoverExercise2 has drop {
        dummy_field: bool,
    }

    struct OrangeStore has key {
        id: 0x2::object::UID,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct WithdrawCap has store, key {
        id: 0x2::object::UID,
    }

    public fun basic_price() : u64 {
        1000
    }

    public fun buy(arg0: &mut OrangeStore, arg1: &0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::config::Config, arg2: &0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::kapy::Kapy, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::orange::Orange {
        let v0 = orange_kind();
        if (0x2::vec_set::contains<u8>(0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::kapy::belongings(arg2), &v0)) {
            err_kapy_already_has_orange();
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) < 1000 + (0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::kapy::index(arg2) as u64)) {
            err_payment_not_enough();
        };
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.treasury, arg3);
        let v1 = SuiMoverExercise2{dummy_field: false};
        0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::orange::mint<SuiMoverExercise2>(arg1, orange_kind(), v1, arg4)
    }

    entry fun buy_to(arg0: &mut OrangeStore, arg1: &0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::config::Config, arg2: &0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::kapy::Kapy, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::orange::Orange>(buy(arg0, arg1, arg2, arg3, arg5), arg4);
    }

    fun err_kapy_already_has_orange() {
        abort 1
    }

    fun err_payment_not_enough() {
        abort 2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OrangeStore{
            id       : 0x2::object::new(arg0),
            treasury : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<OrangeStore>(v0);
        let v1 = WithdrawCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<WithdrawCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun orange_kind() : u8 {
        2
    }

    public fun treasury_value(arg0: &OrangeStore) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public fun withdraw(arg0: &WithdrawCap, arg1: &mut OrangeStore, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.treasury), arg2)
    }

    entry fun withdraw_to(arg0: &WithdrawCap, arg1: &mut OrangeStore, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(withdraw(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

