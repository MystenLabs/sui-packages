module 0x3650517d2d3c9809f0e5ebd6e435e95eaccdb46bf80ea346182d3950f28c31f2::suiai {
    struct SUIAI has drop {
        dummy_field: bool,
    }

    struct SuiAi<phantom T0> has store, key {
        id: 0x2::object::UID,
        init_coin_fee: u64,
        chat_fee: u64,
        admin: address,
    }

    struct AgentCreatedEvent has copy, drop {
        sender: address,
        token_address: 0x1::type_name::TypeName,
        x: 0x1::string::String,
        telegram: 0x1::string::String,
        website: 0x1::string::String,
        agent_age: u8,
        personality: 0x1::string::String,
        first_message: 0x1::string::String,
        lore: 0x1::string::String,
        style: 0x1::string::String,
        adjective: 0x1::string::String,
        knowledge: 0x1::string::String,
    }

    struct MessageEvent has copy, drop {
        token_address: 0x1::type_name::TypeName,
        sender: address,
        message: 0x1::string::String,
    }

    fun init(arg0: SUIAI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SUIAI>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun init_module<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiAi<T0>{
            id            : 0x2::object::new(arg0),
            init_coin_fee : 69000000000,
            chat_fee      : 6900000,
            admin         : @0xf2db7827e4f6ea694f3f1526a7d61b802bdd8fddc176ac86a37db250703090fc,
        };
        0x2::transfer::share_object<SuiAi<T0>>(v0);
    }

    public entry fun send_message<T0, T1>(arg0: &mut SuiAi<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) == arg0.chat_fee, 0);
        let v0 = MessageEvent{
            token_address : 0x1::type_name::get<T1>(),
            sender        : 0x2::tx_context::sender(arg3),
            message       : arg2,
        };
        0x2::event::emit<MessageEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
    }

    public entry fun start_new_coin<T0, T1>(arg0: &mut SuiAi<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u8, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) == arg0.init_coin_fee, 0);
        let v0 = AgentCreatedEvent{
            sender        : 0x2::tx_context::sender(arg12),
            token_address : 0x1::type_name::get<T1>(),
            x             : arg2,
            telegram      : arg3,
            website       : arg4,
            agent_age     : arg5,
            personality   : arg6,
            first_message : arg7,
            lore          : arg8,
            style         : arg9,
            adjective     : arg10,
            knowledge     : arg11,
        };
        0x2::event::emit<AgentCreatedEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
    }

    public entry fun update_init_fee<T0>(arg0: &mut SuiAi<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.init_coin_fee = arg1;
    }

    // decompiled from Move bytecode v6
}

