module 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service {
    struct InterchainTokenService has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    public(friend) fun register_transaction(arg0: &mut InterchainTokenService, arg1: &mut 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::RelayerDiscovery, arg2: 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"register_transaction"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::set_relayer_discovery_id(v0, arg1);
        0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::register_transaction(arg1, 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::channel(v0), arg2);
    }

    fun version_control() : 0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = vector[b"deploy_remote_interchain_token", b"send_interchain_transfer", b"receive_interchain_transfer", b"receive_interchain_transfer_with_data", b"receive_deploy_interchain_token", b"give_unregistered_coin", b"mint_as_distributor", b"mint_to_as_distributor", b"burn_as_distributor", b"add_trusted_chains", b"remove_trusted_chains", b"set_flow_limit", b"set_flow_limit_as_token_operator", b"transfer_distributorship", b"transfer_operatorship", b"allow_function", b"disallow_function"];
        0x1::vector::reverse<vector<u8>>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&v1)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::ascii::string(0x1::vector::pop_back<vector<u8>>(&mut v1)));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(v1);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        let v4 = vector[b"register_coin_from_info", b"register_coin_from_metadata", b"register_custom_coin", b"link_coin", b"register_coin_metadata", b"deploy_remote_interchain_token", b"send_interchain_transfer", b"receive_interchain_transfer", b"receive_interchain_transfer_with_data", b"receive_deploy_interchain_token", b"receive_link_coin", b"give_unregistered_coin", b"give_unlinked_coin", b"remove_unlinked_coin", b"mint_as_distributor", b"mint_to_as_distributor", b"burn_as_distributor", b"add_trusted_chains", b"remove_trusted_chains", b"register_transaction", b"set_flow_limit", b"set_flow_limit_as_token_operator", b"transfer_distributorship", b"transfer_operatorship", b"remove_treasury_cap", b"restore_treasury_cap", b"allow_function", b"disallow_function", b"migrate_coin_metadata"];
        0x1::vector::reverse<vector<u8>>(&mut v4);
        let v5 = 0;
        while (v5 < 0x1::vector::length<vector<u8>>(&v4)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x1::ascii::string(0x1::vector::pop_back<vector<u8>>(&mut v4)));
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(v4);
        let v6 = 0x1::vector::empty<vector<0x1::ascii::String>>();
        let v7 = &mut v6;
        0x1::vector::push_back<vector<0x1::ascii::String>>(v7, v0);
        0x1::vector::push_back<vector<0x1::ascii::String>>(v7, v3);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::new(v6)
    }

    public fun add_trusted_chains(arg0: &mut InterchainTokenService, arg1: &0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::owner_cap::OwnerCap, arg2: vector<0x1::ascii::String>) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"add_trusted_chains"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::add_trusted_chains(v0, arg2);
    }

    entry fun allow_function(arg0: &mut InterchainTokenService, arg1: &0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::owner_cap::OwnerCap, arg2: u64, arg3: 0x1::ascii::String) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"allow_function"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::allow_function(v0, arg2, arg3);
    }

    public fun burn_as_distributor<T0>(arg0: &mut InterchainTokenService, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg3: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"mint_to_as_distributor"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::burn_as_distributor<T0>(v0, arg1, arg2, arg3);
    }

    public fun channel_address(arg0: &InterchainTokenService) : address {
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::channel_address(package_value(arg0))
    }

    public fun deploy_remote_interchain_token<T0>(arg0: &InterchainTokenService, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg2: 0x1::ascii::String) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket {
        let v0 = 0x2::versioned::load_value<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"deploy_remote_interchain_token"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::deploy_remote_interchain_token<T0>(v0, arg1, arg2)
    }

    entry fun disallow_function(arg0: &mut InterchainTokenService, arg1: &0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::owner_cap::OwnerCap, arg2: u64, arg3: 0x1::ascii::String) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"disallow_function"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::disallow_function(v0, arg2, arg3);
    }

    public fun give_unlinked_coin<T0>(arg0: &mut InterchainTokenService, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>, arg4: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::treasury_cap_reclaimer::TreasuryCapReclaimer<T0>>, 0x1::option::Option<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel>) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"give_unlinked_coin"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::give_unlinked_coin<T0>(v0, arg1, arg2, arg3, arg4)
    }

    public fun give_unregistered_coin<T0>(arg0: &mut InterchainTokenService, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"give_unregistered_coin"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::give_unregistered_coin<T0>(v0, arg1, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::owner_cap::OwnerCap>(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::owner_cap::create(arg0), 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::operator_cap::OperatorCap>(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::operator_cap::create(arg0), 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::creator_cap::CreatorCap>(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::creator_cap::create(arg0), 0x2::tx_context::sender(arg0));
    }

    public fun link_coin(arg0: &InterchainTokenService, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32, arg3: 0x1::ascii::String, arg4: vector<u8>, arg5: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_manager_type::TokenManagerType, arg6: vector<u8>) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket {
        let v0 = 0x2::versioned::load_value<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"link_coin"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::link_coin(v0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    entry fun migrate(arg0: &mut InterchainTokenService, arg1: &0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::owner_cap::OwnerCap) {
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::migrate(0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner), version_control());
    }

    entry fun migrate_coin_metadata<T0>(arg0: &mut InterchainTokenService, arg1: &0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::operator_cap::OperatorCap, arg2: address) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"migrate_coin_metadata"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::migrate_coin_metadata<T0>(v0, arg2);
    }

    public fun mint_as_distributor<T0>(arg0: &mut InterchainTokenService, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"mint_as_distributor"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::mint_as_distributor<T0>(v0, arg1, arg2, arg3, arg4)
    }

    public fun mint_to_as_distributor<T0>(arg0: &mut InterchainTokenService, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"mint_to_as_distributor"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::mint_to_as_distributor<T0>(v0, arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun package_value(arg0: &InterchainTokenService) : &0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0 {
        0x2::versioned::load_value<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&arg0.inner)
    }

    public fun prepare_interchain_transfer<T0>(arg0: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel) : 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_transfer_ticket::InterchainTransferTicket<T0> {
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_transfer_ticket::new<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::to_address(arg5), arg2, arg3, arg4, 1)
    }

    public fun receive_deploy_interchain_token<T0>(arg0: &mut InterchainTokenService, arg1: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"receive_deploy_interchain_token"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::receive_deploy_interchain_token<T0>(v0, arg1);
    }

    public fun receive_interchain_transfer<T0>(arg0: &mut InterchainTokenService, arg1: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"receive_interchain_transfer"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::receive_interchain_transfer<T0>(v0, arg1, arg2, arg3);
    }

    public fun receive_interchain_transfer_with_data<T0>(arg0: &mut InterchainTokenService, arg1: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage, arg2: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x1::ascii::String, vector<u8>, vector<u8>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"receive_interchain_transfer_with_data"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::receive_interchain_transfer_with_data<T0>(v0, arg1, arg2, arg3, arg4)
    }

    public fun receive_link_coin<T0>(arg0: &mut InterchainTokenService, arg1: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"receive_link_coin"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::receive_link_coin<T0>(v0, arg1);
    }

    public fun register_coin<T0>(arg0: &mut InterchainTokenService, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info::CoinInfo<T0>, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::CoinManagement<T0>) : 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId {
        abort 13906834741279195139
    }

    public fun register_coin_from_info<T0>(arg0: &mut InterchainTokenService, arg1: 0x1::string::String, arg2: 0x1::ascii::String, arg3: u8, arg4: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::CoinManagement<T0>) : 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"register_coin_from_info"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::register_coin_from_info<T0>(v0, arg1, arg2, arg3, arg4)
    }

    public fun register_coin_from_metadata<T0>(arg0: &mut InterchainTokenService, arg1: &0x2::coin::CoinMetadata<T0>, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::CoinManagement<T0>) : 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"register_coin_from_metadata"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::register_coin_from_metadata<T0>(v0, arg1, arg2)
    }

    public fun register_coin_metadata<T0>(arg0: &InterchainTokenService, arg1: &0x2::coin::CoinMetadata<T0>) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket {
        let v0 = 0x2::versioned::load_value<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"register_coin_metadata"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::register_coin_metadata<T0>(v0, arg1)
    }

    public fun register_custom_coin<T0>(arg0: &mut InterchainTokenService, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32, arg3: &0x2::coin::CoinMetadata<T0>, arg4: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::CoinManagement<T0>, arg5: &mut 0x2::tx_context::TxContext) : (0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, 0x1::option::Option<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::treasury_cap_reclaimer::TreasuryCapReclaimer<T0>>) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"register_custom_coin"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::register_custom_coin<T0>(v0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun registered_coin_data<T0>(arg0: &InterchainTokenService, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId) : &0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_data::CoinData<T0> {
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::coin_data<T0>(package_value(arg0), arg1)
    }

    public fun registered_coin_type(arg0: &InterchainTokenService, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId) : &0x1::type_name::TypeName {
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::registered_coin_type(package_value(arg0), arg1)
    }

    public fun remove_treasury_cap<T0>(arg0: &mut InterchainTokenService, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::treasury_cap_reclaimer::TreasuryCapReclaimer<T0>) : 0x2::coin::TreasuryCap<T0> {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"remove_treasury_cap"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::remove_treasury_cap<T0>(v0, arg1)
    }

    public fun remove_trusted_chains(arg0: &mut InterchainTokenService, arg1: &0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::owner_cap::OwnerCap, arg2: vector<0x1::ascii::String>) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"remove_trusted_chains"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::remove_trusted_chains(v0, arg2);
    }

    public fun remove_unlinked_coin<T0>(arg0: &mut InterchainTokenService, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::treasury_cap_reclaimer::TreasuryCapReclaimer<T0>) : 0x2::coin::TreasuryCap<T0> {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"remove_unlinked_coin"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::remove_unlinked_coin<T0>(v0, arg1)
    }

    public fun restore_treasury_cap<T0>(arg0: &mut InterchainTokenService, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg3: &mut 0x2::tx_context::TxContext) : 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::treasury_cap_reclaimer::TreasuryCapReclaimer<T0> {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"restore_treasury_cap"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::restore_treasury_cap<T0>(v0, arg1, arg2, arg3)
    }

    public fun send_interchain_transfer<T0>(arg0: &mut InterchainTokenService, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_transfer_ticket::InterchainTransferTicket<T0>, arg2: &0x2::clock::Clock) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"send_interchain_transfer"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::send_interchain_transfer<T0>(v0, arg1, 1, arg2)
    }

    public fun set_flow_limit<T0>(arg0: &mut InterchainTokenService, arg1: &0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::operator_cap::OperatorCap, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg3: 0x1::option::Option<u64>) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"set_flow_limit"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::set_flow_limit<T0>(v0, arg2, arg3);
    }

    public fun set_flow_limit_as_token_operator<T0>(arg0: &mut InterchainTokenService, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg3: 0x1::option::Option<u64>) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"set_flow_limit_as_token_operator"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::set_flow_limit_as_token_operator<T0>(v0, arg1, arg2, arg3);
    }

    entry fun setup(arg0: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::creator_cap::CreatorCap, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = InterchainTokenService{
            id    : 0x2::object::new(arg3),
            inner : 0x2::versioned::create<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(0, 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::new(version_control(), arg1, arg2, arg3), arg3),
        };
        0x2::transfer::share_object<InterchainTokenService>(v0);
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::creator_cap::destroy(arg0);
    }

    public fun transfer_distributorship<T0>(arg0: &mut InterchainTokenService, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg3: 0x1::option::Option<address>) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"transfer_distributorship"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::transfer_distributorship<T0>(v0, arg1, arg2, arg3);
    }

    public fun transfer_operatorship<T0>(arg0: &mut InterchainTokenService, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg3: 0x1::option::Option<address>) {
        let v0 = 0x2::versioned::load_value_mut<0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::InterchainTokenService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::version_control(v0), 1, 0x1::ascii::string(b"transfer_operatorship"));
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::interchain_token_service_v0::transfer_operatorship<T0>(v0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

