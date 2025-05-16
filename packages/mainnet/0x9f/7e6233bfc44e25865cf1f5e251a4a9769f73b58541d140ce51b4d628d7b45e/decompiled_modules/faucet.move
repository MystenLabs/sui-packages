module 0x9f7e6233bfc44e25865cf1f5e251a4a9769f73b58541d140ce51b4d628d7b45e::faucet {
    struct AgentCreated has copy, drop, store {
        decimals: u8,
        name: vector<u8>,
        symbol: vector<u8>,
        description: vector<u8>,
        icon_url: vector<u8>,
        _phantom: bool,
    }

    struct AgentFactory has key {
        id: 0x2::object::UID,
        next_agent_str: 0x1::string::String,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun create<T0: drop>(arg0: &AdminCap, arg1: T0, arg2: &mut AgentFactory, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::url::new_unsafe_from_bytes(arg7);
        let v0 = AgentCreated{
            decimals    : arg3,
            name        : arg4,
            symbol      : arg5,
            description : arg6,
            icon_url    : arg7,
            _phantom    : true,
        };
        0x2::event::emit<AgentCreated>(v0);
    }

    public fun increment_agent_str(arg0: &mut 0x1::string::String) {
        let v0 = 0x1::u64::to_string(parse_u64_from_bytes(0x1::string::into_bytes(0x1::string::substring(arg0, 6, 0x1::string::length(arg0)))) + 1);
        while (0x1::string::length(&v0) < 4) {
            let v1 = 0x1::string::utf8(b"0");
            0x1::string::append(&mut v1, v0);
            v0 = v1;
        };
        let v2 = 0x1::string::utf8(b"AGENT_");
        0x1::string::append(&mut v2, v0);
        *arg0 = v2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AgentFactory{
            id             : 0x2::object::new(arg0),
            next_agent_str : 0x1::string::utf8(b"AGENT_0000"),
        };
        0x2::transfer::share_object<AgentFactory>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T0>(arg0, arg1, arg2, arg3);
    }

    fun parse_u64_from_bytes(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v1);
            assert!(v2 >= 48 && v2 <= 57, 0);
            let v3 = v0 * 10;
            v0 = v3 + ((v2 - 48) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

