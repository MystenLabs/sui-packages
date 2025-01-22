module 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0 {
    struct ITS_v0 has store {
        channel: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel,
        address_tracker: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::address_tracker::InterchainAddressTracker,
        unregistered_coin_types: 0x2::table::Table<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::UnregisteredTokenId, 0x1::type_name::TypeName>,
        unregistered_coins: 0x2::bag::Bag,
        registered_coin_types: 0x2::table::Table<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, 0x1::type_name::TypeName>,
        registered_coins: 0x2::bag::Bag,
        relayer_discovery_id: 0x2::object::ID,
        version_control: 0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl,
    }

    public(friend) fun new(arg0: 0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl, arg1: &mut 0x2::tx_context::TxContext) : ITS_v0 {
        ITS_v0{
            channel                 : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::new(arg1),
            address_tracker         : 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::address_tracker::new(arg1),
            unregistered_coin_types : 0x2::table::new<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::UnregisteredTokenId, 0x1::type_name::TypeName>(arg1),
            unregistered_coins      : 0x2::bag::new(arg1),
            registered_coin_types   : 0x2::table::new<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, 0x1::type_name::TypeName>(arg1),
            registered_coins        : 0x2::bag::new(arg1),
            relayer_discovery_id    : 0x2::object::id_from_address(@0x0),
            version_control         : arg0,
        }
    }

    public(friend) fun version_control(arg0: &ITS_v0) : &0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl {
        &arg0.version_control
    }

    public(friend) fun allow_function(arg0: &mut ITS_v0, arg1: u64, arg2: 0x1::ascii::String) {
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::allow_function(&mut arg0.version_control, arg1, arg2);
    }

    public(friend) fun disallow_function(arg0: &mut ITS_v0, arg1: u64, arg2: 0x1::ascii::String) {
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::disallow_function(&mut arg0.version_control, arg1, arg2);
    }

    fun is_trusted_address(arg0: &ITS_v0, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) : bool {
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::address_tracker::is_trusted_address(&arg0.address_tracker, arg1, arg2)
    }

    public(friend) fun remove_trusted_address(arg0: &mut ITS_v0, arg1: 0x1::ascii::String) {
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::address_tracker::remove_trusted_address(&mut arg0.address_tracker, arg1);
    }

    public(friend) fun set_trusted_address(arg0: &mut ITS_v0, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) {
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::address_tracker::set_trusted_address(&mut arg0.address_tracker, arg1, arg2);
    }

    fun trusted_address(arg0: &ITS_v0, arg1: 0x1::ascii::String) : 0x1::ascii::String {
        *0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::address_tracker::trusted_address(&arg0.address_tracker, arg1)
    }

    fun coin_data<T0>(arg0: &ITS_v0, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId) : &0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_data::CoinData<T0> {
        assert!(0x2::bag::contains<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId>(&arg0.registered_coins, arg1), 9223374231583064065);
        0x2::bag::borrow<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_data::CoinData<T0>>(&arg0.registered_coins, arg1)
    }

    fun coin_info<T0>(arg0: &ITS_v0, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId) : &0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_info::CoinInfo<T0> {
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_data::coin_info<T0>(coin_data<T0>(arg0, arg1))
    }

    fun coin_management_mut<T0>(arg0: &mut ITS_v0, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId) : &mut 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::CoinManagement<T0> {
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_data::coin_management_mut<T0>(0x2::bag::borrow_mut<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_data::CoinData<T0>>(&mut arg0.registered_coins, arg1))
    }

    public(friend) fun set_flow_limit<T0>(arg0: &mut ITS_v0, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg3: u64) {
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::set_flow_limit<T0>(coin_management_mut<T0>(arg0, arg2), arg1, arg3);
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::events::flow_limit_set<T0>(arg2, arg3);
    }

    fun add_registered_coin<T0>(arg0: &mut ITS_v0, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg2: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::CoinManagement<T0>, arg3: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_info::CoinInfo<T0>) {
        0x2::bag::add<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_data::CoinData<T0>>(&mut arg0.registered_coins, arg1, 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_data::new<T0>(arg2, arg3));
        add_registered_coin_type(arg0, arg1, 0x1::type_name::get<T0>());
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::events::coin_registered<T0>(arg1);
    }

    fun add_registered_coin_type(arg0: &mut ITS_v0, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg2: 0x1::type_name::TypeName) {
        0x2::table::add<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, 0x1::type_name::TypeName>(&mut arg0.registered_coin_types, arg1, arg2);
    }

    fun add_unregistered_coin<T0>(arg0: &mut ITS_v0, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::UnregisteredTokenId, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::CoinMetadata<T0>) {
        0x2::bag::add<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::UnregisteredTokenId, 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::unregistered_coin_data::UnregisteredCoinData<T0>>(&mut arg0.unregistered_coins, arg1, 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::unregistered_coin_data::new<T0>(arg2, arg3));
        add_unregistered_coin_type(arg0, arg1, 0x1::type_name::get<T0>());
    }

    fun add_unregistered_coin_type(arg0: &mut ITS_v0, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::UnregisteredTokenId, arg2: 0x1::type_name::TypeName) {
        0x2::table::add<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::UnregisteredTokenId, 0x1::type_name::TypeName>(&mut arg0.unregistered_coin_types, arg1, arg2);
    }

    public(friend) fun burn_as_distributor<T0>(arg0: &mut ITS_v0, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg3: 0x2::coin::Coin<T0>) {
        let v0 = coin_management_mut<T0>(arg0, arg2);
        assert!(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::is_distributor<T0>(v0, 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::to_address(arg1)), 9223374081260126223);
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::burn<T0>(v0, 0x2::coin::into_balance<T0>(arg3));
    }

    public(friend) fun channel(arg0: &ITS_v0) : &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel {
        &arg0.channel
    }

    public(friend) fun channel_address(arg0: &ITS_v0) : address {
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::to_address(&arg0.channel)
    }

    fun decode_approved_message(arg0: &ITS_v0, arg1: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage) : (0x1::ascii::String, vector<u8>, 0x1::ascii::String) {
        let (v0, v1, v2, v3) = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::consume_approved_message(&arg0.channel, arg1);
        let v4 = v3;
        let v5 = v0;
        assert!(is_trusted_address(arg0, v0, v2), 9223374901598093315);
        let v6 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::new_reader(v3);
        if (0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_u256(&mut v6) == 4) {
            assert!(0x1::ascii::into_bytes(v0) == b"axelar", 9223374931664044053);
            let v7 = 0x1::ascii::string(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_bytes(&mut v6));
            v5 = v7;
            v4 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_bytes(&mut v6);
            assert!(0x1::ascii::into_bytes(trusted_address(arg0, v7)) == b"hub", 9223374966023782421);
        } else {
            assert!(0x1::ascii::into_bytes(v0) != b"axelar", 9223374987498618901);
        };
        (v5, v4, v1)
    }

    public(friend) fun deploy_remote_interchain_token<T0>(arg0: &ITS_v0, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg2: 0x1::ascii::String) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket {
        let v0 = coin_info<T0>(arg0, arg1);
        let v1 = 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_info::name<T0>(v0);
        let v2 = 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_info::symbol<T0>(v0);
        let v3 = 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_info::decimals<T0>(v0);
        let v4 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::new_writer(6);
        0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::write_bytes(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::write_u256(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::write_bytes(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::write_bytes(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::write_u256(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::write_u256(&mut v4, 1), 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::to_u256(&arg1)), *0x1::string::as_bytes(&v1)), *0x1::ascii::as_bytes(&v2)), (v3 as u256)), 0x1::vector::empty<u8>());
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::events::interchain_token_deployment_started<T0>(arg1, v1, v2, v3, arg2);
        prepare_message(arg0, arg2, 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::into_bytes(v4))
    }

    public(friend) fun give_unregistered_coin<T0>(arg0: &mut ITS_v0, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>) {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 9223373780612546577);
        let v0 = 0x2::coin::get_icon_url<T0>(&arg2);
        assert!(0x1::option::is_none<0x2::url::Url>(&v0), 9223373793497579539);
        0x2::coin::update_description<T0>(&arg1, &mut arg2, 0x1::string::utf8(b""));
        let v1 = 0x2::coin::get_decimals<T0>(&arg2);
        let v2 = 0x2::coin::get_symbol<T0>(&arg2);
        let v3 = 0x1::type_name::get<T0>();
        let v4 = 0x1::type_name::get_module(&v3);
        let v5 = 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::utils::module_from_symbol(&v2);
        assert!(&v4 == &v5, 9223373840741826573);
        let v6 = 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::unregistered_token_id(&v2, v1);
        add_unregistered_coin<T0>(arg0, v6, arg1, arg2);
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::events::unregistered_coin_received<T0>(v6, v2, v1);
    }

    public(friend) fun mint_as_distributor<T0>(arg0: &mut ITS_v0, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = coin_management_mut<T0>(arg0, arg2);
        assert!(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::is_distributor<T0>(v0, 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::to_address(arg1)), 9223373943821172751);
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::mint<T0>(v0, arg3, arg4)
    }

    public(friend) fun mint_to_as_distributor<T0>(arg0: &mut ITS_v0, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = coin_management_mut<T0>(arg0, arg2);
        assert!(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::is_distributor<T0>(v0, 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::to_address(arg1)), 9223374012540649487);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::mint<T0>(v0, arg4, arg5), arg3);
    }

    fun prepare_message(arg0: &ITS_v0, arg1: 0x1::ascii::String, arg2: vector<u8>) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket {
        let v0 = trusted_address(arg0, arg1);
        let v1 = v0;
        assert!(0x1::ascii::into_bytes(arg1) != b"axelar", 9223374755570384917);
        if (0x1::ascii::into_bytes(v0) == b"hub") {
            let v2 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::new_writer(3);
            0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::write_u256(&mut v2, 3);
            0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::write_bytes(&mut v2, 0x1::ascii::into_bytes(arg1));
            0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::write_bytes(&mut v2, arg2);
            arg2 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::into_bytes(v2);
            let v3 = 0x1::ascii::string(b"axelar");
            arg1 = v3;
            v1 = trusted_address(arg0, v3);
        };
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway::prepare_message(&arg0.channel, arg1, v1, arg2)
    }

    fun read_amount(arg0: &mut 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::AbiReader) : u64 {
        let v0 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_u256(arg0);
        let v1 = if (v0 > 18446744073709551615) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>((v0 as u64))
        };
        let v2 = v1;
        assert!(0x1::option::is_some<u64>(&v2), 9223375026153586713);
        0x1::option::destroy_some<u64>(v2)
    }

    public(friend) fun receive_deploy_interchain_token<T0>(arg0: &mut ITS_v0, arg1: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage) {
        let (_, v1, _) = decode_approved_message(arg0, arg1);
        let v3 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::new_reader(v1);
        assert!(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_u256(&mut v3) == 1, 9223373651762741253);
        let v4 = 0x1::ascii::string(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_bytes(&mut v3));
        let v5 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_bytes(&mut v3);
        let (v6, v7) = remove_unregistered_coin<T0>(arg0, 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::unregistered_token_id(&v4, (0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_u256(&mut v3) as u8)));
        let v8 = v7;
        let v9 = v6;
        0x2::coin::update_name<T0>(&v9, &mut v8, 0x1::string::utf8(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_bytes(&mut v3)));
        let v10 = 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::new_with_cap<T0>(v9);
        if (0x1::vector::length<u8>(&v5) > 0) {
            0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::add_distributor<T0>(&mut v10, 0x2::address::from_bytes(v5));
        };
        add_registered_coin<T0>(arg0, 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::from_u256(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_u256(&mut v3)), v10, 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_info::from_metadata<T0>(v8));
    }

    public(friend) fun receive_interchain_transfer<T0>(arg0: &mut ITS_v0, arg1: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = decode_approved_message(arg0, arg1);
        let v3 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::new_reader(v1);
        assert!(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_u256(&mut v3) == 0, 9223373321050259461);
        let v4 = 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::from_u256(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_u256(&mut v3));
        let v5 = 0x2::address::from_bytes(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_bytes(&mut v3));
        let v6 = &mut v3;
        let v7 = read_amount(v6);
        let v8 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_bytes(&mut v3);
        assert!(0x1::vector::is_empty<u8>(&v8), 9223373359705227273);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::give_coin<T0>(coin_management_mut<T0>(arg0, v4), v7, arg2, arg3), v5);
        let v9 = b"";
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::events::interchain_transfer_received<T0>(v2, v4, v0, 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_bytes(&mut v3), v5, v7, &v9);
    }

    public(friend) fun receive_interchain_transfer_with_data<T0>(arg0: &mut ITS_v0, arg1: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage, arg2: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x1::ascii::String, vector<u8>, vector<u8>, 0x2::coin::Coin<T0>) {
        let (v0, v1, v2) = decode_approved_message(arg0, arg1);
        let v3 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::new_reader(v1);
        assert!(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_u256(&mut v3) == 0, 9223373497143918597);
        let v4 = 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::from_u256(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_u256(&mut v3));
        let v5 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_bytes(&mut v3);
        let v6 = 0x2::address::from_bytes(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_bytes(&mut v3));
        let v7 = &mut v3;
        let v8 = read_amount(v7);
        let v9 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_bytes(&mut v3);
        assert!(v6 == 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::to_address(arg2), 9223373540093722631);
        assert!(!0x1::vector::is_empty<u8>(&v9), 9223373544388952075);
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::events::interchain_transfer_received<T0>(v2, v4, v0, v5, v6, v8, &v9);
        (v0, v5, v9, 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::give_coin<T0>(coin_management_mut<T0>(arg0, v4), v8, arg3, arg4))
    }

    public(friend) fun register_coin<T0>(arg0: &mut ITS_v0, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_info::CoinInfo<T0>, arg2: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::CoinManagement<T0>) : 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId {
        let v0 = 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::from_coin_data<T0>(&arg1, &arg2);
        add_registered_coin<T0>(arg0, v0, arg2, arg1);
        v0
    }

    public(friend) fun registered_coin_type(arg0: &ITS_v0, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId) : &0x1::type_name::TypeName {
        assert!(0x2::table::contains<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, 0x1::type_name::TypeName>(&arg0.registered_coin_types, arg1), 9223372603790458881);
        0x2::table::borrow<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, 0x1::type_name::TypeName>(&arg0.registered_coin_types, arg1)
    }

    public(friend) fun relayer_discovery_id(arg0: &ITS_v0) : 0x2::object::ID {
        arg0.relayer_discovery_id
    }

    public(friend) fun remove_trusted_addresses(arg0: &mut ITS_v0, arg1: vector<0x1::ascii::String>) {
        0x1::vector::reverse<0x1::ascii::String>(&mut arg1);
        while (0x1::vector::length<0x1::ascii::String>(&arg1) != 0) {
            remove_trusted_address(arg0, 0x1::vector::pop_back<0x1::ascii::String>(&mut arg1));
        };
        0x1::vector::destroy_empty<0x1::ascii::String>(arg1);
    }

    fun remove_unregistered_coin<T0>(arg0: &mut ITS_v0, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::UnregisteredTokenId) : (0x2::coin::TreasuryCap<T0>, 0x2::coin::CoinMetadata<T0>) {
        let (v0, v1) = 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::unregistered_coin_data::destroy<T0>(0x2::bag::remove<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::UnregisteredTokenId, 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::unregistered_coin_data::UnregisteredCoinData<T0>>(&mut arg0.unregistered_coins, arg1));
        remove_unregistered_coin_type(arg0, arg1);
        (v0, v1)
    }

    fun remove_unregistered_coin_type(arg0: &mut ITS_v0, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::UnregisteredTokenId) : 0x1::type_name::TypeName {
        0x2::table::remove<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::UnregisteredTokenId, 0x1::type_name::TypeName>(&mut arg0.unregistered_coin_types, arg1)
    }

    public(friend) fun send_interchain_transfer<T0>(arg0: &mut ITS_v0, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::interchain_transfer_ticket::InterchainTransferTicket<T0>, arg2: u64, arg3: &0x2::clock::Clock) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket {
        let (v0, v1, v2, v3, v4, v5, v6) = 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::interchain_transfer_ticket::destroy<T0>(arg1);
        let v7 = v0;
        assert!(v6 <= arg2, 9223373149252747287);
        let v8 = coin_management_mut<T0>(arg0, v7);
        let v9 = 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::take_balance<T0>(v8, v1, arg3);
        let (_, v11) = 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::utils::decode_metadata(v5);
        let v12 = v11;
        let v13 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::new_writer(6);
        0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::write_bytes(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::write_u256(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::write_bytes(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::write_bytes(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::write_u256(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::write_u256(&mut v13, 0), 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::to_u256(&v7)), 0x2::address::to_bytes(v2)), v4), (v9 as u256)), v12);
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::events::interchain_transfer<T0>(v7, v2, v3, v4, v9, &v12);
        prepare_message(arg0, v3, 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::into_bytes(v13))
    }

    public(friend) fun set_relayer_discovery_id(arg0: &mut ITS_v0, arg1: &0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::RelayerDiscovery) {
        arg0.relayer_discovery_id = 0x2::object::id<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::RelayerDiscovery>(arg1);
    }

    public(friend) fun set_trusted_addresses(arg0: &mut ITS_v0, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::trusted_addresses::TrustedAddresses) {
        let (v0, v1) = 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::trusted_addresses::destroy(arg1);
        let v2 = v0;
        let v3 = v1;
        0x1::vector::reverse<0x1::ascii::String>(&mut v3);
        assert!(0x1::vector::length<0x1::ascii::String>(&v2) == 0x1::vector::length<0x1::ascii::String>(&v3), 9223372779884118015);
        0x1::vector::reverse<0x1::ascii::String>(&mut v2);
        while (0x1::vector::length<0x1::ascii::String>(&v2) != 0) {
            set_trusted_address(arg0, 0x1::vector::pop_back<0x1::ascii::String>(&mut v2), 0x1::vector::pop_back<0x1::ascii::String>(&mut v3));
        };
        0x1::vector::destroy_empty<0x1::ascii::String>(v2);
    }

    public(friend) fun unregistered_coin_type(arg0: &ITS_v0, arg1: &0x1::ascii::String, arg2: u8) : &0x1::type_name::TypeName {
        let v0 = 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::unregistered_token_id(arg1, arg2);
        assert!(0x2::table::contains<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::UnregisteredTokenId, 0x1::type_name::TypeName>(&arg0.unregistered_coin_types, v0), 9223372569430720513);
        0x2::table::borrow<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::UnregisteredTokenId, 0x1::type_name::TypeName>(&arg0.unregistered_coin_types, v0)
    }

    // decompiled from Move bytecode v6
}

