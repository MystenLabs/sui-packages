module 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault {
    struct CCoin<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct Vault<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        wrapped_position_id: 0x2::object::ID,
        c_coin_supply: 0x2::balance::Supply<CCoin<T0, T1, T2>>,
        underlying_balance: 0x2::balance::Balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>,
        pending_token: 0x2::balance::Balance<T2>,
        pending_flx: 0x2::balance::Balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>,
    }

    struct Mint has copy, drop, store {
        amount: u64,
        sender: address,
    }

    struct Burn has copy, drop, store {
        amount: u64,
        sender: address,
    }

    public(friend) fun new<T0, T1, T2>(arg0: 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position, arg1: &mut 0x2::tx_context::TxContext) : Vault<T0, T1, T2> {
        let v0 = CCoin<T0, T1, T2>{dummy_field: false};
        let v1 = Vault<T0, T1, T2>{
            id                  : 0x2::object::new(arg1),
            wrapped_position_id : 0x2::object::id<0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position>(&arg0),
            c_coin_supply       : 0x2::balance::create_supply<CCoin<T0, T1, T2>>(v0),
            underlying_balance  : 0x2::balance::zero<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(),
            pending_token       : 0x2::balance::zero<T2>(),
            pending_flx         : 0x2::balance::zero<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position>(&mut v1.id, 0x2::object::id<0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position>(&arg0), arg0);
        v1
    }

    public(friend) fun borrow_mut_position<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position {
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position>(&mut arg0.id, arg0.wrapped_position_id)
    }

    public fun borrow_position<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : &0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position {
        0x2::dynamic_object_field::borrow<0x2::object::ID, 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position>(&arg0.id, arg0.wrapped_position_id)
    }

    public(friend) fun deposit_pending_rewards<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T2>, arg2: 0x2::balance::Balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>) {
        0x2::balance::join<T2>(&mut arg0.pending_token, arg1);
        0x2::balance::join<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut arg0.pending_flx, arg2);
    }

    public(friend) fun deposit_underlying<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>) {
        0x2::balance::join<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg0.underlying_balance, arg1);
    }

    public(friend) fun migrate<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position) {
        let v0 = 0x2::object::id<0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position>(&arg1);
        arg0.wrapped_position_id = v0;
        0x2::dynamic_object_field::add<0x2::object::ID, 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position>(&mut arg0.id, v0, arg1);
    }

    public(friend) fun mint_c_coin<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<CCoin<T0, T1, T2>> {
        let v0 = 0x2::balance::supply_value<CCoin<T0, T1, T2>>(&arg0.c_coin_supply);
        let v1 = if (v0 > 0) {
            0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::math::mul_div(0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg1), v0, underlying_balance<T0, T1, T2>(arg0))
        } else {
            0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg1)
        };
        assert!(v1 > 0, 0);
        let v2 = Mint{
            amount : v1,
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Mint>(v2);
        0x2::balance::join<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg0.underlying_balance, arg1);
        0x2::balance::increase_supply<CCoin<T0, T1, T2>>(&mut arg0.c_coin_supply, v1)
    }

    public fun pending_rewards<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u64, u64) {
        (0x2::balance::value<T2>(&arg0.pending_token), 0x2::balance::value<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&arg0.pending_flx))
    }

    public(friend) fun redeem_underlying_coin<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<CCoin<T0, T1, T2>>, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>> {
        let v0 = 0x2::balance::value<CCoin<T0, T1, T2>>(&arg1);
        let v1 = Burn{
            amount : v0,
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Burn>(v1);
        0x2::balance::decrease_supply<CCoin<T0, T1, T2>>(&mut arg0.c_coin_supply, arg1);
        0x2::balance::split<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg0.underlying_balance, 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::math::mul_div(v0, underlying_balance<T0, T1, T2>(arg0), 0x2::balance::supply_value<CCoin<T0, T1, T2>>(&arg0.c_coin_supply)))
    }

    public fun total_supply<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::balance::supply_value<CCoin<T0, T1, T2>>(&arg0.c_coin_supply)
    }

    public fun underlying_available<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg0.underlying_balance)
    }

    public fun underlying_balance<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        underlying_available<T0, T1, T2>(arg0) + 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::value(borrow_position<T0, T1, T2>(arg0))
    }

    public(friend) fun withdraw_pending_rewards<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64, arg2: u64) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>) {
        (0x2::balance::split<T2>(&mut arg0.pending_token, arg1), 0x2::balance::split<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut arg0.pending_flx, arg2))
    }

    public(friend) fun withdraw_underlying<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>> {
        assert!(0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg0.underlying_balance) >= arg1, 1);
        0x2::balance::split<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg0.underlying_balance, arg1)
    }

    // decompiled from Move bytecode v6
}

