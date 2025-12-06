module 0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::distributor {
    struct DISTRIBUTOR has drop {
        dummy_field: bool,
    }

    struct Distributor has store, key {
        id: 0x2::object::UID,
        lp_name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        counter: u64,
        coin_type: 0x1::type_name::TypeName,
        single_coin_value: u64,
        max_coin_value: u64,
        created_coin_value: u64,
        round: u64,
        support_check_round: u64,
        recipient: address,
        is_active: bool,
        registry: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct LpCreated has copy, drop {
        distributor_id: 0x2::object::ID,
        number: u64,
        nft_id: 0x2::object::ID,
        minter: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct LpCreatedByOldLp has copy, drop {
        distributor_id: 0x2::object::ID,
        number: u64,
        nft_id: 0x2::object::ID,
        old_lp_id: 0x2::object::ID,
        minter: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun create_lp<T0>(arg0: &0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::system_state::SystemState, arg1: &mut Distributor, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::system_state::check_version(arg0);
        assert!(arg1.is_active, 1);
        assert!(arg1.coin_type == 0x1::type_name::with_defining_ids<T0>(), 4);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2);
        assert!(v0 % arg1.single_coin_value == 0, 2);
        arg1.created_coin_value = arg1.created_coin_value + v0;
        assert!(arg1.created_coin_value <= arg1.max_coin_value, 5);
        arg1.counter = arg1.counter + 1;
        let v1 = arg1.counter;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg1.recipient);
        let v2 = 0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::jackson_lp::new(0x2::object::id<Distributor>(arg1), arg1.round, v1, arg1.lp_name, arg1.description, 0x1::option::some<0x1::string::String>(arg1.image_url), 0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::features::new(0x1::type_name::with_defining_ids<T0>(), v0, arg3), arg3);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg1.registry, v1, 0x2::object::id<0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::jackson_lp::JacksonLP>(&v2));
        let v3 = LpCreated{
            distributor_id : 0x2::object::id<Distributor>(arg1),
            number         : v1,
            nft_id         : 0x2::object::id<0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::jackson_lp::JacksonLP>(&v2),
            minter         : 0x2::tx_context::sender(arg3),
            coin_type      : 0x1::type_name::with_defining_ids<T0>(),
            amount         : v0,
        };
        0x2::event::emit<LpCreated>(v3);
        0x2::transfer::public_transfer<0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::jackson_lp::JacksonLP>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun create_lp_distributor<T0>(arg0: &0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::admin::HandlerCap, arg1: &0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::system_state::SystemState, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::system_state::check_version(arg1);
        let v0 = Distributor{
            id                  : 0x2::object::new(arg11),
            lp_name             : arg2,
            description         : arg3,
            image_url           : arg4,
            counter             : 0,
            coin_type           : 0x1::type_name::with_defining_ids<T0>(),
            single_coin_value   : arg5,
            max_coin_value      : arg6,
            created_coin_value  : 0,
            round               : arg7,
            support_check_round : arg8,
            recipient           : arg10,
            is_active           : arg9,
            registry            : 0x2::table::new<u64, 0x2::object::ID>(arg11),
        };
        0x2::transfer::share_object<Distributor>(v0);
    }

    public fun create_lp_with_old_lp(arg0: &0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::system_state::SystemState, arg1: &mut Distributor, arg2: 0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::jackson_lp::JacksonLP, arg3: &mut 0x2::tx_context::TxContext) {
        0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::system_state::check_version(arg0);
        assert!(arg1.support_check_round == 0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::jackson_lp::round(&arg2), 6);
        let v0 = 0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::features::coin_type(0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::jackson_lp::features(&arg2));
        assert!(arg1.is_active, 1);
        assert!(arg1.coin_type == v0, 4);
        let v1 = 0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::features::amount(0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::jackson_lp::features(&arg2));
        assert!(v1 % arg1.single_coin_value == 0, 2);
        arg1.created_coin_value = arg1.created_coin_value + v1;
        assert!(arg1.created_coin_value <= arg1.max_coin_value, 5);
        arg1.counter = arg1.counter + 1;
        let v2 = arg1.counter;
        let v3 = 0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::jackson_lp::new(0x2::object::id<Distributor>(arg1), arg1.round, v2, arg1.lp_name, arg1.description, 0x1::option::some<0x1::string::String>(arg1.image_url), 0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::features::new(v0, v1, arg3), arg3);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg1.registry, v2, 0x2::object::id<0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::jackson_lp::JacksonLP>(&v3));
        let v4 = LpCreatedByOldLp{
            distributor_id : 0x2::object::id<Distributor>(arg1),
            number         : v2,
            nft_id         : 0x2::object::id<0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::jackson_lp::JacksonLP>(&v3),
            old_lp_id      : 0x2::object::id<0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::jackson_lp::JacksonLP>(&arg2),
            minter         : 0x2::tx_context::sender(arg3),
            coin_type      : v0,
            amount         : v1,
        };
        0x2::event::emit<LpCreatedByOldLp>(v4);
        0x2::transfer::public_transfer<0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::jackson_lp::JacksonLP>(v3, 0x2::tx_context::sender(arg3));
        0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::jackson_lp::destroy(arg2);
    }

    fun init(arg0: DISTRIBUTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{lp_name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<DISTRIBUTOR>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::jackson_lp::JacksonLP>(&v4, v0, v2, arg1);
        0x2::display::update_version<0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::jackson_lp::JacksonLP>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::jackson_lp::JacksonLP>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun update_lp_distributor(arg0: &0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::admin::HandlerCap, arg1: &0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::system_state::SystemState, arg2: &mut Distributor, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: address) {
        0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::system_state::check_version(arg1);
        assert!(arg2.created_coin_value <= arg4, 3);
        arg2.single_coin_value = arg3;
        arg2.max_coin_value = arg4;
        arg2.round = arg5;
        arg2.support_check_round = arg6;
        arg2.is_active = arg7;
        arg2.recipient = arg8;
    }

    // decompiled from Move bytecode v6
}

