module 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::events {
    struct CoinRegistered<phantom T0> has copy, drop {
        token_id: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId,
    }

    struct InterchainTransfer<phantom T0> has copy, drop {
        token_id: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId,
        source_address: address,
        destination_chain: 0x1::ascii::String,
        destination_address: vector<u8>,
        amount: u64,
        data_hash: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32,
    }

    struct InterchainTokenDeploymentStarted<phantom T0> has copy, drop {
        token_id: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        decimals: u8,
        destination_chain: 0x1::ascii::String,
    }

    struct InterchainTransferReceived<phantom T0> has copy, drop {
        message_id: 0x1::ascii::String,
        token_id: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId,
        source_chain: 0x1::ascii::String,
        source_address: vector<u8>,
        destination_address: address,
        amount: u64,
        data_hash: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32,
    }

    struct UnregisteredCoinReceived<phantom T0> has copy, drop {
        token_id: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::UnregisteredTokenId,
        symbol: 0x1::ascii::String,
        decimals: u8,
    }

    struct TrustedAddressSet has copy, drop {
        chain_name: 0x1::ascii::String,
        trusted_address: 0x1::ascii::String,
    }

    struct TrustedAddressRemoved has copy, drop {
        chain_name: 0x1::ascii::String,
    }

    struct FlowLimitSet<phantom T0> has copy, drop {
        token_id: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId,
        flow_limit: u64,
    }

    public(friend) fun coin_registered<T0>(arg0: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId) {
        let v0 = CoinRegistered<T0>{token_id: arg0};
        0x2::event::emit<CoinRegistered<T0>>(v0);
    }

    public(friend) fun flow_limit_set<T0>(arg0: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg1: u64) {
        let v0 = FlowLimitSet<T0>{
            token_id   : arg0,
            flow_limit : arg1,
        };
        0x2::event::emit<FlowLimitSet<T0>>(v0);
    }

    public(friend) fun interchain_token_deployment_started<T0>(arg0: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg1: 0x1::string::String, arg2: 0x1::ascii::String, arg3: u8, arg4: 0x1::ascii::String) {
        let v0 = InterchainTokenDeploymentStarted<T0>{
            token_id          : arg0,
            name              : arg1,
            symbol            : arg2,
            decimals          : arg3,
            destination_chain : arg4,
        };
        0x2::event::emit<InterchainTokenDeploymentStarted<T0>>(v0);
    }

    public(friend) fun interchain_transfer<T0>(arg0: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg1: address, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: u64, arg5: &vector<u8>) {
        let v0 = if (0x1::vector::length<u8>(arg5) == 0) {
            0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::new(@0x0)
        } else {
            0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::new(0x2::address::from_bytes(0x2::hash::keccak256(arg5)))
        };
        let v1 = InterchainTransfer<T0>{
            token_id            : arg0,
            source_address      : arg1,
            destination_chain   : arg2,
            destination_address : arg3,
            amount              : arg4,
            data_hash           : v0,
        };
        0x2::event::emit<InterchainTransfer<T0>>(v1);
    }

    public(friend) fun interchain_transfer_received<T0>(arg0: 0x1::ascii::String, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: address, arg5: u64, arg6: &vector<u8>) {
        let v0 = InterchainTransferReceived<T0>{
            message_id          : arg0,
            token_id            : arg1,
            source_chain        : arg2,
            source_address      : arg3,
            destination_address : arg4,
            amount              : arg5,
            data_hash           : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::new(0x2::address::from_bytes(0x2::hash::keccak256(arg6))),
        };
        0x2::event::emit<InterchainTransferReceived<T0>>(v0);
    }

    public(friend) fun trusted_address_removed(arg0: 0x1::ascii::String) {
        let v0 = TrustedAddressRemoved{chain_name: arg0};
        0x2::event::emit<TrustedAddressRemoved>(v0);
    }

    public(friend) fun trusted_address_set(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String) {
        let v0 = TrustedAddressSet{
            chain_name      : arg0,
            trusted_address : arg1,
        };
        0x2::event::emit<TrustedAddressSet>(v0);
    }

    public(friend) fun unregistered_coin_received<T0>(arg0: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::UnregisteredTokenId, arg1: 0x1::ascii::String, arg2: u8) {
        let v0 = UnregisteredCoinReceived<T0>{
            token_id : arg0,
            symbol   : arg1,
            decimals : arg2,
        };
        0x2::event::emit<UnregisteredCoinReceived<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

