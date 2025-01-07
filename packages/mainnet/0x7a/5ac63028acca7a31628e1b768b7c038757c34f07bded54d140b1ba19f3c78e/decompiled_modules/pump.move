module 0x7a5ac63028acca7a31628e1b768b7c038757c34f07bded54d140b1ba19f3c78e::pump {
    struct PoolEvent has copy, drop {
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        is_completed: bool,
    }

    struct TimeEvent has copy, drop {
        timestamp_ms: u64,
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

    public entry fun swap<T0>(arg0: &mut Configuration, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v0));
        let v2 = PoolEvent{
            virtual_sui_reserves   : v1.virtual_sui_reserves,
            virtual_token_reserves : v1.virtual_token_reserves,
            is_completed           : v1.is_completed,
        };
        0x2::event::emit<PoolEvent>(v2);
    }

    public entry fun get_time(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

