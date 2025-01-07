module 0x36199fce405e33e160c17ef188ecd490e37fdb3289a57b2c73bed88944febbdc::pump {
    struct PoolEvent has copy, drop {
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        is_completed: bool,
    }

    struct Configuration has store, key {
        id: 0x2::object::UID,
        verson: u64,
        admin: address,
        platform_fee: u64,
        graduated_fee: u64,
        initial_virtual_sui_reserves: u64,
        initial_virtual_token_reserves: u64,
        remain_token_reserves: u64,
        token_decimals: u8,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        real_sui_reserves: 0x2::coin::Coin<0x2::sui::SUI>,
        real_token_reserves: 0x2::coin::Coin<T0>,
        virtual_token_reserves: u64,
        virtual_sui_reserves: u64,
        remain_token_reserves: 0x2::coin::Coin<T0>,
        is_completed: bool,
    }

    public entry fun swap<T0, T1>(arg0: &mut Configuration, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T1>>(&mut arg0.id, 0x1::type_name::get_address(&v0));
        let v2 = PoolEvent{
            virtual_sui_reserves   : v1.virtual_sui_reserves,
            virtual_token_reserves : v1.virtual_token_reserves,
            is_completed           : v1.is_completed,
        };
        0x2::event::emit<PoolEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

