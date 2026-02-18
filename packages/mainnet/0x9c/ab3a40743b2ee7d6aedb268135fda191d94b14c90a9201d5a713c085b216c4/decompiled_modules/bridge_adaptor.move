module 0x9cab3a40743b2ee7d6aedb268135fda191d94b14c90a9201d5a713c085b216c4::bridge_adaptor {
    struct BridgeConfig has key {
        id: 0x2::object::UID,
        owner: address,
        is_paused: bool,
    }

    struct BridgeInitiated has copy, drop {
        sender: address,
        token_type: 0x1::string::String,
        amount: u64,
        target_chain: 0x1::string::String,
        target_address: 0x1::string::String,
    }

    public fun bridge_asset<T0>(arg0: &BridgeConfig, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeInitiated{
            sender         : 0x2::tx_context::sender(arg4),
            token_type     : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            amount         : 0x2::coin::value<T0>(&arg1),
            target_chain   : 0x1::string::utf8(arg2),
            target_address : 0x1::string::utf8(arg3),
        };
        0x2::event::emit<BridgeInitiated>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
    }

    public fun create_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeConfig{
            id        : 0x2::object::new(arg0),
            owner     : 0x2::tx_context::sender(arg0),
            is_paused : false,
        };
        0x2::transfer::share_object<BridgeConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

