module 0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::Gateway {
    struct EmitterRegistered has copy, drop {
        chain_id: u16,
        emitter: address,
    }

    struct Paused has copy, drop {
        dummy_field: bool,
    }

    struct Unpaused has copy, drop {
        dummy_field: bool,
    }

    struct MintingLimitUpdated has copy, drop {
        new_limit: u64,
    }

    struct GatewayInitialized has copy, drop {
        admin: address,
    }

    struct ReceiverRegistered has copy, drop {
        chain_id: u16,
        receiver: address,
    }

    struct EmitterRemoved has copy, drop {
        chain_id: u16,
    }

    struct TokensRedeemed has copy, drop {
        vaa_hash: vector<u8>,
        token_amount: u64,
        recipient: address,
        token_address: address,
        minted: bool,
    }

    struct TokensSent has copy, drop {
        sequence: u64,
        amount: u64,
        recipient_chain: u16,
        recipient: address,
        nonce: u32,
    }

    struct AdminChanged has copy, drop {
        previous_admin: address,
        new_admin: address,
    }

    struct GatewayState has key {
        id: 0x2::object::UID,
        processed_vaas: 0x2::table::Table<vector<u8>, bool>,
        trusted_emitters: 0x2::table::Table<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>,
        trusted_receivers: 0x2::table::Table<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>,
        minting_limit: u64,
        minted_amount: u64,
        is_initialized: bool,
        paused: bool,
        nonce: u32,
    }

    struct GatewayCapabilities has key {
        id: 0x2::object::UID,
        minter_cap: 0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::TBTC::MinterCap,
        emitter_cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        treasury_cap: 0x2::coin::TreasuryCap<0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::TBTC::TBTC>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct WrappedTokenTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        tokens: 0x2::coin::Coin<T0>,
    }

    public entry fun add_trusted_emitter(arg0: &AdminCap, arg1: &mut GatewayState, arg2: u16, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized, 7);
        0x2::table::add<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&mut arg1.trusted_emitters, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(arg3)));
        let v0 = EmitterRegistered{
            chain_id : arg2,
            emitter  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(arg3))),
        };
        0x2::event::emit<EmitterRegistered>(v0);
    }

    public entry fun add_trusted_receiver(arg0: &AdminCap, arg1: &mut GatewayState, arg2: u16, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized, 7);
        0x2::table::add<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&mut arg1.trusted_receivers, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(arg3)));
        let v0 = ReceiverRegistered{
            chain_id : arg2,
            receiver : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(arg3))),
        };
        0x2::event::emit<ReceiverRegistered>(v0);
    }

    public entry fun change_admin(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        let v0 = AdminChanged{
            previous_admin : 0x2::tx_context::sender(arg2),
            new_admin      : arg1,
        };
        0x2::event::emit<AdminChanged>(v0);
    }

    public fun check_nonce(arg0: &GatewayState) : u32 {
        assert!(arg0.is_initialized, 7);
        assert!(!arg0.paused, 8);
        arg0.nonce
    }

    public fun emitter_exists(arg0: &GatewayState, arg1: u16) : bool {
        0x2::table::contains<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg0.trusted_emitters, arg1)
    }

    public fun get_emitter(arg0: &GatewayState, arg1: u16) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        *0x2::table::borrow<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg0.trusted_emitters, arg1)
    }

    public fun get_minted_amount(arg0: &GatewayState) : u64 {
        arg0.minted_amount
    }

    public fun get_minting_limit(arg0: &GatewayState) : u64 {
        arg0.minting_limit
    }

    public fun get_receiver(arg0: &GatewayState, arg1: u16) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        *0x2::table::borrow<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg0.trusted_receivers, arg1)
    }

    fun increment_nonce(arg0: &mut GatewayState) {
        assert!(arg0.is_initialized, 7);
        assert!(!arg0.paused, 8);
        if (arg0.nonce == 4294967293) {
            arg0.nonce = 0;
        } else {
            arg0.nonce = arg0.nonce + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, x"0000000000000000000000000000000000000000000000000000000000000000");
        let v1 = GatewayState{
            id                : 0x2::object::new(arg0),
            processed_vaas    : 0x2::table::new<vector<u8>, bool>(arg0),
            trusted_emitters  : 0x2::table::new<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(arg0),
            trusted_receivers : 0x2::table::new<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(arg0),
            minting_limit     : 18446744073709551615,
            minted_amount     : 0,
            is_initialized    : false,
            paused            : false,
            nonce             : 0,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<GatewayState>(v1);
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    fun init_treasury<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WrappedTokenTreasury<T0>{
            id     : 0x2::object::new(arg0),
            tokens : 0x2::coin::zero<T0>(arg0),
        };
        0x2::transfer::share_object<WrappedTokenTreasury<T0>>(v0);
    }

    public entry fun initialize_gateway<T0>(arg0: &AdminCap, arg1: &mut GatewayState, arg2: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: 0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::TBTC::MinterCap, arg4: 0x2::coin::TreasuryCap<0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::TBTC::TBTC>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_initialized, 6);
        let v0 = GatewayCapabilities{
            id           : 0x2::object::new(arg5),
            minter_cap   : arg3,
            emitter_cap  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::new(arg2, arg5),
            treasury_cap : arg4,
        };
        arg1.is_initialized = true;
        0x2::transfer::share_object<GatewayCapabilities>(v0);
        init_treasury<T0>(arg5);
        let v1 = GatewayInitialized{admin: 0x2::tx_context::sender(arg5)};
        0x2::event::emit<GatewayInitialized>(v1);
    }

    public fun is_initialized(arg0: &GatewayState) : bool {
        arg0.is_initialized
    }

    public fun is_paused(arg0: &GatewayState) : bool {
        arg0.paused
    }

    public entry fun pause(arg0: &AdminCap, arg1: &mut GatewayState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized, 7);
        assert!(!arg1.paused, 8);
        arg1.paused = true;
        let v0 = Paused{dummy_field: false};
        0x2::event::emit<Paused>(v0);
    }

    public fun receiver_exists(arg0: &GatewayState, arg1: u16) : bool {
        0x2::table::contains<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg0.trusted_receivers, arg1)
    }

    public entry fun redeem_tokens<T0>(arg0: &mut GatewayState, arg1: &mut GatewayCapabilities, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut WrappedTokenTreasury<T0>, arg4: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg5: &mut 0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::TBTC::TokenState, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 8);
        assert!(arg0.is_initialized, 7);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg2, arg6, arg7);
        let v1 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::to_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&v0));
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.processed_vaas, v1), 2);
        let v2 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_chain(&v0);
        assert!(emitter_exists(arg0, v2), 0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_address(&v0) == get_emitter(arg0, v2), 1);
        let (v3, v4, _) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer_with_payload::redeem_coin<T0>(&arg1.emitter_cap, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer_with_payload::authorize_transfer<T0>(arg4, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::vaa::verify_only_once(arg4, v0), arg8));
        let v6 = v3;
        let v7 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::take_payload(v4);
        let v8 = 0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::helpers::parse_encoded_address(&v7);
        let v9 = 0x2::coin::value<T0>(&v6);
        0x2::table::add<vector<u8>, bool>(&mut arg0.processed_vaas, v1, true);
        if (arg0.minted_amount + v9 <= arg0.minting_limit) {
            arg0.minted_amount = arg0.minted_amount + v9;
            0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::TBTC::mint(&arg1.minter_cap, &mut arg1.treasury_cap, arg5, v9, v8, arg8);
            let v10 = TokensRedeemed{
                vaa_hash      : v1,
                token_amount  : v9,
                recipient     : v8,
                token_address : @0x0,
                minted        : true,
            };
            0x2::event::emit<TokensRedeemed>(v10);
            store_wrapped_coins<T0>(arg3, v6);
        } else {
            let v11 = TokensRedeemed{
                vaa_hash      : v1,
                token_amount  : v9,
                recipient     : v8,
                token_address : @0x0,
                minted        : false,
            };
            0x2::event::emit<TokensRedeemed>(v11);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v8);
        };
    }

    public entry fun remove_trusted_emitter(arg0: &AdminCap, arg1: &mut GatewayState, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized, 7);
        0x2::table::remove<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&mut arg1.trusted_emitters, arg2);
        let v0 = EmitterRemoved{chain_id: arg2};
        0x2::event::emit<EmitterRemoved>(v0);
    }

    public entry fun remove_trusted_receiver(arg0: &AdminCap, arg1: &mut GatewayState, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized, 7);
        0x2::table::remove<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&mut arg1.trusted_receivers, arg2);
    }

    public entry fun send_tokens<T0>(arg0: &mut GatewayState, arg1: &mut GatewayCapabilities, arg2: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg3: &mut 0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::TBTC::TokenState, arg4: &mut WrappedTokenTreasury<T0>, arg5: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg6: u16, arg7: vector<u8>, arg8: 0x2::coin::Coin<0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::TBTC::TBTC>, arg9: u32, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 7);
        assert!(!arg0.paused, 8);
        assert!(arg0.nonce + 1 == arg9, 10);
        assert!(receiver_exists(arg0, arg6), 0);
        let v0 = 0x2::balance::value<0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::TBTC::TBTC>(0x2::coin::balance<0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::TBTC::TBTC>(&arg8));
        assert!(0x2::coin::value<T0>(&arg4.tokens) >= v0, 4);
        0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::TBTC::burn(&mut arg1.treasury_cap, arg3, arg8);
        if (arg0.minted_amount >= v0) {
            arg0.minted_amount = arg0.minted_amount - v0;
        } else {
            arg0.minted_amount = 0;
        };
        let (v1, v2) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens_with_payload::prepare_transfer<T0>(&arg1.emitter_cap, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::verified_asset<T0>(arg2), 0x2::coin::split<T0>(&mut arg4.tokens, v0, arg12), arg6, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(get_receiver(arg0, arg6)), 0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::helpers::encode_address(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(arg7))), arg9);
        0x2::coin::destroy_zero<T0>(v2);
        increment_nonce(arg0);
        let v3 = TokensSent{
            sequence        : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg5, arg10, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens_with_payload::transfer_tokens_with_payload<T0>(arg2, v1), arg11),
            amount          : v0,
            recipient_chain : arg6,
            recipient       : 0x2::address::from_bytes(arg7),
            nonce           : arg9,
        };
        0x2::event::emit<TokensSent>(v3);
    }

    public entry fun send_tokens_standard<T0>(arg0: &mut GatewayState, arg1: &mut GatewayCapabilities, arg2: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg3: &mut 0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::TBTC::TokenState, arg4: &mut WrappedTokenTreasury<T0>, arg5: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg6: u16, arg7: vector<u8>, arg8: 0x2::coin::Coin<0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::TBTC::TBTC>, arg9: u64, arg10: u32, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 7);
        assert!(!arg0.paused, 8);
        assert!(arg0.nonce + 1 == arg10, 10);
        let v0 = 0x2::balance::value<0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::TBTC::TBTC>(0x2::coin::balance<0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::TBTC::TBTC>(&arg8));
        assert!(0x2::coin::value<T0>(&arg4.tokens) >= v0, 4);
        0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::TBTC::burn(&mut arg1.treasury_cap, arg3, arg8);
        if (arg0.minted_amount >= v0) {
            arg0.minted_amount = arg0.minted_amount - v0;
        } else {
            arg0.minted_amount = 0;
        };
        let (v1, v2) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens::prepare_transfer<T0>(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::verified_asset<T0>(arg2), 0x2::coin::split<T0>(&mut arg4.tokens, v0, arg13), arg6, arg7, arg9, arg10);
        0x2::coin::destroy_zero<T0>(v2);
        increment_nonce(arg0);
        let v3 = TokensSent{
            sequence        : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg5, arg11, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens::transfer_tokens<T0>(arg2, v1), arg12),
            amount          : v0,
            recipient_chain : arg6,
            recipient       : 0x2::address::from_bytes(arg7),
            nonce           : arg10,
        };
        0x2::event::emit<TokensSent>(v3);
    }

    public entry fun send_wrapped_tokens<T0>(arg0: &mut GatewayState, arg1: &mut GatewayCapabilities, arg2: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg3: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: u16, arg5: vector<u8>, arg6: 0x2::coin::Coin<T0>, arg7: u32, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 7);
        assert!(!arg0.paused, 8);
        assert!(arg0.nonce + 1 == arg7, 10);
        assert!(receiver_exists(arg0, arg4), 0);
        let (v0, v1) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens_with_payload::prepare_transfer<T0>(&arg1.emitter_cap, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::verified_asset<T0>(arg2), arg6, arg4, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(arg5))), 0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::helpers::encode_address(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(arg5))), arg7);
        0x2::coin::destroy_zero<T0>(v1);
        increment_nonce(arg0);
        let v2 = TokensSent{
            sequence        : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg3, arg8, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens_with_payload::transfer_tokens_with_payload<T0>(arg2, v0), arg9),
            amount          : 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg6)),
            recipient_chain : arg4,
            recipient       : 0x2::address::from_bytes(arg5),
            nonce           : arg7,
        };
        0x2::event::emit<TokensSent>(v2);
    }

    fun store_wrapped_coins<T0>(arg0: &mut WrappedTokenTreasury<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(&mut arg0.tokens, arg1);
    }

    public entry fun unpause(arg0: &AdminCap, arg1: &mut GatewayState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized, 7);
        assert!(arg1.paused, 9);
        arg1.paused = false;
        let v0 = Unpaused{dummy_field: false};
        0x2::event::emit<Unpaused>(v0);
    }

    public entry fun update_minting_limit(arg0: &AdminCap, arg1: &mut GatewayState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized, 7);
        arg1.minting_limit = arg2;
        let v0 = MintingLimitUpdated{new_limit: arg2};
        0x2::event::emit<MintingLimitUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

