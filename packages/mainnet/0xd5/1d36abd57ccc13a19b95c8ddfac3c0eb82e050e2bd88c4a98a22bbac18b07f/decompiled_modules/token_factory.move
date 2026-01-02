module 0xd51d36abd57ccc13a19b95c8ddfac3c0eb82e050e2bd88c4a98a22bbac18b07f::token_factory {
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

    public fun create_agent_with_aida<T0, T1>(arg0: &mut AgentRegistry, arg1: 0x2::coin::Coin<T1>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<vector<u8>>, arg9: 0x2::coin::TreasuryCap<T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (AgentMetadata, 0xd51d36abd57ccc13a19b95c8ddfac3c0eb82e050e2bd88c4a98a22bbac18b07f::bonding_curve::BondingCurve<T0>) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 >= 250000000000000, 1);
        let v1 = 0x2::tx_context::sender(arg11);
        let v2 = 0x2::clock::timestamp_ms(arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, @0x0);
        let v3 = AidaBurned{
            amount    : v0,
            burner    : v1,
            timestamp : v2,
        };
        0x2::event::emit<AidaBurned>(v3);
        let v4 = 0xd51d36abd57ccc13a19b95c8ddfac3c0eb82e050e2bd88c4a98a22bbac18b07f::bonding_curve::create_bonding_curve<T0>(arg9, v1, arg11);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = 0;
        while (v6 < 0x1::vector::length<vector<u8>>(&arg8)) {
            0x1::vector::push_back<0x1::string::String>(&mut v5, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg8, v6)));
            v6 = v6 + 1;
        };
        let v7 = AgentMetadata{
            id               : 0x2::object::new(arg11),
            name             : 0x1::string::utf8(arg2),
            ticker           : 0x1::string::utf8(arg3),
            description      : 0x1::string::utf8(arg4),
            image_url        : 0x1::string::utf8(arg5),
            creator          : v1,
            bonding_curve_id : 0x2::object::id_address<0xd51d36abd57ccc13a19b95c8ddfac3c0eb82e050e2bd88c4a98a22bbac18b07f::bonding_curve::BondingCurve<T0>>(&v4),
            created_at       : v2,
            personality      : 0x1::string::utf8(arg6),
            goals            : 0x1::string::utf8(arg7),
            capabilities     : v5,
        };
        arg0.agent_count = arg0.agent_count + 1;
        let v8 = AgentCreated{
            agent_id       : 0x2::object::id_address<AgentMetadata>(&v7),
            name           : 0x1::string::utf8(arg2),
            ticker         : 0x1::string::utf8(arg3),
            creator        : v1,
            payment_method : 0x1::string::utf8(b"AIDA"),
            timestamp      : v2,
        };
        0x2::event::emit<AgentCreated>(v8);
        (v7, v4)
    }

    public fun create_agent_with_sui<T0>(arg0: &mut AgentRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<vector<u8>>, arg9: 0x2::coin::TreasuryCap<T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (AgentMetadata, 0xd51d36abd57ccc13a19b95c8ddfac3c0eb82e050e2bd88c4a98a22bbac18b07f::bonding_curve::BondingCurve<T0>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 5000000000, 1);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x2::clock::timestamp_ms(arg10);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_fees_collected, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v2 = 0xd51d36abd57ccc13a19b95c8ddfac3c0eb82e050e2bd88c4a98a22bbac18b07f::bonding_curve::create_bonding_curve<T0>(arg9, v0, arg11);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<vector<u8>>(&arg8)) {
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg8, v4)));
            v4 = v4 + 1;
        };
        let v5 = AgentMetadata{
            id               : 0x2::object::new(arg11),
            name             : 0x1::string::utf8(arg2),
            ticker           : 0x1::string::utf8(arg3),
            description      : 0x1::string::utf8(arg4),
            image_url        : 0x1::string::utf8(arg5),
            creator          : v0,
            bonding_curve_id : 0x2::object::id_address<0xd51d36abd57ccc13a19b95c8ddfac3c0eb82e050e2bd88c4a98a22bbac18b07f::bonding_curve::BondingCurve<T0>>(&v2),
            created_at       : v1,
            personality      : 0x1::string::utf8(arg6),
            goals            : 0x1::string::utf8(arg7),
            capabilities     : v3,
        };
        arg0.agent_count = arg0.agent_count + 1;
        let v6 = AgentCreated{
            agent_id       : 0x2::object::id_address<AgentMetadata>(&v5),
            name           : 0x1::string::utf8(arg2),
            ticker         : 0x1::string::utf8(arg3),
            creator        : v0,
            payment_method : 0x1::string::utf8(b"SUI"),
            timestamp      : v1,
        };
        0x2::event::emit<AgentCreated>(v6);
        (v5, v2)
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

