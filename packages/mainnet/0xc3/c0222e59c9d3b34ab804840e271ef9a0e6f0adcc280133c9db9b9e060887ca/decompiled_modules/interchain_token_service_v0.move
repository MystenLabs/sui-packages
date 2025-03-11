module 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0 {
    struct InterchainTokenService_v0 has store {
        channel: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel,
        trusted_chains: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::trusted_chains::TrustedChains,
        unregistered_coin_types: 0x2::table::Table<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::UnregisteredTokenId, 0x1::type_name::TypeName>,
        unregistered_coins: 0x2::bag::Bag,
        registered_coin_types: 0x2::table::Table<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, 0x1::type_name::TypeName>,
        registered_coins: 0x2::bag::Bag,
        relayer_discovery_id: 0x2::object::ID,
        its_hub_address: 0x1::ascii::String,
        chain_name_hash: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32,
        version_control: 0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl,
    }

    public(friend) fun new(arg0: 0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) : InterchainTokenService_v0 {
        let v0 = 0x1::ascii::into_bytes(arg1);
        InterchainTokenService_v0{
            channel                 : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::new(arg3),
            trusted_chains          : 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::trusted_chains::new(arg3),
            unregistered_coin_types : 0x2::table::new<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::UnregisteredTokenId, 0x1::type_name::TypeName>(arg3),
            unregistered_coins      : 0x2::bag::new(arg3),
            registered_coin_types   : 0x2::table::new<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, 0x1::type_name::TypeName>(arg3),
            registered_coins        : 0x2::bag::new(arg3),
            relayer_discovery_id    : 0x2::object::id_from_address(@0x0),
            its_hub_address         : arg2,
            chain_name_hash         : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::from_bytes(0x2::hash::keccak256(&v0)),
            version_control         : arg0,
        }
    }

    public(friend) fun version_control(arg0: &InterchainTokenService_v0) : &0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl {
        &arg0.version_control
    }

    public(friend) fun allow_function(arg0: &mut InterchainTokenService_v0, arg1: u64, arg2: 0x1::ascii::String) {
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::allow_function(&mut arg0.version_control, arg1, arg2);
    }

    public(friend) fun disallow_function(arg0: &mut InterchainTokenService_v0, arg1: u64, arg2: 0x1::ascii::String) {
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::disallow_function(&mut arg0.version_control, arg1, arg2);
    }

    public(friend) fun coin_data<T0>(arg0: &InterchainTokenService_v0, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId) : &0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_data::CoinData<T0> {
        assert!(0x2::bag::contains<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId>(&arg0.registered_coins, arg1), 9223374051194437633);
        0x2::bag::borrow<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_data::CoinData<T0>>(&arg0.registered_coins, arg1)
    }

    fun coin_info<T0>(arg0: &InterchainTokenService_v0, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId) : &0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info::CoinInfo<T0> {
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_data::coin_info<T0>(coin_data<T0>(arg0, arg1))
    }

    fun coin_management_mut<T0>(arg0: &mut InterchainTokenService_v0, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId) : &mut 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::CoinManagement<T0> {
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_data::coin_management_mut<T0>(0x2::bag::borrow_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_data::CoinData<T0>>(&mut arg0.registered_coins, arg1))
    }

    public(friend) fun set_flow_limit<T0>(arg0: &mut InterchainTokenService_v0, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg2: 0x1::option::Option<u64>) {
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::set_flow_limit_internal<T0>(coin_management_mut<T0>(arg0, arg1), arg2);
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::events::flow_limit_set<T0>(arg1, arg2);
    }

    fun add_registered_coin<T0>(arg0: &mut InterchainTokenService_v0, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::CoinManagement<T0>, arg3: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info::CoinInfo<T0>) {
        0x2::bag::add<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_data::CoinData<T0>>(&mut arg0.registered_coins, arg1, 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_data::new<T0>(arg2, arg3));
        add_registered_coin_type(arg0, arg1, 0x1::type_name::get<T0>());
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::events::coin_registered<T0>(arg1);
    }

    fun add_registered_coin_type(arg0: &mut InterchainTokenService_v0, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg2: 0x1::type_name::TypeName) {
        0x2::table::add<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, 0x1::type_name::TypeName>(&mut arg0.registered_coin_types, arg1, arg2);
    }

    public(friend) fun add_trusted_chain(arg0: &mut InterchainTokenService_v0, arg1: 0x1::ascii::String) {
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::trusted_chains::add(&mut arg0.trusted_chains, arg1);
    }

    public(friend) fun add_trusted_chains(arg0: &mut InterchainTokenService_v0, arg1: vector<0x1::ascii::String>) {
        0x1::vector::reverse<0x1::ascii::String>(&mut arg1);
        while (0x1::vector::length<0x1::ascii::String>(&arg1) != 0) {
            add_trusted_chain(arg0, 0x1::vector::pop_back<0x1::ascii::String>(&mut arg1));
        };
        0x1::vector::destroy_empty<0x1::ascii::String>(arg1);
    }

    fun add_unregistered_coin<T0>(arg0: &mut InterchainTokenService_v0, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::UnregisteredTokenId, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::CoinMetadata<T0>) {
        0x2::bag::add<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::UnregisteredTokenId, 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::unregistered_coin_data::UnregisteredCoinData<T0>>(&mut arg0.unregistered_coins, arg1, 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::unregistered_coin_data::new<T0>(arg2, arg3));
        add_unregistered_coin_type(arg0, arg1, 0x1::type_name::get<T0>());
    }

    fun add_unregistered_coin_type(arg0: &mut InterchainTokenService_v0, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::UnregisteredTokenId, arg2: 0x1::type_name::TypeName) {
        0x2::table::add<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::UnregisteredTokenId, 0x1::type_name::TypeName>(&mut arg0.unregistered_coin_types, arg1, arg2);
    }

    public(friend) fun burn_as_distributor<T0>(arg0: &mut InterchainTokenService_v0, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg3: 0x2::coin::Coin<T0>) {
        let v0 = coin_management_mut<T0>(arg0, arg2);
        assert!(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::is_distributor<T0>(v0, 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::to_address(arg1)), 9223373802087251983);
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::burn<T0>(v0, 0x2::coin::into_balance<T0>(arg3));
    }

    public(friend) fun channel(arg0: &InterchainTokenService_v0) : &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel {
        &arg0.channel
    }

    public(friend) fun channel_address(arg0: &InterchainTokenService_v0) : address {
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::to_address(&arg0.channel)
    }

    fun decode_approved_message(arg0: &InterchainTokenService_v0, arg1: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage) : (0x1::ascii::String, vector<u8>, 0x1::ascii::String) {
        let (v0, v1, v2, v3) = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::consume_approved_message(&arg0.channel, arg1);
        assert!(0x1::ascii::into_bytes(v0) == b"axelar", 9223374549411954709);
        assert!(v2 == arg0.its_hub_address, 9223374553705742339);
        let v4 = 0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::new_reader(v3);
        assert!(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_u256(&mut v4) == 4, 9223374566590775301);
        let v5 = 0x1::ascii::string(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_bytes(&mut v4));
        assert!(is_trusted_chain(arg0, v5), 9223374588066660373);
        (v5, 0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_bytes(&mut v4), v1)
    }

    public(friend) fun deploy_remote_interchain_token<T0>(arg0: &InterchainTokenService_v0, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg2: 0x1::ascii::String) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket {
        let v0 = coin_info<T0>(arg0, arg1);
        let v1 = 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info::name<T0>(v0);
        let v2 = 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info::symbol<T0>(v0);
        let v3 = 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info::decimals<T0>(v0);
        let v4 = 0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::new_writer(6);
        0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::write_bytes(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::write_u256(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::write_bytes(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::write_bytes(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::write_u256(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::write_u256(&mut v4, 1), 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::to_u256(&arg1)), *0x1::string::as_bytes(&v1)), *0x1::ascii::as_bytes(&v2)), (v3 as u256)), 0x1::vector::empty<u8>());
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::events::interchain_token_deployment_started<T0>(arg1, v1, v2, v3, arg2);
        prepare_hub_message(arg0, 0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::into_bytes(v4), arg2)
    }

    public(friend) fun give_unregistered_coin<T0>(arg0: &mut InterchainTokenService_v0, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>) {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 9223373548684312593);
        let v0 = 0x2::coin::get_icon_url<T0>(&arg2);
        assert!(0x1::option::is_none<0x2::url::Url>(&v0), 9223373552979410963);
        0x2::coin::update_description<T0>(&arg1, &mut arg2, 0x1::string::utf8(b""));
        let v1 = 0x2::coin::get_decimals<T0>(&arg2);
        let v2 = 0x2::coin::get_symbol<T0>(&arg2);
        let v3 = 0x1::type_name::get<T0>();
        let v4 = 0x1::type_name::get_module(&v3);
        let v5 = 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::utils::module_from_symbol(&v2);
        assert!(&v4 == &v5, 9223373587338756109);
        let v6 = 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::unregistered_token_id(&v2, v1);
        add_unregistered_coin<T0>(arg0, v6, arg1, arg2);
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::events::unregistered_coin_received<T0>(v6, v2, v1);
    }

    fun is_trusted_chain(arg0: &InterchainTokenService_v0, arg1: 0x1::ascii::String) : bool {
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::trusted_chains::is_trusted(&arg0.trusted_chains, arg1)
    }

    public(friend) fun mint_as_distributor<T0>(arg0: &mut InterchainTokenService_v0, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = coin_management_mut<T0>(arg0, arg2);
        assert!(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::is_distributor<T0>(v0, 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::to_address(arg1)), 9223373686123134991);
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::mint<T0>(v0, arg3, arg4)
    }

    public(friend) fun mint_to_as_distributor<T0>(arg0: &mut InterchainTokenService_v0, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = coin_management_mut<T0>(arg0, arg2);
        assert!(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::is_distributor<T0>(v0, 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::to_address(arg1)), 9223373754842611727);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::mint<T0>(v0, arg4, arg5), arg3);
    }

    fun prepare_hub_message(arg0: &InterchainTokenService_v0, arg1: vector<u8>, arg2: 0x1::ascii::String) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket {
        assert!(is_trusted_chain(arg0, arg2), 9223374437742805013);
        let v0 = 0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::new_writer(3);
        0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::write_u256(&mut v0, 3);
        0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::write_bytes(&mut v0, 0x1::ascii::into_bytes(arg2));
        0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::write_bytes(&mut v0, arg1);
        prepare_message(arg0, 0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::into_bytes(v0))
    }

    fun prepare_message(arg0: &InterchainTokenService_v0, arg1: vector<u8>) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket {
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway::prepare_message(&arg0.channel, 0x1::ascii::string(b"axelar"), arg0.its_hub_address, arg1)
    }

    fun read_amount(arg0: &mut 0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::AbiReader) : u64 {
        let v0 = 0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_u256(arg0);
        let v1 = if (v0 > 18446744073709551615) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>((v0 as u64))
        };
        let v2 = v1;
        assert!(0x1::option::is_some<u64>(&v2), 9223374618131693593);
        0x1::option::destroy_some<u64>(v2)
    }

    public(friend) fun receive_deploy_interchain_token<T0>(arg0: &mut InterchainTokenService_v0, arg1: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage) {
        let (_, v1, _) = decode_approved_message(arg0, arg1);
        let v3 = 0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::new_reader(v1);
        assert!(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_u256(&mut v3) == 1, 9223373424129474565);
        let v4 = 0x1::ascii::string(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_bytes(&mut v3));
        let v5 = 0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_bytes(&mut v3);
        let (v6, v7) = remove_unregistered_coin<T0>(arg0, 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::unregistered_token_id(&v4, (0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_u256(&mut v3) as u8)));
        let v8 = v7;
        let v9 = v6;
        0x2::coin::update_name<T0>(&v9, &mut v8, 0x1::string::utf8(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_bytes(&mut v3)));
        let v10 = 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::new_with_cap<T0>(v9);
        if (0x1::vector::length<u8>(&v5) > 0) {
            0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::add_distributor<T0>(&mut v10, 0x2::address::from_bytes(v5));
        };
        add_registered_coin<T0>(arg0, 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::from_u256(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_u256(&mut v3)), v10, 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info::from_metadata<T0>(v8));
    }

    public(friend) fun receive_interchain_transfer<T0>(arg0: &mut InterchainTokenService_v0, arg1: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = decode_approved_message(arg0, arg1);
        let v3 = 0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::new_reader(v1);
        assert!(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_u256(&mut v3) == 0, 9223373140661633029);
        let v4 = 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::from_u256(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_u256(&mut v3));
        let v5 = 0x2::address::from_bytes(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_bytes(&mut v3));
        let v6 = &mut v3;
        let v7 = read_amount(v6);
        let v8 = 0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_bytes(&mut v3);
        assert!(0x1::vector::is_empty<u8>(&v8), 9223373175021633545);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::give_coin<T0>(coin_management_mut<T0>(arg0, v4), v7, arg2, arg3), v5);
        let v9 = b"";
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::events::interchain_transfer_received<T0>(v2, v4, v0, 0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_bytes(&mut v3), v5, v7, &v9);
    }

    public(friend) fun receive_interchain_transfer_with_data<T0>(arg0: &mut InterchainTokenService_v0, arg1: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage, arg2: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x1::ascii::String, vector<u8>, vector<u8>, 0x2::coin::Coin<T0>) {
        let (v0, v1, v2) = decode_approved_message(arg0, arg1);
        let v3 = 0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::new_reader(v1);
        assert!(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_u256(&mut v3) == 0, 9223373295280455685);
        let v4 = 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::from_u256(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_u256(&mut v3));
        let v5 = 0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_bytes(&mut v3);
        let v6 = 0x2::address::from_bytes(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_bytes(&mut v3));
        let v7 = &mut v3;
        let v8 = read_amount(v7);
        let v9 = 0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::read_bytes(&mut v3);
        assert!(v6 == 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::to_address(arg2), 9223373333935292423);
        assert!(!0x1::vector::is_empty<u8>(&v9), 9223373338230521867);
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::events::interchain_transfer_received<T0>(v2, v4, v0, v5, v6, v8, &v9);
        (v0, v5, v9, 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::give_coin<T0>(coin_management_mut<T0>(arg0, v4), v8, arg3, arg4))
    }

    public(friend) fun register_coin<T0>(arg0: &mut InterchainTokenService_v0, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info::CoinInfo<T0>, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::CoinManagement<T0>) : 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId {
        let v0 = 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::from_coin_data<T0>(&arg0.chain_name_hash, &arg1, &arg2);
        add_registered_coin<T0>(arg0, v0, arg2, arg1);
        v0
    }

    public(friend) fun registered_coin_type(arg0: &InterchainTokenService_v0, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId) : &0x1::type_name::TypeName {
        assert!(0x2::table::contains<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, 0x1::type_name::TypeName>(&arg0.registered_coin_types, arg1), 9223372543660916737);
        0x2::table::borrow<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, 0x1::type_name::TypeName>(&arg0.registered_coin_types, arg1)
    }

    public(friend) fun relayer_discovery_id(arg0: &InterchainTokenService_v0) : 0x2::object::ID {
        arg0.relayer_discovery_id
    }

    public(friend) fun remove_trusted_chain(arg0: &mut InterchainTokenService_v0, arg1: 0x1::ascii::String) {
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::trusted_chains::remove(&mut arg0.trusted_chains, arg1);
    }

    public(friend) fun remove_trusted_chains(arg0: &mut InterchainTokenService_v0, arg1: vector<0x1::ascii::String>) {
        0x1::vector::reverse<0x1::ascii::String>(&mut arg1);
        while (0x1::vector::length<0x1::ascii::String>(&arg1) != 0) {
            remove_trusted_chain(arg0, 0x1::vector::pop_back<0x1::ascii::String>(&mut arg1));
        };
        0x1::vector::destroy_empty<0x1::ascii::String>(arg1);
    }

    fun remove_unregistered_coin<T0>(arg0: &mut InterchainTokenService_v0, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::UnregisteredTokenId) : (0x2::coin::TreasuryCap<T0>, 0x2::coin::CoinMetadata<T0>) {
        let (v0, v1) = 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::unregistered_coin_data::destroy<T0>(0x2::bag::remove<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::UnregisteredTokenId, 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::unregistered_coin_data::UnregisteredCoinData<T0>>(&mut arg0.unregistered_coins, arg1));
        remove_unregistered_coin_type(arg0, arg1);
        (v0, v1)
    }

    fun remove_unregistered_coin_type(arg0: &mut InterchainTokenService_v0, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::UnregisteredTokenId) : 0x1::type_name::TypeName {
        0x2::table::remove<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::UnregisteredTokenId, 0x1::type_name::TypeName>(&mut arg0.unregistered_coin_types, arg1)
    }

    public(friend) fun send_interchain_transfer<T0>(arg0: &mut InterchainTokenService_v0, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_transfer_ticket::InterchainTransferTicket<T0>, arg2: u64, arg3: &0x2::clock::Clock) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket {
        let (v0, v1, v2, v3, v4, v5, v6) = 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_transfer_ticket::destroy<T0>(arg1);
        let v7 = v0;
        assert!(v6 <= arg2, 9223372977454055447);
        let v8 = coin_management_mut<T0>(arg0, v7);
        let v9 = 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::take_balance<T0>(v8, v1, arg3);
        let (_, v11) = 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::utils::decode_metadata(v5);
        let v12 = v11;
        let v13 = 0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::new_writer(6);
        0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::write_bytes(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::write_u256(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::write_bytes(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::write_bytes(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::write_u256(0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::write_u256(&mut v13, 0), 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::to_u256(&v7)), 0x2::address::to_bytes(v2)), v4), (v9 as u256)), v12);
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::events::interchain_transfer<T0>(v7, v2, v3, v4, v9, &v12);
        prepare_hub_message(arg0, 0x53106e8a23ea2b83b0f1cc18861d287e08757525e0e47d3712130080af8cf49a::abi::into_bytes(v13), v3)
    }

    public(friend) fun set_flow_limit_as_token_operator<T0>(arg0: &mut InterchainTokenService_v0, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg3: 0x1::option::Option<u64>) {
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::set_flow_limit<T0>(coin_management_mut<T0>(arg0, arg2), arg1, arg3);
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::events::flow_limit_set<T0>(arg2, arg3);
    }

    public(friend) fun set_relayer_discovery_id(arg0: &mut InterchainTokenService_v0, arg1: &0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::RelayerDiscovery) {
        arg0.relayer_discovery_id = 0x2::object::id<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::RelayerDiscovery>(arg1);
    }

    public(friend) fun transfer_distributorship<T0>(arg0: &mut InterchainTokenService_v0, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg3: 0x1::option::Option<address>) {
        let v0 = coin_management_mut<T0>(arg0, arg2);
        assert!(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::is_distributor<T0>(v0, 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::to_address(arg1)), 9223373926641303567);
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::update_distributorship<T0>(v0, arg3);
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::events::distributorship_transfered<T0>(arg2, arg3);
    }

    public(friend) fun transfer_operatorship<T0>(arg0: &mut InterchainTokenService_v0, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg3: 0x1::option::Option<address>) {
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::update_operatorship<T0>(coin_management_mut<T0>(arg0, arg2), arg1, arg3);
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::events::operatorship_transfered<T0>(arg2, arg3);
    }

    public(friend) fun unregistered_coin_type(arg0: &InterchainTokenService_v0, arg1: &0x1::ascii::String, arg2: u8) : &0x1::type_name::TypeName {
        let v0 = 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::unregistered_token_id(arg1, arg2);
        assert!(0x2::table::contains<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::UnregisteredTokenId, 0x1::type_name::TypeName>(&arg0.unregistered_coin_types, v0), 9223372522186080257);
        0x2::table::borrow<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::UnregisteredTokenId, 0x1::type_name::TypeName>(&arg0.unregistered_coin_types, v0)
    }

    // decompiled from Move bytecode v6
}

