module 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot {
    struct BOT has drop {
        dummy_field: bool,
    }

    struct CreateBotEvent has copy, drop, store {
        bot_id: 0x2::object::ID,
        funder: address,
        operator: address,
    }

    struct Bot<T0: store + key> has store, key {
        id: 0x2::object::UID,
        funder: address,
        operator: address,
        position: 0x1::option::Option<T0>,
        tokens: vector<0x1::type_name::TypeName>,
        cex_deposit_address: address,
    }

    public fun available_amount<T0: store + key, T1>(arg0: &Bot<T0>) : u64 {
        let v0 = 0x1::type_name::get<T1>();
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0
        } else {
            0x2::balance::value<T1>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.id, v0))
        }
    }

    public fun available_amounts<T0: store + key, T1, T2>(arg0: &Bot<T0>) : (u64, u64) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T2>();
        let v2 = if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0
        } else {
            0x2::balance::value<T1>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.id, v0))
        };
        let v3 = if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v1)) {
            0
        } else {
            0x2::balance::value<T2>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.id, v1))
        };
        (v2, v3)
    }

    public fun balance_is_empty<T0: store + key>(arg0: &Bot<T0>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.tokens)) {
            if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.tokens, v0))) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public(friend) fun borrow_position<T0: store + key>(arg0: &Bot<T0>) : &T0 {
        0x1::option::borrow<T0>(&arg0.position)
    }

    public(friend) fun borrow_position_mut<T0: store + key>(arg0: &mut Bot<T0>) : &mut T0 {
        0x1::option::borrow_mut<T0>(&mut arg0.position)
    }

    public(friend) fun cex_deposit_address<T0: store + key>(arg0: &Bot<T0>) : address {
        arg0.cex_deposit_address
    }

    public(friend) fun change_funder<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut Bot<T0>, arg2: address) {
        assert!(0x2::package::from_module<BOT>(arg0), 13906834887307952127);
        assert!(arg1.funder != arg2, 13906834891602919423);
        arg1.funder = arg2;
    }

    public(friend) fun change_operator<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut Bot<T0>, arg2: address) {
        assert!(0x2::package::from_module<BOT>(arg0), 13906834913077755903);
        assert!(arg1.operator != arg2, 13906834917372723199);
        arg1.operator = arg2;
    }

    public(friend) fun check_out<T0: store + key, T1, T2>(arg0: &mut Bot<T0>, arg1: u64, arg2: u64) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T2>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0) && 0x2::balance::value<T1>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.id, v0)) >= arg1, 1);
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v1) && 0x2::balance::value<T2>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.id, v1)) >= arg2, 2);
        (0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.id, v0), arg1), 0x2::balance::split<T2>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.id, v1), arg2))
    }

    public fun create_bot<T0: store + key>(arg0: &0x2::package::Publisher, arg1: address, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : Bot<T0> {
        assert!(0x2::package::from_module<BOT>(arg0), 13906834354732007423);
        let v0 = Bot<T0>{
            id                  : 0x2::object::new(arg4),
            funder              : arg2,
            operator            : arg1,
            position            : 0x1::option::none<T0>(),
            tokens              : 0x1::vector::empty<0x1::type_name::TypeName>(),
            cex_deposit_address : arg3,
        };
        let v1 = CreateBotEvent{
            bot_id   : 0x2::object::id<Bot<T0>>(&v0),
            funder   : arg2,
            operator : arg1,
        };
        0x2::event::emit<CreateBotEvent>(v1);
        v0
    }

    public(friend) fun deposit<T0: store + key, T1>(arg0: &mut Bot<T0>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x1::type_name::get<T1>();
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.id, v0, arg1);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.tokens, v0);
        } else {
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.id, v0), arg1);
        };
    }

    public(friend) fun extract_position<T0: store + key>(arg0: &mut Bot<T0>) : T0 {
        0x1::option::extract<T0>(&mut arg0.position)
    }

    public(friend) fun fill_position<T0: store + key>(arg0: &mut Bot<T0>, arg1: T0) {
        0x1::option::fill<T0>(&mut arg0.position, arg1);
    }

    public fun has_position<T0: store + key>(arg0: &Bot<T0>) : bool {
        0x1::option::is_some<T0>(&arg0.position)
    }

    fun init(arg0: BOT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<BOT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun only_funder<T0: store + key>(arg0: &Bot<T0>, arg1: address) {
        assert!(arg1 == arg0.funder, 4);
    }

    public fun only_operator<T0: store + key>(arg0: &Bot<T0>, arg1: address) {
        assert!(arg1 == arg0.operator, 6);
    }

    public fun only_operator_funder<T0: store + key>(arg0: &Bot<T0>, arg1: address) {
        assert!(arg1 == arg0.operator || arg1 == arg0.funder, 13906834457811222527);
    }

    public(friend) fun withdraw<T0: store + key, T1>(arg0: &mut Bot<T0>) : 0x2::balance::Balance<T1> {
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T1>()), 5);
        0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.id, 0x1::type_name::get<T1>())
    }

    // decompiled from Move bytecode v6
}

