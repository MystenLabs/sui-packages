module 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message {
    struct BridgeMessage has copy, drop, store {
        message_type: u8,
        message_version: u8,
        seq_num: u64,
        source_chain: u8,
        payload: vector<u8>,
    }

    struct BridgeMessageKey has copy, drop, store {
        source_chain: u8,
        message_type: u8,
        bridge_seq_num: u64,
    }

    struct TokenTransferPayload has drop {
        sender_address: vector<u8>,
        target_chain: u8,
        target_address: vector<u8>,
        token_type: u8,
        amount: u64,
    }

    struct EmergencyOp has drop {
        op_type: u8,
    }

    struct Blocklist has drop {
        blocklist_type: u8,
        committee_eth_addresses: vector<vector<u8>>,
    }

    struct UpdateBridgeLimit has drop {
        sending_chain: u8,
        sending_token: u8,
        limit: u64,
    }

    struct UpdateAssetPrice has drop {
        token_id: u8,
        new_price: u64,
    }

    struct AddTokenOnSui has drop {
        native_token: bool,
        token_ids: vector<u8>,
        token_type_names: vector<0x1::ascii::String>,
        token_prices: vector<u64>,
    }

    struct AddRoutesOnSui has drop {
        supported_chain_ids: vector<u8>,
        supported_token_ids: vector<u8>,
        fee_percentages: vector<u64>,
        bridge_amounts: vector<u64>,
        supporteds: vector<bool>,
    }

    struct ParsedTokenTransferMessage has drop {
        message_version: u8,
        seq_num: u64,
        source_chain: u8,
        payload: vector<u8>,
        parsed_payload: TokenTransferPayload,
    }

    public fun blocklist_committee_addresses(arg0: &Blocklist) : &vector<vector<u8>> {
        &arg0.committee_eth_addresses
    }

    public fun blocklist_type(arg0: &Blocklist) : u8 {
        arg0.blocklist_type
    }

    public fun bridge_amounts(arg0: &AddRoutesOnSui) : vector<u64> {
        arg0.bridge_amounts
    }

    public fun create_add_routes_on_sui_message(arg0: u8, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<bool>) : BridgeMessage {
        0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::assert_valid_chain_id(arg0);
        let v0 = 0x2::bcs::to_bytes<vector<u8>>(&arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u64>>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u64>>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<bool>>(&arg6));
        BridgeMessage{
            message_type    : 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::add_routes_on_sui(),
            message_version : 1,
            seq_num         : arg1,
            source_chain    : arg0,
            payload         : v0,
        }
    }

    public fun create_add_tokens_on_sui_message(arg0: u8, arg1: u64, arg2: bool, arg3: vector<u8>, arg4: vector<0x1::ascii::String>, arg5: vector<u64>) : BridgeMessage {
        0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::assert_valid_chain_id(arg0);
        let v0 = 0x2::bcs::to_bytes<bool>(&arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<0x1::ascii::String>>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u64>>(&arg5));
        BridgeMessage{
            message_type    : 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::add_tokens_on_sui(),
            message_version : 1,
            seq_num         : arg1,
            source_chain    : arg0,
            payload         : v0,
        }
    }

    public fun create_blocklist_message(arg0: u8, arg1: u64, arg2: u8, arg3: vector<vector<u8>>) : BridgeMessage {
        0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::assert_valid_chain_id(arg0);
        let v0 = 0x1::vector::length<vector<u8>>(&arg3);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = &mut v1;
        0x1::vector::push_back<u8>(v2, arg2);
        0x1::vector::push_back<u8>(v2, (v0 as u8));
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<vector<u8>>(&arg3, v3);
            assert!(0x1::vector::length<u8>(&v4) == 20, 1);
            0x1::vector::append<u8>(&mut v1, v4);
            v3 = v3 + 1;
        };
        BridgeMessage{
            message_type    : 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::committee_blocklist(),
            message_version : 1,
            seq_num         : arg1,
            source_chain    : arg0,
            payload         : v1,
        }
    }

    public fun create_emergency_op_message(arg0: u8, arg1: u64, arg2: u8) : BridgeMessage {
        0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::assert_valid_chain_id(arg0);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg2);
        BridgeMessage{
            message_type    : 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::emergency_op(),
            message_version : 1,
            seq_num         : arg1,
            source_chain    : arg0,
            payload         : v0,
        }
    }

    public fun create_key(arg0: u8, arg1: u8, arg2: u64) : BridgeMessageKey {
        BridgeMessageKey{
            source_chain   : arg0,
            message_type   : arg1,
            bridge_seq_num : arg2,
        }
    }

    public fun create_token_bridge_message(arg0: u8, arg1: u64, arg2: vector<u8>, arg3: u8, arg4: vector<u8>, arg5: u8, arg6: u64) : BridgeMessage {
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, (0x1::vector::length<u8>(&arg2) as u8));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::push_back<u8>(&mut v0, arg3);
        0x1::vector::push_back<u8>(&mut v0, (0x1::vector::length<u8>(&arg4) as u8));
        0x1::vector::append<u8>(&mut v0, arg4);
        0x1::vector::push_back<u8>(&mut v0, arg5);
        0x1::vector::append<u8>(&mut v0, reverse_bytes(0x2::bcs::to_bytes<u64>(&arg6)));
        assert!(0x1::vector::length<u8>(&v0) == 64, 5);
        BridgeMessage{
            message_type    : 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::token(),
            message_version : 1,
            seq_num         : arg1,
            source_chain    : arg0,
            payload         : v0,
        }
    }

    public fun create_update_asset_price_message(arg0: u8, arg1: u8, arg2: u64, arg3: u64) : BridgeMessage {
        0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::assert_valid_chain_id(arg1);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, reverse_bytes(0x2::bcs::to_bytes<u64>(&arg3)));
        BridgeMessage{
            message_type    : 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::update_asset_price(),
            message_version : 1,
            seq_num         : arg2,
            source_chain    : arg1,
            payload         : v0,
        }
    }

    public fun create_update_bridge_limit_message(arg0: u8, arg1: u64, arg2: u8, arg3: u8, arg4: u64) : BridgeMessage {
        0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::assert_valid_chain_id(arg0);
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, arg2);
        0x1::vector::push_back<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, reverse_bytes(0x2::bcs::to_bytes<u64>(&arg4)));
        BridgeMessage{
            message_type    : 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::update_bridge_limit(),
            message_version : 1,
            seq_num         : arg1,
            source_chain    : arg0,
            payload         : v0,
        }
    }

    public fun emergency_op_pause() : u8 {
        0
    }

    public fun emergency_op_type(arg0: &EmergencyOp) : u8 {
        arg0.op_type
    }

    public fun emergency_op_unpause() : u8 {
        1
    }

    public fun extract_add_routes_on_sui(arg0: &BridgeMessage) : AddRoutesOnSui {
        let v0 = 0x2::bcs::new(arg0.payload);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        AddRoutesOnSui{
            supported_chain_ids : 0x2::bcs::peel_vec_u8(&mut v0),
            supported_token_ids : 0x2::bcs::peel_vec_u8(&mut v0),
            fee_percentages     : 0x2::bcs::peel_vec_u64(&mut v0),
            bridge_amounts      : 0x2::bcs::peel_vec_u64(&mut v0),
            supporteds          : 0x2::bcs::peel_vec_bool(&mut v0),
        }
    }

    public fun extract_add_tokens_on_sui(arg0: &BridgeMessage) : AddTokenOnSui {
        let v0 = 0x2::bcs::new(arg0.payload);
        let v1 = 0x2::bcs::peel_vec_vec_u8(&mut v0);
        let v2 = 0;
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        while (v2 < 0x1::vector::length<vector<u8>>(&v1)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x1::ascii::string(*0x1::vector::borrow<vector<u8>>(&v1, v2)));
            v2 = v2 + 1;
        };
        let v4 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v4), 0);
        AddTokenOnSui{
            native_token     : 0x2::bcs::peel_bool(&mut v0),
            token_ids        : 0x2::bcs::peel_vec_u8(&mut v0),
            token_type_names : v3,
            token_prices     : 0x2::bcs::peel_vec_u64(&mut v0),
        }
    }

    public fun extract_blocklist_payload(arg0: &BridgeMessage) : Blocklist {
        let v0 = 0x2::bcs::new(arg0.payload);
        let v1 = 0x2::bcs::peel_u8(&mut v0);
        assert!(v1 != 0, 2);
        let v2 = vector[];
        while (v1 > 0) {
            let v3 = 0;
            let v4 = b"";
            while (v3 < 20) {
                0x1::vector::push_back<u8>(&mut v4, 0x2::bcs::peel_u8(&mut v0));
                v3 = v3 + 1;
            };
            0x1::vector::push_back<vector<u8>>(&mut v2, v4);
            v1 = v1 - 1;
        };
        let v5 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v5), 0);
        Blocklist{
            blocklist_type          : 0x2::bcs::peel_u8(&mut v0),
            committee_eth_addresses : v2,
        }
    }

    public fun extract_emergency_op_payload(arg0: &BridgeMessage) : EmergencyOp {
        assert!(0x1::vector::length<u8>(&arg0.payload) == 1, 0);
        EmergencyOp{op_type: *0x1::vector::borrow<u8>(&arg0.payload, 0)}
    }

    public fun extract_token_bridge_payload(arg0: &BridgeMessage) : TokenTransferPayload {
        let v0 = 0x2::bcs::new(arg0.payload);
        let v1 = &mut v0;
        let v2 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v2), 0);
        TokenTransferPayload{
            sender_address : 0x2::bcs::peel_vec_u8(&mut v0),
            target_chain   : 0x2::bcs::peel_u8(&mut v0),
            target_address : 0x2::bcs::peel_vec_u8(&mut v0),
            token_type     : 0x2::bcs::peel_u8(&mut v0),
            amount         : peel_u64_be(v1),
        }
    }

    public fun extract_update_asset_price(arg0: &BridgeMessage) : UpdateAssetPrice {
        let v0 = 0x2::bcs::new(arg0.payload);
        let v1 = &mut v0;
        let v2 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v2), 0);
        UpdateAssetPrice{
            token_id  : 0x2::bcs::peel_u8(&mut v0),
            new_price : peel_u64_be(v1),
        }
    }

    public fun extract_update_bridge_limit(arg0: &BridgeMessage) : UpdateBridgeLimit {
        let v0 = 0x2::bcs::new(arg0.payload);
        let v1 = &mut v0;
        0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::assert_valid_chain_id(arg0.source_chain);
        let v2 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v2), 0);
        UpdateBridgeLimit{
            sending_chain : 0x2::bcs::peel_u8(&mut v0),
            sending_token : 0x2::bcs::peel_u8(&mut v0),
            limit         : peel_u64_be(v1),
        }
    }

    public fun fee_percentages(arg0: &AddRoutesOnSui) : vector<u64> {
        arg0.fee_percentages
    }

    public fun is_native(arg0: &AddTokenOnSui) : bool {
        arg0.native_token
    }

    public fun key(arg0: &BridgeMessage) : BridgeMessageKey {
        create_key(arg0.source_chain, arg0.message_type, arg0.seq_num)
    }

    public fun message_type(arg0: &BridgeMessage) : u8 {
        arg0.message_type
    }

    public fun message_version(arg0: &BridgeMessage) : u8 {
        arg0.message_version
    }

    public fun payload(arg0: &BridgeMessage) : vector<u8> {
        arg0.payload
    }

    fun peel_u64_be(arg0: &mut 0x2::bcs::BCS) : u64 {
        let v0 = 64;
        let v1 = 0;
        while (v0 > 0) {
            let v2 = v0 - 8;
            v0 = v2;
            v1 = v1 + ((0x2::bcs::peel_u8(arg0) as u64) << v2);
        };
        v1
    }

    public fun required_voting_power(arg0: &BridgeMessage) : u64 {
        let v0 = message_type(arg0);
        if (v0 == 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::token()) {
            3334
        } else if (v0 == 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::emergency_op()) {
            let v2 = extract_emergency_op_payload(arg0);
            if (v2.op_type == 0) {
                450
            } else {
                assert!(v2.op_type == 1, 4);
                5001
            }
        } else if (v0 == 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::committee_blocklist()) {
            5001
        } else if (v0 == 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::update_asset_price()) {
            5001
        } else if (v0 == 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::update_bridge_limit()) {
            5001
        } else if (v0 == 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::add_tokens_on_sui()) {
            5001
        } else {
            assert!(v0 == 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::add_routes_on_sui(), 3);
            5001
        }
    }

    fun reverse_bytes(arg0: vector<u8>) : vector<u8> {
        0x1::vector::reverse<u8>(&mut arg0);
        arg0
    }

    public fun seq_num(arg0: &BridgeMessage) : u64 {
        arg0.seq_num
    }

    public fun serialize_message(arg0: BridgeMessage) : vector<u8> {
        let BridgeMessage {
            message_type    : v0,
            message_version : v1,
            seq_num         : v2,
            source_chain    : v3,
            payload         : v4,
        } = arg0;
        let v5 = v2;
        let v6 = 0x1::vector::empty<u8>();
        let v7 = &mut v6;
        0x1::vector::push_back<u8>(v7, v0);
        0x1::vector::push_back<u8>(v7, v1);
        0x1::vector::append<u8>(&mut v6, reverse_bytes(0x2::bcs::to_bytes<u64>(&v5)));
        0x1::vector::push_back<u8>(&mut v6, v3);
        0x1::vector::append<u8>(&mut v6, v4);
        let v8 = b"";
        0x1::vector::append<u8>(&mut v8, x"19457468657265756d205369676e6564204d6573736167653a0a");
        0x1::vector::append<u8>(&mut v8, 0x1::string::into_bytes(0x1::u64::to_string(0x1::vector::length<u8>(&v6))));
        0x1::vector::append<u8>(&mut v8, v6);
        v8
    }

    public fun source_chain(arg0: &BridgeMessage) : u8 {
        arg0.source_chain
    }

    public fun supported_chain_ids(arg0: &AddRoutesOnSui) : vector<u8> {
        arg0.supported_chain_ids
    }

    public fun supported_token_ids(arg0: &AddRoutesOnSui) : vector<u8> {
        arg0.supported_token_ids
    }

    public fun supporteds(arg0: &AddRoutesOnSui) : vector<bool> {
        arg0.supporteds
    }

    public fun to_parsed_token_transfer_message(arg0: &BridgeMessage) : ParsedTokenTransferMessage {
        assert!(message_type(arg0) == 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::token(), 6);
        ParsedTokenTransferMessage{
            message_version : message_version(arg0),
            seq_num         : seq_num(arg0),
            source_chain    : source_chain(arg0),
            payload         : payload(arg0),
            parsed_payload  : extract_token_bridge_payload(arg0),
        }
    }

    public fun token_amount(arg0: &TokenTransferPayload) : u64 {
        arg0.amount
    }

    public fun token_ids(arg0: &AddTokenOnSui) : vector<u8> {
        arg0.token_ids
    }

    public fun token_prices(arg0: &AddTokenOnSui) : vector<u64> {
        arg0.token_prices
    }

    public fun token_target_address(arg0: &TokenTransferPayload) : vector<u8> {
        arg0.target_address
    }

    public fun token_target_chain(arg0: &TokenTransferPayload) : u8 {
        arg0.target_chain
    }

    public fun token_type(arg0: &TokenTransferPayload) : u8 {
        arg0.token_type
    }

    public fun token_type_names(arg0: &AddTokenOnSui) : vector<0x1::ascii::String> {
        arg0.token_type_names
    }

    public fun update_asset_price_payload_new_price(arg0: &UpdateAssetPrice) : u64 {
        arg0.new_price
    }

    public fun update_asset_price_payload_token_id(arg0: &UpdateAssetPrice) : u8 {
        arg0.token_id
    }

    public fun update_bridge_limit_payload_limit(arg0: &UpdateBridgeLimit) : u64 {
        arg0.limit
    }

    public fun update_bridge_limit_payload_sending_chain(arg0: &UpdateBridgeLimit) : u8 {
        arg0.sending_chain
    }

    public fun update_bridge_limit_payload_sending_token(arg0: &UpdateBridgeLimit) : u8 {
        arg0.sending_token
    }

    // decompiled from Move bytecode v6
}

