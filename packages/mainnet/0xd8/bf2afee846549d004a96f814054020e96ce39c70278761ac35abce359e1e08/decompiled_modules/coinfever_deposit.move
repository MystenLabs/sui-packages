module 0xd8bf2afee846549d004a96f814054020e96ce39c70278761ac35abce359e1e08::coinfever_deposit {
    struct CoinFeverControl has store, key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
    }

    struct CoinFeverAdmin has store, key {
        id: 0x2::object::UID,
    }

    struct CoinFeverWithdraw has store, key {
        id: 0x2::object::UID,
    }

    struct COINFEVER_DEPOSIT has drop {
        dummy_field: bool,
    }

    struct DepositEvent has copy, drop {
        user: address,
        token: 0x1::ascii::String,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        token: 0x1::ascii::String,
        amount: u64,
    }

    public fun bump_version(arg0: &mut CoinFeverControl, arg1: &CoinFeverAdmin, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        arg0.version = arg0.version + 1;
    }

    public fun deposit<T0>(arg0: &mut CoinFeverControl, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(arg0.paused == false, 1);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::coin::put<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
        };
        let v1 = DepositEvent{
            user   : 0x2::tx_context::sender(arg2),
            token  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    fun init(arg0: COINFEVER_DEPOSIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<COINFEVER_DEPOSIT>(arg0, arg1), v0);
        let v1 = CoinFeverAdmin{id: 0x2::object::new(arg1)};
        let v2 = CoinFeverWithdraw{id: 0x2::object::new(arg1)};
        let v3 = CoinFeverControl{
            id      : 0x2::object::new(arg1),
            version : 1,
            paused  : false,
        };
        0x2::transfer::public_transfer<CoinFeverAdmin>(v1, v0);
        0x2::transfer::public_transfer<CoinFeverWithdraw>(v2, v0);
        0x2::transfer::share_object<CoinFeverControl>(v3);
    }

    public fun pause(arg0: &mut CoinFeverControl, arg1: &CoinFeverAdmin) {
        arg0.paused = true;
    }

    public fun unpause(arg0: &mut CoinFeverControl, arg1: &CoinFeverAdmin) {
        arg0.paused = false;
    }

    public fun withdraw<T0>(arg0: &CoinFeverWithdraw, arg1: &mut CoinFeverControl, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        assert!(arg1.paused == false, 1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v0), arg2, arg4), arg3);
        let v1 = WithdrawEvent{
            user   : arg3,
            token  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount : arg2,
        };
        0x2::event::emit<WithdrawEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

