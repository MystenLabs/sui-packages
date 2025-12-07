module 0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::distributor {
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
        coin_name: 0x1::string::String,
        single_coin_value: u64,
        create_coin_unit: u64,
        max_coin_value: u64,
        created_coin_value: u64,
        round: u64,
        support_check_round: u64,
        recipient: address,
        coin_create_active: bool,
        nft_create_active: bool,
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

    public fun create_lp<T0>(arg0: &0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::system_state::SystemState, arg1: &mut Distributor, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::system_state::check_version(arg0);
        assert!(arg1.coin_create_active, 1);
        assert!(arg1.coin_type == 0x1::type_name::with_defining_ids<T0>(), 4);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2);
        assert!(v0 % arg1.create_coin_unit == 0, 2);
        arg1.created_coin_value = arg1.created_coin_value + v0;
        assert!(arg1.created_coin_value <= arg1.max_coin_value, 5);
        arg1.counter = arg1.counter + 1;
        let v1 = arg1.counter;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg1.recipient);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"Denomination"));
        let v3 = 0x1::u64::to_string(v0 / arg1.single_coin_value);
        0x1::string::append(&mut v3, 0x1::string::utf8(b" $"));
        0x1::string::append(&mut v3, arg1.coin_name);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v4, v3);
        let v5 = 0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::jackson_lp::new(0x2::object::id<Distributor>(arg1), arg1.round, v1, arg1.lp_name, arg1.description, 0x1::option::some<0x1::string::String>(arg1.image_url), 0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::features::new(0x1::type_name::with_defining_ids<T0>(), v0, arg3), 0x1::option::some<0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::attributes::Attributes>(0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::attributes::new(v2, v4, arg3)), arg3);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg1.registry, v1, 0x2::object::id<0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::jackson_lp::JacksonLP>(&v5));
        let v6 = LpCreated{
            distributor_id : 0x2::object::id<Distributor>(arg1),
            number         : v1,
            nft_id         : 0x2::object::id<0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::jackson_lp::JacksonLP>(&v5),
            minter         : 0x2::tx_context::sender(arg3),
            coin_type      : 0x1::type_name::with_defining_ids<T0>(),
            amount         : v0,
        };
        0x2::event::emit<LpCreated>(v6);
        0x2::transfer::public_transfer<0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::jackson_lp::JacksonLP>(v5, 0x2::tx_context::sender(arg3));
    }

    public fun create_lp_distributor<T0>(arg0: &0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::admin::HandlerCap, arg1: &0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::system_state::SystemState, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: bool, arg13: address, arg14: &mut 0x2::tx_context::TxContext) {
        0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::system_state::check_version(arg1);
        let v0 = Distributor{
            id                  : 0x2::object::new(arg14),
            lp_name             : arg2,
            description         : arg3,
            image_url           : arg4,
            counter             : 0,
            coin_type           : 0x1::type_name::with_defining_ids<T0>(),
            coin_name           : arg5,
            single_coin_value   : arg6,
            create_coin_unit    : arg7,
            max_coin_value      : arg8,
            created_coin_value  : 0,
            round               : arg9,
            support_check_round : arg10,
            recipient           : arg13,
            coin_create_active  : arg11,
            nft_create_active   : arg12,
            registry            : 0x2::table::new<u64, 0x2::object::ID>(arg14),
        };
        0x2::transfer::share_object<Distributor>(v0);
    }

    public fun create_lp_with_old_lp(arg0: &0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::system_state::SystemState, arg1: &mut Distributor, arg2: 0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::jackson_lp::JacksonLP, arg3: &mut 0x2::tx_context::TxContext) {
        0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::system_state::check_version(arg0);
        assert!(arg1.support_check_round == 0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::jackson_lp::round(&arg2), 6);
        let v0 = 0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::features::coin_type(0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::jackson_lp::features(&arg2));
        assert!(arg1.nft_create_active, 1);
        assert!(arg1.coin_type == v0, 4);
        let v1 = 0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::features::amount(0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::jackson_lp::features(&arg2));
        assert!(v1 % arg1.create_coin_unit == 0, 2);
        arg1.created_coin_value = arg1.created_coin_value + v1;
        assert!(arg1.created_coin_value <= arg1.max_coin_value, 5);
        arg1.counter = arg1.counter + 1;
        let v2 = arg1.counter;
        let v3 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"Denomination"));
        let v4 = 0x1::u64::to_string(v1 / arg1.single_coin_value);
        0x1::string::append(&mut v4, 0x1::string::utf8(b" $"));
        0x1::string::append(&mut v4, arg1.coin_name);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v5, v4);
        let v6 = 0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::jackson_lp::new(0x2::object::id<Distributor>(arg1), arg1.round, v2, arg1.lp_name, arg1.description, 0x1::option::some<0x1::string::String>(arg1.image_url), 0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::features::new(v0, v1, arg3), 0x1::option::some<0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::attributes::Attributes>(0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::attributes::new(v3, v5, arg3)), arg3);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg1.registry, v2, 0x2::object::id<0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::jackson_lp::JacksonLP>(&v6));
        let v7 = LpCreatedByOldLp{
            distributor_id : 0x2::object::id<Distributor>(arg1),
            number         : v2,
            nft_id         : 0x2::object::id<0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::jackson_lp::JacksonLP>(&v6),
            old_lp_id      : 0x2::object::id<0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::jackson_lp::JacksonLP>(&arg2),
            minter         : 0x2::tx_context::sender(arg3),
            coin_type      : v0,
            amount         : v1,
        };
        0x2::event::emit<LpCreatedByOldLp>(v7);
        0x2::transfer::public_transfer<0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::jackson_lp::JacksonLP>(v6, 0x2::tx_context::sender(arg3));
        0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::jackson_lp::destroy(arg2);
    }

    fun init(arg0: DISTRIBUTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"attributes"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{lp_name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{attributes}"));
        let v4 = 0x2::package::claim<DISTRIBUTOR>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::jackson_lp::JacksonLP>(&v4, v0, v2, arg1);
        0x2::display::update_version<0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::jackson_lp::JacksonLP>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::jackson_lp::JacksonLP>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun update_lp_distributor(arg0: &0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::admin::HandlerCap, arg1: &0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::system_state::SystemState, arg2: &mut Distributor, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: address) {
        0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::system_state::check_version(arg1);
        assert!(arg2.created_coin_value <= arg4, 3);
        arg2.create_coin_unit = arg3;
        arg2.max_coin_value = arg4;
        arg2.round = arg5;
        arg2.support_check_round = arg6;
        arg2.coin_create_active = arg7;
        arg2.nft_create_active = arg8;
        arg2.recipient = arg9;
    }

    // decompiled from Move bytecode v6
}

