module 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its {
    struct ITS has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    public(friend) fun register_transaction(arg0: &mut ITS, arg1: &mut 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::RelayerDiscovery, arg2: 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction) {
        let v0 = 0x2::versioned::load_value_mut<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::version_control(v0), 0, 0x1::ascii::string(b"register_transaction"));
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::set_relayer_discovery_id(v0, arg1);
        0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::register_transaction(arg1, 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::channel(v0), arg2);
    }

    fun version_control() : 0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = vector[b"register_coin", b"deploy_remote_interchain_token", b"send_interchain_transfer", b"receive_interchain_transfer", b"receive_interchain_transfer_with_data", b"receive_deploy_interchain_token", b"give_unregistered_coin", b"mint_as_distributor", b"mint_to_as_distributor", b"burn_as_distributor", b"set_trusted_addresses", b"remove_trusted_addresses", b"register_transaction", b"set_flow_limit", b"allow_function", b"disallow_function"];
        0x1::vector::reverse<vector<u8>>(&mut v1);
        while (0x1::vector::length<vector<u8>>(&v1) != 0) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::ascii::string(0x1::vector::pop_back<vector<u8>>(&mut v1)));
        };
        0x1::vector::destroy_empty<vector<u8>>(v1);
        let v2 = 0x1::vector::empty<vector<0x1::ascii::String>>();
        0x1::vector::push_back<vector<0x1::ascii::String>>(&mut v2, v0);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::new(v2)
    }

    entry fun allow_function(arg0: &mut ITS, arg1: &0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::owner_cap::OwnerCap, arg2: u64, arg3: 0x1::ascii::String) {
        let v0 = 0x2::versioned::load_value_mut<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::version_control(v0), 0, 0x1::ascii::string(b"allow_function"));
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::allow_function(v0, arg2, arg3);
    }

    public fun burn_as_distributor<T0>(arg0: &mut ITS, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg3: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::versioned::load_value_mut<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::version_control(v0), 0, 0x1::ascii::string(b"mint_to_as_distributor"));
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::burn_as_distributor<T0>(v0, arg1, arg2, arg3);
    }

    public fun channel_address(arg0: &ITS) : address {
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::channel_address(package_value(arg0))
    }

    public fun deploy_remote_interchain_token<T0>(arg0: &ITS, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg2: 0x1::ascii::String) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket {
        let v0 = 0x2::versioned::load_value<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0>(&arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::version_control(v0), 0, 0x1::ascii::string(b"deploy_remote_interchain_token"));
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::deploy_remote_interchain_token<T0>(v0, arg1, arg2)
    }

    entry fun disallow_function(arg0: &mut ITS, arg1: &0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::owner_cap::OwnerCap, arg2: u64, arg3: 0x1::ascii::String) {
        let v0 = 0x2::versioned::load_value_mut<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::version_control(v0), 0, 0x1::ascii::string(b"disallow_function"));
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::disallow_function(v0, arg2, arg3);
    }

    public fun give_unregistered_coin<T0>(arg0: &mut ITS, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>) {
        let v0 = 0x2::versioned::load_value_mut<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::version_control(v0), 0, 0x1::ascii::string(b"give_unregistered_coin"));
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::give_unregistered_coin<T0>(v0, arg1, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ITS{
            id    : 0x2::object::new(arg0),
            inner : 0x2::versioned::create<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0>(0, 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::new(version_control(), arg0), arg0),
        };
        0x2::transfer::share_object<ITS>(v0);
        0x2::transfer::public_transfer<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::owner_cap::OwnerCap>(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::owner_cap::create(arg0), 0x2::tx_context::sender(arg0));
    }

    public fun mint_as_distributor<T0>(arg0: &mut ITS, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::versioned::load_value_mut<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::version_control(v0), 0, 0x1::ascii::string(b"mint_as_distributor"));
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::mint_as_distributor<T0>(v0, arg1, arg2, arg3, arg4)
    }

    public fun mint_to_as_distributor<T0>(arg0: &mut ITS, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::versioned::load_value_mut<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::version_control(v0), 0, 0x1::ascii::string(b"mint_to_as_distributor"));
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::mint_to_as_distributor<T0>(v0, arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun package_value(arg0: &ITS) : &0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0 {
        0x2::versioned::load_value<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0>(&arg0.inner)
    }

    public fun prepare_interchain_transfer<T0>(arg0: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel) : 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::interchain_transfer_ticket::InterchainTransferTicket<T0> {
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::interchain_transfer_ticket::new<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::to_address(arg5), arg2, arg3, arg4, 0)
    }

    public fun receive_deploy_interchain_token<T0>(arg0: &mut ITS, arg1: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage) {
        let v0 = 0x2::versioned::load_value_mut<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::version_control(v0), 0, 0x1::ascii::string(b"receive_deploy_interchain_token"));
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::receive_deploy_interchain_token<T0>(v0, arg1);
    }

    public fun receive_interchain_transfer<T0>(arg0: &mut ITS, arg1: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::versioned::load_value_mut<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::version_control(v0), 0, 0x1::ascii::string(b"receive_interchain_transfer"));
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::receive_interchain_transfer<T0>(v0, arg1, arg2, arg3);
    }

    public fun receive_interchain_transfer_with_data<T0>(arg0: &mut ITS, arg1: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage, arg2: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x1::ascii::String, vector<u8>, vector<u8>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::versioned::load_value_mut<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::version_control(v0), 0, 0x1::ascii::string(b"receive_interchain_transfer_with_data"));
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::receive_interchain_transfer_with_data<T0>(v0, arg1, arg2, arg3, arg4)
    }

    public fun register_coin<T0>(arg0: &mut ITS, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_info::CoinInfo<T0>, arg2: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::CoinManagement<T0>) : 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId {
        let v0 = 0x2::versioned::load_value_mut<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::version_control(v0), 0, 0x1::ascii::string(b"register_coin"));
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::register_coin<T0>(v0, arg1, arg2)
    }

    public fun registered_coin_type(arg0: &ITS, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId) : &0x1::type_name::TypeName {
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::registered_coin_type(package_value(arg0), arg1)
    }

    public fun remove_trusted_addresses(arg0: &mut ITS, arg1: &0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::owner_cap::OwnerCap, arg2: vector<0x1::ascii::String>) {
        let v0 = 0x2::versioned::load_value_mut<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::version_control(v0), 0, 0x1::ascii::string(b"remove_trusted_addresses"));
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::remove_trusted_addresses(v0, arg2);
    }

    public fun send_interchain_transfer<T0>(arg0: &mut ITS, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::interchain_transfer_ticket::InterchainTransferTicket<T0>, arg2: &0x2::clock::Clock) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket {
        let v0 = 0x2::versioned::load_value_mut<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::version_control(v0), 0, 0x1::ascii::string(b"send_interchain_transfer"));
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::send_interchain_transfer<T0>(v0, arg1, 0, arg2)
    }

    public fun set_flow_limit<T0>(arg0: &mut ITS, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg3: u64) {
        let v0 = 0x2::versioned::load_value_mut<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::version_control(v0), 0, 0x1::ascii::string(b"set_flow_limit"));
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::set_flow_limit<T0>(v0, arg1, arg2, arg3);
    }

    public fun set_trusted_addresses(arg0: &mut ITS, arg1: &0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::owner_cap::OwnerCap, arg2: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::trusted_addresses::TrustedAddresses) {
        let v0 = 0x2::versioned::load_value_mut<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::ITS_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::version_control(v0), 0, 0x1::ascii::string(b"set_trusted_addresses"));
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::set_trusted_addresses(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

