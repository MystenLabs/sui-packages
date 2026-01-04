module 0xa81a8673cb8f2338a687b32d13871fe46c5a943e923435180bf09df1fb2b9a03::token_factory {
    struct AgentRegistry has key {
        id: 0x2::object::UID,
        agent_count: u64,
        sui_fees_collected: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AgentMetadata has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        ticker: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        bonding_curve_id: address,
        created_at: u64,
        personality: 0x1::string::String,
        goals: 0x1::string::String,
        capabilities: vector<0x1::string::String>,
    }

    struct AgentCreated has copy, drop {
        agent_id: address,
        name: 0x1::string::String,
        ticker: 0x1::string::String,
        creator: address,
        payment_method: 0x1::string::String,
        timestamp: u64,
    }

    struct AidaBurned has copy, drop {
        amount: u64,
        burner: address,
        timestamp: u64,
    }

    struct AgentToken has drop {
        dummy_field: bool,
    }

    public entry fun create_agent_with_aida<T0>(arg0: &mut AgentRegistry, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 250000000000000, 1);
        let v1 = 0x2::tx_context::sender(arg10);
        let v2 = 0x2::clock::timestamp_ms(arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
        let v3 = AidaBurned{
            amount    : v0,
            burner    : v1,
            timestamp : v2,
        };
        0x2::event::emit<AidaBurned>(v3);
        let v4 = AgentToken{dummy_field: false};
        let (v5, v6) = 0x2::coin::create_currency<AgentToken>(v4, 9, arg3, arg2, arg4, 0x1::option::none<0x2::url::Url>(), arg10);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AgentToken>>(v6);
        let v7 = 0xa81a8673cb8f2338a687b32d13871fe46c5a943e923435180bf09df1fb2b9a03::bonding_curve::create_bonding_curve<AgentToken>(v5, v1, arg10);
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = 0;
        while (v9 < 0x1::vector::length<vector<u8>>(&arg8)) {
            0x1::vector::push_back<0x1::string::String>(&mut v8, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg8, v9)));
            v9 = v9 + 1;
        };
        let v10 = AgentMetadata{
            id               : 0x2::object::new(arg10),
            name             : 0x1::string::utf8(arg2),
            ticker           : 0x1::string::utf8(arg3),
            description      : 0x1::string::utf8(arg4),
            image_url        : 0x1::string::utf8(arg5),
            creator          : v1,
            bonding_curve_id : 0x2::object::id_address<0xa81a8673cb8f2338a687b32d13871fe46c5a943e923435180bf09df1fb2b9a03::bonding_curve::BondingCurve<AgentToken>>(&v7),
            created_at       : v2,
            personality      : 0x1::string::utf8(arg6),
            goals            : 0x1::string::utf8(arg7),
            capabilities     : v8,
        };
        arg0.agent_count = arg0.agent_count + 1;
        let v11 = AgentCreated{
            agent_id       : 0x2::object::id_address<AgentMetadata>(&v10),
            name           : 0x1::string::utf8(arg2),
            ticker         : 0x1::string::utf8(arg3),
            creator        : v1,
            payment_method : 0x1::string::utf8(b"AIDA"),
            timestamp      : v2,
        };
        0x2::event::emit<AgentCreated>(v11);
        0x2::transfer::public_share_object<0xa81a8673cb8f2338a687b32d13871fe46c5a943e923435180bf09df1fb2b9a03::bonding_curve::BondingCurve<AgentToken>>(v7);
        0x2::transfer::transfer<AgentMetadata>(v10, v1);
    }

    public entry fun create_agent_with_sui(arg0: &mut AgentRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 5000000000, 1);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_fees_collected, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v2 = AgentToken{dummy_field: false};
        let (v3, v4) = 0x2::coin::create_currency<AgentToken>(v2, 9, arg3, arg2, arg4, 0x1::option::none<0x2::url::Url>(), arg10);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AgentToken>>(v4);
        let v5 = 0xa81a8673cb8f2338a687b32d13871fe46c5a943e923435180bf09df1fb2b9a03::bonding_curve::create_bonding_curve<AgentToken>(v3, v0, arg10);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<vector<u8>>(&arg8)) {
            0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg8, v7)));
            v7 = v7 + 1;
        };
        let v8 = AgentMetadata{
            id               : 0x2::object::new(arg10),
            name             : 0x1::string::utf8(arg2),
            ticker           : 0x1::string::utf8(arg3),
            description      : 0x1::string::utf8(arg4),
            image_url        : 0x1::string::utf8(arg5),
            creator          : v0,
            bonding_curve_id : 0x2::object::id_address<0xa81a8673cb8f2338a687b32d13871fe46c5a943e923435180bf09df1fb2b9a03::bonding_curve::BondingCurve<AgentToken>>(&v5),
            created_at       : v1,
            personality      : 0x1::string::utf8(arg6),
            goals            : 0x1::string::utf8(arg7),
            capabilities     : v6,
        };
        arg0.agent_count = arg0.agent_count + 1;
        let v9 = AgentCreated{
            agent_id       : 0x2::object::id_address<AgentMetadata>(&v8),
            name           : 0x1::string::utf8(arg2),
            ticker         : 0x1::string::utf8(arg3),
            creator        : v0,
            payment_method : 0x1::string::utf8(b"SUI"),
            timestamp      : v1,
        };
        0x2::event::emit<AgentCreated>(v9);
        0x2::transfer::public_share_object<0xa81a8673cb8f2338a687b32d13871fe46c5a943e923435180bf09df1fb2b9a03::bonding_curve::BondingCurve<AgentToken>>(v5);
        0x2::transfer::transfer<AgentMetadata>(v8, v0);
    }

    public fun get_agent_count(arg0: &AgentRegistry) : u64 {
        arg0.agent_count
    }

    public fun get_agent_creator(arg0: &AgentMetadata) : address {
        arg0.creator
    }

    public fun get_agent_name(arg0: &AgentMetadata) : 0x1::string::String {
        arg0.name
    }

    public fun get_agent_ticker(arg0: &AgentMetadata) : 0x1::string::String {
        arg0.ticker
    }

    public fun get_aida_creation_fee() : u64 {
        250000000000000
    }

    public fun get_bonding_curve_id(arg0: &AgentMetadata) : address {
        arg0.bonding_curve_id
    }

    public fun get_sui_creation_fee() : u64 {
        5000000000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AgentRegistry{
            id                 : 0x2::object::new(arg0),
            agent_count        : 0,
            sui_fees_collected : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<AgentRegistry>(v0);
    }

    public fun withdraw_fees(arg0: &mut AgentRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg1) == @0x2c478b5f158e037cb21b3443a5a3512f6fee0b9a16d7a261baa00ddca69d6fc5, 0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_fees_collected, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_fees_collected)), arg1)
    }

    // decompiled from Move bytecode v6
}

