module 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle_v2 {
    struct OracleV2 has key {
        id: 0x2::object::UID,
        version: u64,
        authority: 0x2::vec_set::VecSet<address>,
        allow_delay_sec: u64,
        feed_id_map: 0x2::vec_map::VecMap<u32, 0x1::type_name::TypeName>,
        latest_price: 0x2::vec_map::VecMap<0x1::type_name::TypeName, Price>,
        settle_price: 0x2::vec_map::VecMap<0x1::type_name::TypeName, Price>,
        u64_padding: vector<u64>,
    }

    struct Price has copy, drop, store {
        feed_id: u32,
        token_type: 0x1::type_name::TypeName,
        price: u64,
        ema_price: u64,
        update_timestamp: u64,
        u64_padding: vector<u64>,
    }

    entry fun add_authority(arg0: &mut OracleV2, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 13906834560890437631);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 13906834569480372223);
        0x2::vec_set::insert<address>(&mut arg0.authority, arg1);
    }

    entry fun add_latest_price_new_token<T0>(arg0: &mut OracleV2, arg1: u32, arg2: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 13906834621019979775);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 13906834629609914367);
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(check_price_fresh(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(&arg2) / 1000000, v1, arg0.allow_delay_sec), 13906834651084750847);
        let v2 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds(&arg2);
        assert!(0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v2) == 1, 13906834659674685439);
        let v3 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds(&arg2);
        let v4 = 0x1::type_name::with_defining_ids<T0>();
        let v5 = Price{
            feed_id          : arg1,
            token_type       : v4,
            price            : 0,
            ema_price        : 0,
            update_timestamp : 0,
            u64_padding      : vector[],
        };
        let v6 = &mut v5;
        update_price(v6, 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v3, 0), v1, arg0.allow_delay_sec, false);
        if (!0x2::vec_map::contains<u32, 0x1::type_name::TypeName>(&arg0.feed_id_map, &arg1)) {
            0x2::vec_map::insert<u32, 0x1::type_name::TypeName>(&mut arg0.feed_id_map, arg1, v4);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, Price>(&mut arg0.latest_price, v4, v5);
    }

    entry fun add_settle_price_new_token<T0>(arg0: &mut OracleV2, arg1: u32, arg2: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 13906834792818671615);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 13906834801408606207);
        assert!(check_price_fresh(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(&arg2) / 1000000, arg3, arg0.allow_delay_sec), 13906834818588475391);
        let v1 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds(&arg2);
        assert!(0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v1) == 1, 13906834827178409983);
        let v2 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds(&arg2);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        let v4 = Price{
            feed_id          : arg1,
            token_type       : v3,
            price            : 0,
            ema_price        : 0,
            update_timestamp : 0,
            u64_padding      : vector[],
        };
        let v5 = &mut v4;
        update_price(v5, 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v2, 0), arg3, arg0.allow_delay_sec, true);
        if (!0x2::vec_map::contains<u32, 0x1::type_name::TypeName>(&arg0.feed_id_map, &arg1)) {
            0x2::vec_map::insert<u32, 0x1::type_name::TypeName>(&mut arg0.feed_id_map, arg1, v3);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, Price>(&mut arg0.settle_price, v3, v4);
    }

    fun check_price_fresh(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 > arg1 && arg0 - arg1 < arg2 || arg1 - arg0 < arg2
    }

    entry fun create_oracle_v2(arg0: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::ManagerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleV2{
            id              : 0x2::object::new(arg2),
            version         : 3,
            authority       : 0x2::vec_set::singleton<address>(arg1),
            allow_delay_sec : 5,
            feed_id_map     : 0x2::vec_map::empty<u32, 0x1::type_name::TypeName>(),
            latest_price    : 0x2::vec_map::empty<0x1::type_name::TypeName, Price>(),
            settle_price    : 0x2::vec_map::empty<0x1::type_name::TypeName, Price>(),
            u64_padding     : vector[],
        };
        0x2::transfer::share_object<OracleV2>(v0);
    }

    public fun get_latest_price(arg0: &OracleV2, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : vector<u64> {
        assert!(arg0.version == 3, 13906835132121087999);
        let v0 = 0x2::vec_map::get<0x1::type_name::TypeName, Price>(&arg0.latest_price, &arg1);
        assert!(check_price_fresh(v0.update_timestamp, 0x2::clock::timestamp_ms(arg2) / 1000, arg0.allow_delay_sec), 13906835153595924479);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, v0.price);
        0x1::vector::push_back<u64>(v2, v0.ema_price);
        v1
    }

    public fun get_settle_price(arg0: &OracleV2, arg1: 0x1::type_name::TypeName, arg2: u64) : vector<u64> {
        assert!(arg0.version == 3, 13906835192250630143);
        let v0 = 0x2::vec_map::get<0x1::type_name::TypeName, Price>(&arg0.settle_price, &arg1);
        assert!(check_price_fresh(v0.update_timestamp, arg2, 1), 13906835209430499327);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, v0.price);
        0x1::vector::push_back<u64>(v2, v0.ema_price);
        v1
    }

    fun to_decimal(arg0: u64, arg1: u16) : u64 {
        if (arg1 > 8) {
            arg0 / 0x1::u64::pow(10, ((arg1 - 8) as u8))
        } else {
            arg0 * 0x1::u64::pow(10, ((8 - arg1) as u8))
        }
    }

    public fun update_latest_price(arg0: &mut OracleV2, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 13906834947437494271);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(check_price_fresh(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(&arg1) / 1000000, v0, arg0.allow_delay_sec), 13906834960322396159);
        let v1 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds(&arg1);
        0x1::vector::reverse<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v1)) {
            let v3 = 0x1::vector::pop_back<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&mut v1);
            let v4 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(&v3);
            let v5 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Price>(&mut arg0.latest_price, 0x2::vec_map::get<u32, 0x1::type_name::TypeName>(&arg0.feed_id_map, &v4));
            update_price(v5, &v3, v0, arg0.allow_delay_sec, false);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v1);
    }

    fun update_price(arg0: &mut Price, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed, arg2: u64, arg3: u64, arg4: bool) {
        assert!(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(arg1) == arg0.feed_id, 13906835230905335807);
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(arg1);
        let v1 = 0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v0);
        let v2 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v1);
        let v3 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::ema_price(arg1);
        let v4 = 0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v3);
        let v5 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v4);
        let v6 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(arg1);
        let v7 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&mut v6);
        let v8 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v7);
        let v9 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(arg1);
        let v10 = 0x1::option::extract<0x1::option::Option<u64>>(&mut v9);
        let v11 = 0x1::option::extract<u64>(&mut v10) / 1000000;
        let v12 = v11;
        assert!(check_price_fresh(v11, arg2, arg3), 13906835256675139583);
        if (arg4) {
            let v13 = v11 / 600 * 600;
            v12 = v13;
            if (arg0.update_timestamp == v13) {
                return
            };
        } else if (arg0.update_timestamp >= v11) {
            return
        };
        let v14 = to_decimal(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v2), v8);
        let v15 = to_decimal(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v5), v8);
        assert!(v14 > 0 && v15 > 0, 13906835338279518207);
        arg0.price = v14;
        arg0.ema_price = v15;
        arg0.update_timestamp = v12;
    }

    public fun update_settle_price(arg0: &mut OracleV2, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 13906835041926774783);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 13906835046221742079);
        assert!(check_price_fresh(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(&arg1) / 1000000, arg2, arg0.allow_delay_sec), 13906835059106643967);
        let v1 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds(&arg1);
        0x1::vector::reverse<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v1)) {
            let v3 = 0x1::vector::pop_back<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&mut v1);
            let v4 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(&v3);
            let v5 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Price>(&mut arg0.settle_price, 0x2::vec_map::get<u32, 0x1::type_name::TypeName>(&arg0.feed_id_map, &v4));
            update_price(v5, &v3, arg2, arg0.allow_delay_sec, true);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v1);
    }

    entry fun upgrade(arg0: &mut OracleV2, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 13906834517940764671);
        arg0.version = 3;
    }

    // decompiled from Move bytecode v7
}

