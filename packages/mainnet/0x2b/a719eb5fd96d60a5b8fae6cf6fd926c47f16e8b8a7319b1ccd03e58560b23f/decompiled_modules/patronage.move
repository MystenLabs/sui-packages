module 0x2ba719eb5fd96d60a5b8fae6cf6fd926c47f16e8b8a7319b1ccd03e58560b23f::patronage {
    struct Patronage<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PositionKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Position<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        ptoken_cap: 0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::TokenCap<T1>,
        funds_available: 0x2::balance::Balance<T0>,
        deposited_token: u64,
        asset: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct RecallReceipt<phantom T0, phantom T1, phantom T2> {
        withdrawal: u64,
    }

    public fun new<T0>(arg0: &0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::PlatformCap, arg1: &mut 0x2::tx_context::TxContext) : Patronage<T0> {
        Patronage<T0>{id: 0x2::object::new(arg1)}
    }

    public fun burn<T0, T1>(arg0: &mut Patronage<T0>, arg1: 0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::Token<T1>, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::value<T1>(&arg1);
        let v1 = position_mut<T0, T1>(arg0);
        0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::burn<T1>(&mut v1.ptoken_cap, arg1, arg2);
        v1.deposited_token = v1.deposited_token - v0;
        0x2::balance::split<T0>(&mut v1.funds_available, v0)
    }

    public fun close_position<T0, T1>(arg0: &mut Patronage<T0>, arg1: &0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::profile::Profile<T1>) {
        let v0 = PositionKey<T1>{dummy_field: false};
        let Position {
            id              : v1,
            ptoken_cap      : v2,
            funds_available : v3,
            deposited_token : v4,
            asset           : v5,
        } = 0x2::dynamic_object_field::remove<PositionKey<T1>, Position<T0, T1>>(&mut arg0.id, v0);
        let v6 = v5;
        0x2::object::delete(v1);
        assert!(0x2::vec_set::is_empty<0x1::type_name::TypeName>(&v6), 102);
        0x2::balance::destroy_zero<T0>(v3);
        assert!(v4 == 0, 101);
        0x2::transfer::public_transfer<0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::TokenCap<T1>>(v2, 0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::profile::owner<T1>(arg1));
    }

    public fun collect_reward<T0, T1, T2>(arg0: &mut Patronage<T0>, arg1: &0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::profile::Profile<T1>, arg2: &mut 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::Vault<T0, T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = position_mut<T0, T1>(arg0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.funds_available, position_value<T0, T1, T2>(v0, arg2, arg3) - v0.deposited_token), arg4)
    }

    public fun default<T0>(arg0: &0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::PlatformCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Patronage<T0>{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<Patronage<T0>>(v0);
    }

    public fun deploy_to_vault<T0, T1, T2>(arg0: &mut Patronage<T0>, arg1: &mut 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::Vault<T0, T2>, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = position_mut<T0, T1>(arg0);
        let v1 = 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::deposit<T0, T2>(arg1, 0x2::balance::split<T0>(&mut v0.funds_available, arg2), arg3);
        if (!is_position_balance_exists<T0, T1, T2>(v0)) {
            let v2 = BalanceKey<T2>{dummy_field: false};
            0x2::dynamic_field::add<BalanceKey<T2>, 0x2::balance::Balance<T2>>(&mut v0.id, v2, 0x2::balance::zero<T2>());
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0.asset, 0x1::type_name::get<T2>());
        };
        0x2::balance::join<T2>(position_balance_of_mut<T0, T1, T2>(v0), v1);
    }

    public fun deposit<T0, T1>(arg0: &mut Patronage<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::Token<T1> {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = position_mut<T0, T1>(arg0);
        0x2::balance::join<T0>(&mut v1.funds_available, arg1);
        v1.deposited_token = v1.deposited_token + v0;
        0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::mint<T1>(&mut v1.ptoken_cap, v0, arg2)
    }

    public fun deposited_token<T0, T1>(arg0: &Position<T0, T1>) : u64 {
        arg0.deposited_token
    }

    public fun donate<T0, T1>(arg0: &mut Patronage<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut position_mut<T0, T1>(arg0).funds_available, arg1);
    }

    public fun funds_available<T0, T1>(arg0: &Position<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.funds_available)
    }

    public fun is_position_balance_exists<T0, T1, T2>(arg0: &Position<T0, T1>) : bool {
        let v0 = BalanceKey<T2>{dummy_field: false};
        0x2::dynamic_field::exists_<BalanceKey<T2>>(&arg0.id, v0)
    }

    public fun open_position<T0, T1>(arg0: &mut Patronage<T0>, arg1: 0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::TokenCap<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Position<T0, T1>{
            id              : 0x2::object::new(arg2),
            ptoken_cap      : arg1,
            funds_available : 0x2::balance::zero<T0>(),
            deposited_token : 0,
            asset           : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = PositionKey<T1>{dummy_field: false};
        0x2::dynamic_object_field::add<PositionKey<T1>, Position<T0, T1>>(&mut arg0.id, v1, v0);
    }

    public fun position<T0, T1>(arg0: &Patronage<T0>) : &Position<T0, T1> {
        let v0 = PositionKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow<PositionKey<T0>, Position<T0, T1>>(&arg0.id, v0)
    }

    public fun position_balance_of<T0, T1, T2>(arg0: &Position<T0, T1>) : &0x2::balance::Balance<T2> {
        let v0 = BalanceKey<T2>{dummy_field: false};
        0x2::dynamic_field::borrow<BalanceKey<T2>, 0x2::balance::Balance<T2>>(&arg0.id, v0)
    }

    fun position_balance_of_mut<T0, T1, T2>(arg0: &mut Position<T0, T1>) : &mut 0x2::balance::Balance<T2> {
        let v0 = BalanceKey<T2>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<BalanceKey<T2>, 0x2::balance::Balance<T2>>(&mut arg0.id, v0)
    }

    fun position_mut<T0, T1>(arg0: &mut Patronage<T0>) : &mut Position<T0, T1> {
        let v0 = PositionKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<PositionKey<T0>, Position<T0, T1>>(&mut arg0.id, v0)
    }

    public fun position_value<T0, T1, T2>(arg0: &Position<T0, T1>, arg1: &0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::Vault<T0, T2>, arg2: &0x2::clock::Clock) : u64 {
        0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::from_underlying_amount<T0, T2>(arg1, 0x2::balance::value<T2>(position_balance_of<T0, T1, T2>(arg0)), arg2)
    }

    public fun settle_recall<T0, T1, T2>(arg0: &mut Patronage<T0>, arg1: RecallReceipt<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>) {
        let RecallReceipt { withdrawal: v0 } = arg1;
        assert!(0x2::balance::value<T0>(&arg2) >= v0, 104);
        0x2::balance::join<T0>(&mut position_mut<T0, T1>(arg0).funds_available, arg2);
    }

    public fun start_recall<T0, T1, T2>(arg0: &mut Patronage<T0>, arg1: &mut 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::Vault<T0, T2>, arg2: u64, arg3: &0x2::clock::Clock) : (0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::WithdrawTicket<T0, T2>, RecallReceipt<T0, T1, T2>) {
        assert!(0x2::balance::value<T2>(position_balance_of<T0, T1, T2>(position<T0, T1>(arg0))) > 0, 103);
        let v0 = position_mut<T0, T1>(arg0);
        let v1 = RecallReceipt<T0, T1, T2>{withdrawal: arg2};
        (0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::withdraw_t_amt<T0, T2>(arg1, arg2, position_balance_of_mut<T0, T1, T2>(v0), arg3), v1)
    }

    // decompiled from Move bytecode v6
}

