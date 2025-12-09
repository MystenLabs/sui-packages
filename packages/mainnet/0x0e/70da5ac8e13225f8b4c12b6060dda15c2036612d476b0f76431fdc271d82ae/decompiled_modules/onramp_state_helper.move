module 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::onramp_state_helper {
    struct ONRAMP_STATE_HELPER has drop {
        dummy_field: bool,
    }

    struct SourceTransferCap has store, key {
        id: 0x2::object::UID,
    }

    struct TokenTransferParams {
        token_transfer: 0x1::option::Option<TokenTransferMetadata>,
        token_receiver: vector<u8>,
    }

    struct TokenTransferMetadata {
        remote_chain_selector: u64,
        token_pool_package_id: address,
        amount: u64,
        source_token_coin_metadata_address: address,
        dest_token_address: vector<u8>,
        extra_data: vector<u8>,
    }

    public fun add_token_transfer_param<T0: drop>(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut TokenTransferParams, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: vector<u8>, arg7: T0) {
        let (v0, _, _, _, _, v5, _, _) = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::token_admin_registry::get_token_config_data(arg0, arg4);
        assert!(v5 == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 1);
        assert!(0x1::option::is_none<TokenTransferMetadata>(&arg1.token_transfer), 2);
        let v8 = TokenTransferMetadata{
            remote_chain_selector              : arg2,
            token_pool_package_id              : v0,
            amount                             : arg3,
            source_token_coin_metadata_address : arg4,
            dest_token_address                 : arg5,
            extra_data                         : arg6,
        };
        0x1::option::fill<TokenTransferMetadata>(&mut arg1.token_transfer, v8);
    }

    public fun create_token_transfer_params(arg0: vector<u8>) : TokenTransferParams {
        TokenTransferParams{
            token_transfer : 0x1::option::none<TokenTransferMetadata>(),
            token_receiver : arg0,
        }
    }

    public fun deconstruct_token_params(arg0: &SourceTransferCap, arg1: TokenTransferParams) {
        let TokenTransferParams {
            token_transfer : v0,
            token_receiver : _,
        } = arg1;
        let v2 = v0;
        if (0x1::option::is_some<TokenTransferMetadata>(&v2)) {
            let TokenTransferMetadata {
                remote_chain_selector              : _,
                token_pool_package_id              : _,
                amount                             : _,
                source_token_coin_metadata_address : _,
                dest_token_address                 : _,
                extra_data                         : _,
            } = 0x1::option::extract<TokenTransferMetadata>(&mut v2);
        };
        0x1::option::destroy_none<TokenTransferMetadata>(v2);
    }

    public fun get_source_token_transfer_data(arg0: &TokenTransferParams) : (u64, address, u64, address, vector<u8>, vector<u8>) {
        assert!(0x1::option::is_some<TokenTransferMetadata>(&arg0.token_transfer), 3);
        let v0 = 0x1::option::borrow<TokenTransferMetadata>(&arg0.token_transfer);
        (v0.remote_chain_selector, v0.token_pool_package_id, v0.amount, v0.source_token_coin_metadata_address, v0.dest_token_address, v0.extra_data)
    }

    public fun get_token_receiver(arg0: &TokenTransferParams) : vector<u8> {
        arg0.token_receiver
    }

    public fun has_token_transfer(arg0: &TokenTransferParams) : bool {
        0x1::option::is_some<TokenTransferMetadata>(&arg0.token_transfer)
    }

    fun init(arg0: ONRAMP_STATE_HELPER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SourceTransferCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SourceTransferCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

