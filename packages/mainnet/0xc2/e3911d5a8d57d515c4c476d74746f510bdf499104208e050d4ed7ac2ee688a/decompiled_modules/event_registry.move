module 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::event_registry {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        supported_coins: 0x2::vec_map::VecMap<vector<u8>, bool>,
        protocol_fee: u64,
        protocol_fee_address: address,
        operators: vector<address>,
    }

    struct ConfigUpdated has copy, drop {
        dummy_field: bool,
    }

    public entry fun create_event(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: u32, arg6: u64, arg7: u64, arg8: u16, arg9: u16, arg10: &Config, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == 0x1::vector::length<0x1::string::String>(&arg4), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg10.operators)) {
            0x2::transfer::public_transfer<0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::attendance::OperatorCap>(0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::attendance::create_op_cap(0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::event::create_event(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11), arg11), *0x1::vector::borrow<address>(&arg10.operators, v0));
            v0 = v0 + 1;
        };
    }

    public fun get_protocol_info(arg0: &Config) : (u64, address) {
        (arg0.protocol_fee, arg0.protocol_fee_address)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Config{
            id                   : 0x2::object::new(arg0),
            supported_coins      : 0x2::vec_map::empty<vector<u8>, bool>(),
            protocol_fee         : 0,
            protocol_fee_address : 0x2::tx_context::sender(arg0),
            operators            : vector[],
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Config>(v1);
    }

    public fun is_coin_supported(arg0: &Config, arg1: &vector<u8>) : bool {
        0x2::vec_map::contains<vector<u8>, bool>(&arg0.supported_coins, arg1)
    }

    public entry fun update_config(arg0: &AdminCap, arg1: &mut Config, arg2: vector<0x1::ascii::String>, arg3: u64, arg4: address, arg5: vector<address>) {
        arg1.supported_coins = 0x2::vec_map::empty<vector<u8>, bool>();
        arg1.protocol_fee = arg3;
        arg1.protocol_fee_address = arg4;
        arg1.operators = arg5;
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::ascii::String>(&arg2)) {
            0x2::vec_map::insert<vector<u8>, bool>(&mut arg1.supported_coins, 0x1::hash::sha3_256(0x1::ascii::into_bytes(*0x1::vector::borrow<0x1::ascii::String>(&arg2, v0))), true);
            v0 = v0 + 1;
        };
        let v1 = ConfigUpdated{dummy_field: false};
        0x2::event::emit<ConfigUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

