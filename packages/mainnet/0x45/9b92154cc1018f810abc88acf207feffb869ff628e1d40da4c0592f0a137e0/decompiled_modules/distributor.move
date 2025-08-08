module 0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::distributor {
    struct DISTRIBUTOR has drop {
        dummy_field: bool,
    }

    struct Distributor has store, key {
        id: 0x2::object::UID,
        lp_name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        coin_type: 0x1::type_name::TypeName,
        coin_value: u64,
        max_create: u64,
        counter: u64,
        recipient: address,
        is_active: bool,
        is_redeem_open: bool,
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

    struct LpRedeem has copy, drop {
        distributor_id: 0x2::object::ID,
        number: u64,
        nft_id: 0x2::object::ID,
        owner: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun create_lp<T0>(arg0: &0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::system_state::SystemState, arg1: &mut Distributor, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::system_state::check_version(arg0);
        assert!(arg1.is_active, 1);
        assert!(arg1.coin_type == 0x1::type_name::get<T0>(), 4);
        let v0 = arg1.counter + 1;
        assert!(v0 <= arg1.max_create, 5);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 <= arg1.coin_value, 2);
        arg1.counter = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg1.recipient);
        let v2 = 0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::jackson_lp::new(0x2::object::id<Distributor>(arg1), v0, arg1.lp_name, arg1.description, 0x1::option::some<0x1::string::String>(arg1.image_url), 0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::features::new(0x1::type_name::get<T0>(), v1, arg3), arg3);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg1.registry, v0, 0x2::object::id<0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::jackson_lp::JacksonLPv2>(&v2));
        let v3 = LpCreated{
            distributor_id : 0x2::object::id<Distributor>(arg1),
            number         : v0,
            nft_id         : 0x2::object::id<0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::jackson_lp::JacksonLPv2>(&v2),
            minter         : 0x2::tx_context::sender(arg3),
            coin_type      : 0x1::type_name::get<T0>(),
            amount         : v1,
        };
        0x2::event::emit<LpCreated>(v3);
        0x2::transfer::public_transfer<0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::jackson_lp::JacksonLPv2>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun create_lp_distributor<T0>(arg0: &0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::admin::HandlerCap, arg1: &0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::system_state::SystemState, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::system_state::check_version(arg1);
        let v0 = Distributor{
            id             : 0x2::object::new(arg10),
            lp_name        : arg2,
            description    : arg3,
            image_url      : arg4,
            coin_type      : 0x1::type_name::get<T0>(),
            coin_value     : arg5,
            max_create     : arg6,
            counter        : 0,
            recipient      : arg9,
            is_active      : arg7,
            is_redeem_open : arg8,
            registry       : 0x2::table::new<u64, 0x2::object::ID>(arg10),
        };
        0x2::transfer::share_object<Distributor>(v0);
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
        let v5 = 0x2::display::new_with_fields<0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::jackson_lp::JacksonLPv2>(&v4, v0, v2, arg1);
        0x2::display::update_version<0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::jackson_lp::JacksonLPv2>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::jackson_lp::JacksonLPv2>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun redeem_lp(arg0: &0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::system_state::SystemState, arg1: &Distributor, arg2: 0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::jackson_lp::JacksonLPv2, arg3: &mut 0x2::tx_context::TxContext) {
        0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::system_state::check_version(arg0);
        assert!(0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::jackson_lp::distributor_id(&arg2) == 0x2::object::id<Distributor>(arg1), 6);
        assert!(arg1.is_redeem_open, 7);
        let v0 = 0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::jackson_lp::features(&arg2);
        let v1 = LpRedeem{
            distributor_id : 0x2::object::id<Distributor>(arg1),
            number         : 0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::jackson_lp::number(&arg2),
            nft_id         : 0x2::object::id<0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::jackson_lp::JacksonLPv2>(&arg2),
            owner          : 0x2::tx_context::sender(arg3),
            coin_type      : 0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::features::coin_type(v0),
            amount         : 0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::features::amount(v0),
        };
        0x2::event::emit<LpRedeem>(v1);
        0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::jackson_lp::destroy(arg2);
    }

    public fun update_lp_distributor(arg0: &0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::admin::HandlerCap, arg1: &0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::system_state::SystemState, arg2: &mut Distributor, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: address) {
        0x459b92154cc1018f810abc88acf207feffb869ff628e1d40da4c0592f0a137e0::system_state::check_version(arg1);
        assert!(arg2.counter <= arg4, 3);
        arg2.coin_value = arg3;
        arg2.max_create = arg4;
        arg2.is_active = arg5;
        arg2.is_redeem_open = arg6;
        arg2.recipient = arg7;
    }

    // decompiled from Move bytecode v6
}

