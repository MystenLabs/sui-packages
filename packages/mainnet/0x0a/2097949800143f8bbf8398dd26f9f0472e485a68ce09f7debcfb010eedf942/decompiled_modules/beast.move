module 0xa2097949800143f8bbf8398dd26f9f0472e485a68ce09f7debcfb010eedf942::beast {
    struct Item has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct A has store, key {
        id: 0x2::object::UID,
        a: 0x1::type_name::TypeName,
        b: 0x1::type_name::TypeName,
    }

    struct Position_Dummy has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        index: u64,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        tick_lower_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity: u128,
    }

    struct Beast<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        lp: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
        birth_day: u64,
        last_time_groom: u64,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        coin_a: u64,
        coin_b: u64,
    }

    struct Beast_Dummy has store, key {
        id: 0x2::object::UID,
        lp: A,
        birth_day: u64,
        last_time_groom: u64,
        coin_a: u64,
        coin_b: u64,
    }

    struct Beast_Garden has store, key {
        id: 0x2::object::UID,
        beasts: 0x2::bag::Bag,
    }

    public entry fun beast<T0: drop, T1: drop>(arg0: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Beast<T0, T1>{
            id              : 0x2::object::new(arg2),
            lp              : arg0,
            birth_day       : 0x2::clock::timestamp_ms(arg1),
            last_time_groom : 0x2::clock::timestamp_ms(arg1),
            coin_type_a     : 0x1::type_name::get<T0>(),
            coin_type_b     : 0x1::type_name::get<T1>(),
            coin_a          : 0,
            coin_b          : 0,
        };
        0x2::transfer::transfer<Beast<T0, T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    fun a_dummy(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = A{
            id : 0x2::object::new(arg0),
            a  : 0x1::type_name::get<0x2::sui::SUI>(),
            b  : 0x1::type_name::get<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<A>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun a_show(arg0: &mut A, arg1: &mut 0x2::tx_context::TxContext) {
        0x1::debug::print<A>(arg0);
    }

    public entry fun beast_dummy<T0: drop, T1: drop>(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = A{
            id : 0x2::object::new(arg1),
            a  : 0x1::type_name::get<T0>(),
            b  : 0x1::type_name::get<T0>(),
        };
        let v1 = Beast_Dummy{
            id              : 0x2::object::new(arg1),
            lp              : v0,
            birth_day       : 0x2::clock::timestamp_ms(arg0),
            last_time_groom : 0x2::clock::timestamp_ms(arg0),
            coin_a          : 0,
            coin_b          : 0,
        };
        0x2::transfer::transfer<Beast_Dummy>(v1, 0x2::tx_context::sender(arg1));
    }

    fun beast_dummy_entity<T0: drop, T1: drop>(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : Beast_Dummy {
        let v0 = A{
            id : 0x2::object::new(arg1),
            a  : 0x1::type_name::get<T0>(),
            b  : 0x1::type_name::get<T1>(),
        };
        Beast_Dummy{
            id              : 0x2::object::new(arg1),
            lp              : v0,
            birth_day       : 0x2::clock::timestamp_ms(arg0),
            last_time_groom : 0x2::clock::timestamp_ms(arg0),
            coin_a          : 0,
            coin_b          : 0,
        }
    }

    fun beast_dummy_entity_2<T0: drop, T1: drop>(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : Beast_Dummy {
        let v0 = A{
            id : 0x2::object::new(arg1),
            a  : 0x1::type_name::get<T0>(),
            b  : 0x1::type_name::get<T1>(),
        };
        let v1 = A{
            id : 0x2::object::new(arg1),
            a  : 0x1::type_name::get<T0>(),
            b  : 0x1::type_name::get<T1>(),
        };
        let v2 = Beast_Dummy{
            id              : 0x2::object::new(arg1),
            lp              : v0,
            birth_day       : 0x2::clock::timestamp_ms(arg0),
            last_time_groom : 0x2::clock::timestamp_ms(arg0),
            coin_a          : 0,
            coin_b          : 0,
        };
        let v3 = 0x2::object::id<A>(&v1);
        0x1::debug::print<0x2::object::ID>(&v3);
        let v4 = Item{id: 0x2::object::id<A>(&v1)};
        0x2::dynamic_object_field::add<Item, A>(&mut v2.id, v4, v1);
        v2
    }

    public entry fun destroy_beast_<T0, T1>(arg0: Beast<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let Beast {
            id              : v0,
            lp              : v1,
            birth_day       : _,
            last_time_groom : _,
            coin_type_a     : _,
            coin_type_b     : _,
            coin_a          : _,
            coin_b          : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun destroy_beast_dummy_entity<T0: drop, T1: drop>(arg0: Beast_Dummy) {
        let Beast_Dummy {
            id              : v0,
            lp              : v1,
            birth_day       : _,
            last_time_groom : _,
            coin_a          : _,
            coin_b          : _,
        } = arg0;
        let A {
            id : v6,
            a  : _,
            b  : _,
        } = v1;
        0x2::object::delete(v0);
        0x2::object::delete(v6);
    }

    fun destroy_beast_dummy_entity_2<T0: drop, T1: drop>(arg0: Beast_Dummy) {
        let Beast_Dummy {
            id              : v0,
            lp              : v1,
            birth_day       : _,
            last_time_groom : _,
            coin_a          : _,
            coin_b          : _,
        } = arg0;
        let A {
            id : v6,
            a  : _,
            b  : _,
        } = v1;
        0x2::object::delete(v0);
        0x2::object::delete(v6);
    }

    fun destroy_garden_entity(arg0: Beast_Garden) {
        let Beast_Garden {
            id     : v0,
            beasts : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::bag::destroy_empty(v1);
    }

    fun garden_entity(arg0: &mut 0x2::tx_context::TxContext) : Beast_Garden {
        Beast_Garden{
            id     : 0x2::object::new(arg0),
            beasts : 0x2::bag::new(arg0),
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun mint_beast_entity(arg0: A, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Beast_Dummy{
            id              : 0x2::object::new(arg2),
            lp              : arg0,
            birth_day       : 0x2::clock::timestamp_ms(arg1),
            last_time_groom : 0x2::clock::timestamp_ms(arg1),
            coin_a          : 0,
            coin_b          : 0,
        };
        0x2::transfer::transfer<Beast_Dummy>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun mint_dummy_LP_entity<T0: drop, T1: drop>(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = A{
            id : 0x2::object::new(arg1),
            a  : 0x1::type_name::get<T0>(),
            b  : 0x1::type_name::get<T1>(),
        };
        0x2::transfer::transfer<A>(v0, 0x2::tx_context::sender(arg1));
    }

    fun position_dummy(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"Cetus LP | Pool");
        let v1 = 0x2::object::new(arg0);
        let v2 = Position_Dummy{
            id               : v1,
            pool             : 0x2::object::uid_to_inner(&v1),
            index            : 1,
            coin_type_a      : 0x1::type_name::get<0x2::sui::SUI>(),
            coin_type_b      : 0x1::type_name::get<0x2::sui::SUI>(),
            name             : v0,
            description      : v0,
            url              : v0,
            tick_lower_index : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(10000),
            tick_upper_index : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(70000),
            liquidity        : 2000000,
        };
        0x2::transfer::transfer<Position_Dummy>(v2, 0x2::tx_context::sender(arg0));
    }

    public entry fun position_show(arg0: &mut Position_Dummy, arg1: &mut 0x2::tx_context::TxContext) {
        0x1::debug::print<Position_Dummy>(arg0);
    }

    // decompiled from Move bytecode v6
}

