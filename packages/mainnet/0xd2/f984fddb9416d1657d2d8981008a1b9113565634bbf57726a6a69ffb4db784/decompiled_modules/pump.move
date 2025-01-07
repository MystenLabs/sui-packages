module 0xd2f984fddb9416d1657d2d8981008a1b9113565634bbf57726a6a69ffb4db784::pump {
    struct PoolEvent has copy, drop {
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        is_completed: bool,
    }

    struct Test has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::type_name::TypeName,
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
        let v0 = Test{
            id   : 0x2::object::uid_to_inner(&arg0.id),
            name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<Test>(v0);
    }

    // decompiled from Move bytecode v6
}

