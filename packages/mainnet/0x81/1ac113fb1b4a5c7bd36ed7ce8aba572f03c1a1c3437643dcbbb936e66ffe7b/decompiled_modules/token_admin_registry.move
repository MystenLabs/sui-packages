module 0x811ac113fb1b4a5c7bd36ed7ce8aba572f03c1a1c3437643dcbbb936e66ffe7b::token_admin_registry {
    struct PoolSet has copy, drop {
        coin_metadata_address: address,
        previous_pool_package_id: address,
        new_pool_package_id: address,
        token_pool_type_proof: 0x1::ascii::String,
        lock_or_burn_params: vector<address>,
        release_or_mint_params: vector<address>,
    }

    struct PoolRegistered has copy, drop {
        coin_metadata_address: address,
        token_pool_package_id: address,
        administrator: address,
        token_pool_type_proof: 0x1::ascii::String,
    }

    struct PoolUnregistered has copy, drop {
        coin_metadata_address: address,
        previous_pool_address: address,
    }

    struct AdministratorTransferRequested has copy, drop {
        coin_metadata_address: address,
        current_admin: address,
        new_admin: address,
    }

    struct AdministratorTransferred has copy, drop {
        coin_metadata_address: address,
        new_admin: address,
    }

    struct TokenConfig has copy, drop, store {
        token_pool_package_id: address,
        token_pool_module: 0x1::string::String,
        token_type: 0x1::ascii::String,
        administrator: address,
        pending_administrator: address,
        token_pool_type_proof: 0x1::ascii::String,
        lock_or_burn_params: vector<address>,
        release_or_mint_params: vector<address>,
    }

    public fun create_default_test_token_config() : TokenConfig {
        create_test_token_config(@0x0, 0x1::string::utf8(b"TestModule"), 0x1::ascii::string(b"TestType"), @0x0, @0x0, 0x1::ascii::string(b"TestProof"), vector[], vector[])
    }

    public fun create_test_ascii_string(arg0: vector<u8>) : 0x1::ascii::String {
        0x1::ascii::string(arg0)
    }

    public fun create_test_lock_or_burn_params() : vector<address> {
        vector[@0x1, @0x2, @0x3]
    }

    public fun create_test_release_or_mint_params() : vector<address> {
        vector[@0x4, @0x5, @0x6]
    }

    public fun create_test_string(arg0: vector<u8>) : 0x1::string::String {
        0x1::string::utf8(arg0)
    }

    public fun create_test_token_config(arg0: address, arg1: 0x1::string::String, arg2: 0x1::ascii::String, arg3: address, arg4: address, arg5: 0x1::ascii::String, arg6: vector<address>, arg7: vector<address>) : TokenConfig {
        TokenConfig{
            token_pool_package_id  : arg0,
            token_pool_module      : arg1,
            token_type             : arg2,
            administrator          : arg3,
            pending_administrator  : arg4,
            token_pool_type_proof  : arg5,
            lock_or_burn_params    : arg6,
            release_or_mint_params : arg7,
        }
    }

    public fun create_test_token_config_with_pool(arg0: address, arg1: address) : TokenConfig {
        create_test_token_config(arg0, 0x1::string::utf8(b"TestModule"), 0x1::ascii::string(b"TestType"), arg1, @0x0, 0x1::ascii::string(b"TestProof"), vector[@0x1, @0x2], vector[@0x3, @0x4])
    }

    public fun emit_administrator_transfer_requested_event(arg0: address, arg1: address, arg2: address) {
        let v0 = AdministratorTransferRequested{
            coin_metadata_address : arg0,
            current_admin         : arg1,
            new_admin             : arg2,
        };
        0x2::event::emit<AdministratorTransferRequested>(v0);
    }

    public fun emit_administrator_transferred_event(arg0: address, arg1: address) {
        let v0 = AdministratorTransferred{
            coin_metadata_address : arg0,
            new_admin             : arg1,
        };
        0x2::event::emit<AdministratorTransferred>(v0);
    }

    public fun emit_pool_registered_event(arg0: address, arg1: address, arg2: address, arg3: 0x1::ascii::String) {
        let v0 = PoolRegistered{
            coin_metadata_address : arg0,
            token_pool_package_id : arg1,
            administrator         : arg2,
            token_pool_type_proof : arg3,
        };
        0x2::event::emit<PoolRegistered>(v0);
    }

    public fun emit_pool_set_event(arg0: address, arg1: address, arg2: address, arg3: 0x1::ascii::String, arg4: vector<address>, arg5: vector<address>) {
        let v0 = PoolSet{
            coin_metadata_address    : arg0,
            previous_pool_package_id : arg1,
            new_pool_package_id      : arg2,
            token_pool_type_proof    : arg3,
            lock_or_burn_params      : arg4,
            release_or_mint_params   : arg5,
        };
        0x2::event::emit<PoolSet>(v0);
    }

    public fun emit_pool_unregistered_event(arg0: address, arg1: address) {
        let v0 = PoolUnregistered{
            coin_metadata_address : arg0,
            previous_pool_address : arg1,
        };
        0x2::event::emit<PoolUnregistered>(v0);
    }

    // decompiled from Move bytecode v6
}

