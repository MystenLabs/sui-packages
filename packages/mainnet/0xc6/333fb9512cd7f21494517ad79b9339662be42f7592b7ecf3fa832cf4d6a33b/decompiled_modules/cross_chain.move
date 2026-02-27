module 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::cross_chain {
    struct EvmDepositEvent has copy, drop {
        user: address,
        amount: u64,
        shares: u64,
        message_hash: vector<u8>,
        timestamp: u64,
    }

    struct EvmWithdrawEvent has copy, drop {
        user: address,
        amount: u64,
        shares: u64,
        dest_chain: u16,
        recipient: address,
        timestamp: u64,
    }

    struct SuiDepositEvent has copy, drop {
        user: address,
        amount: u64,
        shares: u64,
        source_chain: u16,
        timestamp: u64,
    }

    struct SuiWithdrawEvent has copy, drop {
        user: address,
        amount: u64,
        shares: u64,
        dest_chain: u16,
        recipient: address,
        timestamp: u64,
    }

    struct CrossChainMessageEvent has copy, drop {
        msg_type: u8,
        source_chain: u16,
        dest_chain: u16,
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct CrossChainConfig has store, key {
        id: 0x2::object::UID,
        evm_vault: address,
        relayers: vector<address>,
        enabled: bool,
    }

    struct ProcessedMessages has store, key {
        id: 0x2::object::UID,
        hashes: vector<vector<u8>>,
    }

    struct CrossChainPayload has copy, drop, store {
        msg_type: u8,
        source_chain: u16,
        dest_chain: u16,
        user: address,
        amount: u64,
        fee: u64,
        timestamp: u64,
    }

    public fun add_relayer(arg0: &mut CrossChainConfig, arg1: &0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::admin::AdminCap, arg2: address) {
        0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::admin::verify_admin(arg1);
        if (!0x1::vector::contains<address>(&arg0.relayers, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.relayers, arg2);
        };
    }

    fun address_to_bytes(arg0: address) : vector<u8> {
        0x2::address::to_bytes(arg0)
    }

    fun bytes_to_address(arg0: &vector<u8>) : address {
        0x2::address::from_bytes(*arg0)
    }

    public fun deposit_from_chain<T0>(arg0: &mut 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::Vault<T0>, arg1: &mut 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::UserPosition, arg2: u64, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1004);
        let v0 = 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::mint_shares<T0>(arg0, arg2, arg4);
        0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::add_shares(arg1, v0);
        let v1 = SuiDepositEvent{
            user         : 0x2::tx_context::sender(arg4),
            amount       : arg2,
            shares       : v0,
            source_chain : arg3,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<SuiDepositEvent>(v1);
    }

    public fun get_config(arg0: &CrossChainConfig) : (address, bool) {
        (arg0.evm_vault, arg0.enabled)
    }

    public fun initialize_cross_chain(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : (CrossChainConfig, ProcessedMessages) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg1));
        let v1 = CrossChainConfig{
            id        : 0x2::object::new(arg1),
            evm_vault : arg0,
            relayers  : v0,
            enabled   : true,
        };
        let v2 = ProcessedMessages{
            id     : 0x2::object::new(arg1),
            hashes : vector[],
        };
        (v1, v2)
    }

    fun is_message_processed(arg0: &ProcessedMessages, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.hashes)) {
            if (0x1::vector::borrow<vector<u8>>(&arg0.hashes, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_relayer(arg0: &CrossChainConfig, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.relayers, &arg1)
    }

    public fun receive_from_evm<T0>(arg0: &mut 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::Vault<T0>, arg1: &CrossChainConfig, arg2: &mut ProcessedMessages, arg3: &mut 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::UserPosition, arg4: u64, arg5: address, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.enabled, 1000);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x1::vector::contains<address>(&arg1.relayers, &v0), 1005);
        assert!(!is_message_processed(arg2, &arg6), 1002);
        0x1::vector::push_back<vector<u8>>(&mut arg2.hashes, arg6);
        assert!(arg4 > 0, 1004);
        let v1 = 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::mint_shares<T0>(arg0, arg4, arg7);
        0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::add_shares(arg3, v1);
        let v2 = EvmDepositEvent{
            user         : arg5,
            amount       : arg4,
            shares       : v1,
            message_hash : arg6,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg7),
        };
        0x2::event::emit<EvmDepositEvent>(v2);
    }

    public fun remove_relayer(arg0: &mut CrossChainConfig, arg1: &0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::admin::AdminCap, arg2: address) {
        0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::admin::verify_admin(arg1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.relayers, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.relayers, v1);
        };
    }

    public fun withdraw_to_evm<T0>(arg0: &mut 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::Vault<T0>, arg1: &CrossChainConfig, arg2: &mut 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::UserPosition, arg3: u64, arg4: u16, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg4 == 2, 1000);
        assert!(arg1.enabled, 1000);
        let v0 = 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::burn_shares<T0>(arg0, arg2, arg3);
        let v1 = v0 - v0 * 50 / 10000;
        let v2 = SuiWithdrawEvent{
            user       : 0x2::tx_context::sender(arg6),
            amount     : v1,
            shares     : arg3,
            dest_chain : arg4,
            recipient  : arg5,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg6),
        };
        0x2::event::emit<SuiWithdrawEvent>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

