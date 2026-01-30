module 0x46a01b81e0f81ea983d28a379d9358951ff05d0bee5fe3f268a2eaa2460f4c5f::structs {
    struct RequestCreated has copy, drop {
        request_id: 0x2::object::ID,
        user: address,
        wallet_key: u64,
        source_chain: u64,
        source_token: vector<u8>,
        source_amount: u256,
        destination_chain: u64,
        destination_token: vector<u8>,
        destination_address: vector<u8>,
        min_destination_amount: u256,
        min_confirmations: u64,
        deadline: u64,
        relayer_sender: vector<u8>,
        relayer_recipient: vector<u8>,
    }

    struct RequestSettled has copy, drop {
        request_id: 0x2::object::ID,
        digest: vector<u8>,
        destination_amount: u256,
        source_amount: u256,
        signature_request_id: 0x2::object::ID,
        message: vector<u8>,
        tx_bytes: vector<u8>,
    }

    struct RequestCancelled has copy, drop {
        request_id: 0x2::object::ID,
    }

    struct RequestExpired has copy, drop {
        request_id: 0x2::object::ID,
    }

    struct RequestWithdrawn has copy, drop {
        request_id: 0x2::object::ID,
        source_amount: u256,
        signature_request_id: 0x2::object::ID,
    }

    struct ChainAdded has copy, drop {
        pos0: u64,
    }

    struct ChainRemoved has copy, drop {
        pos0: u64,
    }

    struct Paused has copy, drop {
        dummy_field: bool,
    }

    struct Unpaused has copy, drop {
        dummy_field: bool,
    }

    struct RelayerAdded has copy, drop {
        pos0: vector<u8>,
    }

    struct RelayerRemoved has copy, drop {
        pos0: vector<u8>,
    }

    struct WalletAdded has copy, drop {
        pos0: u64,
    }

    struct MinConfirmationsSet has copy, drop {
        chain_id: u64,
        min_confirmations: u64,
    }

    struct Deposited has copy, drop {
        user: address,
        chain_id: u64,
        token: vector<u8>,
        amount: u256,
    }

    struct Withdrawn has copy, drop {
        user: address,
        chain_id: u64,
        token: vector<u8>,
        amount: u256,
        recipient: vector<u8>,
        signature_request_id: 0x2::object::ID,
    }

    struct RequestParams has copy, drop {
        signature: vector<u8>,
        digest: vector<u8>,
        timestamp_ms: u64,
        wallet_key: u64,
        source_address: vector<u8>,
        source_chain: u64,
        source_token: vector<u8>,
        source_amount: u256,
        destination_chain: u64,
        destination_token: vector<u8>,
        destination_address: vector<u8>,
        min_destination_amount: u256,
        min_confirmations: u64,
        deadline: u64,
        relayer_sender: vector<u8>,
        relayer_recipient: vector<u8>,
    }

    struct SettleParams has copy, drop {
        signature: vector<u8>,
        digest: vector<u8>,
        destination_amount: u256,
        confirmations: u64,
        message: vector<u8>,
        message_centralized_signature: vector<u8>,
        timestamp_ms: u64,
        tx_bytes: vector<u8>,
    }

    struct WithdrawRequestParams has copy, drop {
        signature: vector<u8>,
        recipient: vector<u8>,
        message: vector<u8>,
        message_centralized_signature: vector<u8>,
        timestamp_ms: u64,
        tx_bytes: vector<u8>,
    }

    struct DepositBalanceParams has copy, drop {
        signature: vector<u8>,
        digest: vector<u8>,
        timestamp_ms: u64,
        wallet_key: u64,
        source_chain: u64,
        source_address: vector<u8>,
        source_token: vector<u8>,
        source_amount: u256,
        confirmations: u64,
    }

    struct WithdrawBalanceParams has copy, drop {
        signature: vector<u8>,
        timestamp_ms: u64,
        wallet_key: u64,
        source_chain: u64,
        source_address: vector<u8>,
        source_token: vector<u8>,
        amount: u256,
        recipient: vector<u8>,
        message: vector<u8>,
        message_centralized_signature: vector<u8>,
    }

    struct RequestFromBalanceParams has copy, drop {
        wallet_key: u64,
        source_chain: u64,
        source_address: vector<u8>,
        source_token: vector<u8>,
        source_amount: u256,
        destination_chain: u64,
        destination_token: vector<u8>,
        destination_address: vector<u8>,
        min_destination_amount: u256,
        min_confirmations: u64,
        deadline: u64,
        relayer_sender: vector<u8>,
        relayer_recipient: vector<u8>,
    }

    struct WithdrawBalanceResponse has copy, drop {
        chain_id: u64,
        wallet_key: u64,
        user: vector<u8>,
        token: vector<u8>,
        amount: u256,
        recipient: vector<u8>,
        message: vector<u8>,
    }

    struct DepositResponse has copy, drop {
        digest: vector<u8>,
        chain_id: u64,
        wallet_key: u64,
        user: vector<u8>,
        token: vector<u8>,
        amount: u256,
        confirmations: u64,
    }

    struct SettleResponse has copy, drop {
        digest: vector<u8>,
        destination_chain: u64,
        destination_address: vector<u8>,
        destination_token: vector<u8>,
        destination_amount: u256,
        relayer_sender: vector<u8>,
        confirmations: u64,
        source_chain: u64,
        wallet_key: u64,
        relayer_recipient: vector<u8>,
        source_token: vector<u8>,
        source_amount: u256,
        message: vector<u8>,
    }

    struct WithdrawResponse has copy, drop {
        chain_id: u64,
        wallet_key: u64,
        user: vector<u8>,
        token: vector<u8>,
        amount: u256,
        recipient: vector<u8>,
        message: vector<u8>,
    }

    public fun deposit_balance_params_confirmations(arg0: &DepositBalanceParams) : u64 {
        arg0.confirmations
    }

    public fun deposit_balance_params_digest(arg0: &DepositBalanceParams) : vector<u8> {
        arg0.digest
    }

    public fun deposit_balance_params_signature(arg0: &DepositBalanceParams) : vector<u8> {
        arg0.signature
    }

    public fun deposit_balance_params_source_address(arg0: &DepositBalanceParams) : vector<u8> {
        arg0.source_address
    }

    public fun deposit_balance_params_source_amount(arg0: &DepositBalanceParams) : u256 {
        arg0.source_amount
    }

    public fun deposit_balance_params_source_chain(arg0: &DepositBalanceParams) : u64 {
        arg0.source_chain
    }

    public fun deposit_balance_params_source_token(arg0: &DepositBalanceParams) : vector<u8> {
        arg0.source_token
    }

    public fun deposit_balance_params_timestamp_ms(arg0: &DepositBalanceParams) : u64 {
        arg0.timestamp_ms
    }

    public(friend) fun deposit_balance_params_to_response(arg0: &DepositBalanceParams) : DepositResponse {
        DepositResponse{
            digest        : arg0.digest,
            chain_id      : arg0.source_chain,
            wallet_key    : arg0.wallet_key,
            user          : arg0.source_address,
            token         : arg0.source_token,
            amount        : arg0.source_amount,
            confirmations : arg0.confirmations,
        }
    }

    public fun deposit_balance_params_wallet_key(arg0: &DepositBalanceParams) : u64 {
        arg0.wallet_key
    }

    public(friend) fun emit_balance_deposited(arg0: &DepositBalanceParams, arg1: address) {
        let v0 = Deposited{
            user     : arg1,
            chain_id : arg0.source_chain,
            token    : arg0.source_token,
            amount   : arg0.source_amount,
        };
        0x2::event::emit<Deposited>(v0);
    }

    public(friend) fun emit_chain_added(arg0: u64) {
        let v0 = ChainAdded{pos0: arg0};
        0x2::event::emit<ChainAdded>(v0);
    }

    public(friend) fun emit_chain_removed(arg0: u64) {
        let v0 = ChainRemoved{pos0: arg0};
        0x2::event::emit<ChainRemoved>(v0);
    }

    public(friend) fun emit_min_confirmations_set(arg0: u64, arg1: u64) {
        let v0 = MinConfirmationsSet{
            chain_id          : arg0,
            min_confirmations : arg1,
        };
        0x2::event::emit<MinConfirmationsSet>(v0);
    }

    public(friend) fun emit_paused() {
        let v0 = Paused{dummy_field: false};
        0x2::event::emit<Paused>(v0);
    }

    public(friend) fun emit_relayer_added(arg0: vector<u8>) {
        let v0 = RelayerAdded{pos0: arg0};
        0x2::event::emit<RelayerAdded>(v0);
    }

    public(friend) fun emit_relayer_removed(arg0: vector<u8>) {
        let v0 = RelayerRemoved{pos0: arg0};
        0x2::event::emit<RelayerRemoved>(v0);
    }

    public(friend) fun emit_request_cancelled(arg0: 0x2::object::ID) {
        let v0 = RequestCancelled{request_id: arg0};
        0x2::event::emit<RequestCancelled>(v0);
    }

    public(friend) fun emit_request_created(arg0: &RequestParams, arg1: 0x2::object::ID, arg2: address) {
        let v0 = RequestCreated{
            request_id             : arg1,
            user                   : arg2,
            wallet_key             : arg0.wallet_key,
            source_chain           : arg0.source_chain,
            source_token           : arg0.source_token,
            source_amount          : arg0.source_amount,
            destination_chain      : arg0.destination_chain,
            destination_token      : arg0.destination_token,
            destination_address    : arg0.destination_address,
            min_destination_amount : arg0.min_destination_amount,
            min_confirmations      : arg0.min_confirmations,
            deadline               : arg0.deadline,
            relayer_sender         : arg0.relayer_sender,
            relayer_recipient      : arg0.relayer_recipient,
        };
        0x2::event::emit<RequestCreated>(v0);
    }

    public(friend) fun emit_request_expired(arg0: 0x2::object::ID) {
        let v0 = RequestExpired{request_id: arg0};
        0x2::event::emit<RequestExpired>(v0);
    }

    public(friend) fun emit_request_from_balance_created(arg0: &RequestFromBalanceParams, arg1: 0x2::object::ID, arg2: address) {
        let v0 = RequestCreated{
            request_id             : arg1,
            user                   : arg2,
            wallet_key             : arg0.wallet_key,
            source_chain           : arg0.source_chain,
            source_token           : arg0.source_token,
            source_amount          : arg0.source_amount,
            destination_chain      : arg0.destination_chain,
            destination_token      : arg0.destination_token,
            destination_address    : arg0.destination_address,
            min_destination_amount : arg0.min_destination_amount,
            min_confirmations      : arg0.min_confirmations,
            deadline               : arg0.deadline,
            relayer_sender         : arg0.relayer_sender,
            relayer_recipient      : arg0.relayer_recipient,
        };
        0x2::event::emit<RequestCreated>(v0);
    }

    public(friend) fun emit_request_settled(arg0: &SettleParams, arg1: 0x2::object::ID, arg2: u256, arg3: 0x2::object::ID) {
        let v0 = RequestSettled{
            request_id           : arg1,
            digest               : arg0.digest,
            destination_amount   : arg0.destination_amount,
            source_amount        : arg2,
            signature_request_id : arg3,
            message              : arg0.message,
            tx_bytes             : arg0.tx_bytes,
        };
        0x2::event::emit<RequestSettled>(v0);
    }

    public(friend) fun emit_request_withdrawn(arg0: 0x2::object::ID, arg1: u256, arg2: 0x2::object::ID) {
        let v0 = RequestWithdrawn{
            request_id           : arg0,
            source_amount        : arg1,
            signature_request_id : arg2,
        };
        0x2::event::emit<RequestWithdrawn>(v0);
    }

    public(friend) fun emit_unpaused() {
        let v0 = Unpaused{dummy_field: false};
        0x2::event::emit<Unpaused>(v0);
    }

    public(friend) fun emit_wallet_added(arg0: u64) {
        let v0 = WalletAdded{pos0: arg0};
        0x2::event::emit<WalletAdded>(v0);
    }

    public(friend) fun emit_withdrawn(arg0: &WithdrawBalanceParams, arg1: address, arg2: 0x2::object::ID) {
        let v0 = Withdrawn{
            user                 : arg1,
            chain_id             : arg0.source_chain,
            token                : arg0.source_token,
            amount               : arg0.amount,
            recipient            : arg0.recipient,
            signature_request_id : arg2,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    public fun new_deposit_balance_params(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: u256, arg8: u64) : DepositBalanceParams {
        DepositBalanceParams{
            signature      : arg0,
            digest         : arg1,
            timestamp_ms   : arg2,
            wallet_key     : arg3,
            source_chain   : arg4,
            source_address : arg5,
            source_token   : arg6,
            source_amount  : arg7,
            confirmations  : arg8,
        }
    }

    public fun new_request_from_balance_params(arg0: u64, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: u256, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: u256, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: vector<u8>) : RequestFromBalanceParams {
        RequestFromBalanceParams{
            wallet_key             : arg0,
            source_chain           : arg1,
            source_address         : arg2,
            source_token           : arg3,
            source_amount          : arg4,
            destination_chain      : arg5,
            destination_token      : arg6,
            destination_address    : arg7,
            min_destination_amount : arg8,
            min_confirmations      : arg9,
            deadline               : arg10,
            relayer_sender         : arg11,
            relayer_recipient      : arg12,
        }
    }

    public fun new_request_params(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: u256, arg8: u64, arg9: vector<u8>, arg10: vector<u8>, arg11: u256, arg12: u64, arg13: u64, arg14: vector<u8>, arg15: vector<u8>) : RequestParams {
        RequestParams{
            signature              : arg0,
            digest                 : arg1,
            timestamp_ms           : arg2,
            wallet_key             : arg3,
            source_address         : arg4,
            source_chain           : arg5,
            source_token           : arg6,
            source_amount          : arg7,
            destination_chain      : arg8,
            destination_token      : arg9,
            destination_address    : arg10,
            min_destination_amount : arg11,
            min_confirmations      : arg12,
            deadline               : arg13,
            relayer_sender         : arg14,
            relayer_recipient      : arg15,
        }
    }

    public fun new_settle_params(arg0: vector<u8>, arg1: vector<u8>, arg2: u256, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: vector<u8>) : SettleParams {
        SettleParams{
            signature                     : arg0,
            digest                        : arg1,
            destination_amount            : arg2,
            confirmations                 : arg3,
            message                       : arg4,
            message_centralized_signature : arg5,
            timestamp_ms                  : arg6,
            tx_bytes                      : arg7,
        }
    }

    public fun new_withdraw_balance_params(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: u256, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>) : WithdrawBalanceParams {
        WithdrawBalanceParams{
            signature                     : arg0,
            timestamp_ms                  : arg1,
            wallet_key                    : arg2,
            source_chain                  : arg3,
            source_address                : arg4,
            source_token                  : arg5,
            amount                        : arg6,
            recipient                     : arg7,
            message                       : arg8,
            message_centralized_signature : arg9,
        }
    }

    public fun new_withdraw_request_params(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>) : WithdrawRequestParams {
        WithdrawRequestParams{
            signature                     : arg0,
            recipient                     : arg1,
            message                       : arg2,
            message_centralized_signature : arg3,
            timestamp_ms                  : arg4,
            tx_bytes                      : arg5,
        }
    }

    public fun request_from_balance_params_deadline(arg0: &RequestFromBalanceParams) : u64 {
        arg0.deadline
    }

    public fun request_from_balance_params_destination_address(arg0: &RequestFromBalanceParams) : vector<u8> {
        arg0.destination_address
    }

    public fun request_from_balance_params_destination_chain(arg0: &RequestFromBalanceParams) : u64 {
        arg0.destination_chain
    }

    public fun request_from_balance_params_destination_token(arg0: &RequestFromBalanceParams) : vector<u8> {
        arg0.destination_token
    }

    public fun request_from_balance_params_min_confirmations(arg0: &RequestFromBalanceParams) : u64 {
        arg0.min_confirmations
    }

    public fun request_from_balance_params_min_destination_amount(arg0: &RequestFromBalanceParams) : u256 {
        arg0.min_destination_amount
    }

    public fun request_from_balance_params_relayer_recipient(arg0: &RequestFromBalanceParams) : vector<u8> {
        arg0.relayer_recipient
    }

    public fun request_from_balance_params_relayer_sender(arg0: &RequestFromBalanceParams) : vector<u8> {
        arg0.relayer_sender
    }

    public fun request_from_balance_params_source_address(arg0: &RequestFromBalanceParams) : vector<u8> {
        arg0.source_address
    }

    public fun request_from_balance_params_source_amount(arg0: &RequestFromBalanceParams) : u256 {
        arg0.source_amount
    }

    public fun request_from_balance_params_source_chain(arg0: &RequestFromBalanceParams) : u64 {
        arg0.source_chain
    }

    public fun request_from_balance_params_source_token(arg0: &RequestFromBalanceParams) : vector<u8> {
        arg0.source_token
    }

    public fun request_from_balance_params_wallet_key(arg0: &RequestFromBalanceParams) : u64 {
        arg0.wallet_key
    }

    public fun request_params_deadline(arg0: &RequestParams) : u64 {
        arg0.deadline
    }

    public fun request_params_destination_address(arg0: &RequestParams) : vector<u8> {
        arg0.destination_address
    }

    public fun request_params_destination_chain(arg0: &RequestParams) : u64 {
        arg0.destination_chain
    }

    public fun request_params_destination_token(arg0: &RequestParams) : vector<u8> {
        arg0.destination_token
    }

    public fun request_params_digest(arg0: &RequestParams) : vector<u8> {
        arg0.digest
    }

    public fun request_params_min_confirmations(arg0: &RequestParams) : u64 {
        arg0.min_confirmations
    }

    public fun request_params_min_destination_amount(arg0: &RequestParams) : u256 {
        arg0.min_destination_amount
    }

    public fun request_params_relayer_recipient(arg0: &RequestParams) : vector<u8> {
        arg0.relayer_recipient
    }

    public fun request_params_relayer_sender(arg0: &RequestParams) : vector<u8> {
        arg0.relayer_sender
    }

    public fun request_params_signature(arg0: &RequestParams) : vector<u8> {
        arg0.signature
    }

    public fun request_params_source_address(arg0: &RequestParams) : vector<u8> {
        arg0.source_address
    }

    public fun request_params_source_amount(arg0: &RequestParams) : u256 {
        arg0.source_amount
    }

    public fun request_params_source_chain(arg0: &RequestParams) : u64 {
        arg0.source_chain
    }

    public fun request_params_source_token(arg0: &RequestParams) : vector<u8> {
        arg0.source_token
    }

    public fun request_params_timestamp_ms(arg0: &RequestParams) : u64 {
        arg0.timestamp_ms
    }

    public(friend) fun request_params_to_response(arg0: &RequestParams) : DepositResponse {
        DepositResponse{
            digest        : arg0.digest,
            chain_id      : arg0.source_chain,
            wallet_key    : arg0.wallet_key,
            user          : arg0.source_address,
            token         : arg0.source_token,
            amount        : arg0.source_amount,
            confirmations : arg0.min_confirmations,
        }
    }

    public fun request_params_wallet_key(arg0: &RequestParams) : u64 {
        arg0.wallet_key
    }

    public fun settle_params_confirmations(arg0: &SettleParams) : u64 {
        arg0.confirmations
    }

    public fun settle_params_destination_amount(arg0: &SettleParams) : u256 {
        arg0.destination_amount
    }

    public fun settle_params_digest(arg0: &SettleParams) : vector<u8> {
        arg0.digest
    }

    public fun settle_params_message(arg0: &SettleParams) : vector<u8> {
        arg0.message
    }

    public fun settle_params_message_centralized_signature(arg0: &SettleParams) : vector<u8> {
        arg0.message_centralized_signature
    }

    public fun settle_params_signature(arg0: &SettleParams) : vector<u8> {
        arg0.signature
    }

    public fun settle_params_timestamp_ms(arg0: &SettleParams) : u64 {
        arg0.timestamp_ms
    }

    public(friend) fun settle_params_to_response(arg0: &SettleParams, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: u256) : SettleResponse {
        SettleResponse{
            digest              : arg0.digest,
            destination_chain   : arg1,
            destination_address : arg2,
            destination_token   : arg3,
            destination_amount  : arg0.destination_amount,
            relayer_sender      : arg4,
            confirmations       : arg0.confirmations,
            source_chain        : arg5,
            wallet_key          : arg6,
            relayer_recipient   : arg7,
            source_token        : arg8,
            source_amount       : arg9,
            message             : arg0.message,
        }
    }

    public fun settle_params_tx_bytes(arg0: &SettleParams) : vector<u8> {
        arg0.tx_bytes
    }

    public fun withdraw_balance_params_amount(arg0: &WithdrawBalanceParams) : u256 {
        arg0.amount
    }

    public fun withdraw_balance_params_message(arg0: &WithdrawBalanceParams) : vector<u8> {
        arg0.message
    }

    public fun withdraw_balance_params_message_centralized_signature(arg0: &WithdrawBalanceParams) : vector<u8> {
        arg0.message_centralized_signature
    }

    public fun withdraw_balance_params_recipient(arg0: &WithdrawBalanceParams) : vector<u8> {
        arg0.recipient
    }

    public fun withdraw_balance_params_signature(arg0: &WithdrawBalanceParams) : vector<u8> {
        arg0.signature
    }

    public fun withdraw_balance_params_source_address(arg0: &WithdrawBalanceParams) : vector<u8> {
        arg0.source_address
    }

    public fun withdraw_balance_params_source_chain(arg0: &WithdrawBalanceParams) : u64 {
        arg0.source_chain
    }

    public fun withdraw_balance_params_source_token(arg0: &WithdrawBalanceParams) : vector<u8> {
        arg0.source_token
    }

    public fun withdraw_balance_params_timestamp_ms(arg0: &WithdrawBalanceParams) : u64 {
        arg0.timestamp_ms
    }

    public(friend) fun withdraw_balance_params_to_response(arg0: &WithdrawBalanceParams) : WithdrawBalanceResponse {
        WithdrawBalanceResponse{
            chain_id   : arg0.source_chain,
            wallet_key : arg0.wallet_key,
            user       : arg0.source_address,
            token      : arg0.source_token,
            amount     : arg0.amount,
            recipient  : arg0.recipient,
            message    : arg0.message,
        }
    }

    public fun withdraw_balance_params_wallet_key(arg0: &WithdrawBalanceParams) : u64 {
        arg0.wallet_key
    }

    public fun withdraw_request_params_message(arg0: &WithdrawRequestParams) : vector<u8> {
        arg0.message
    }

    public fun withdraw_request_params_message_centralized_signature(arg0: &WithdrawRequestParams) : vector<u8> {
        arg0.message_centralized_signature
    }

    public fun withdraw_request_params_recipient(arg0: &WithdrawRequestParams) : vector<u8> {
        arg0.recipient
    }

    public fun withdraw_request_params_signature(arg0: &WithdrawRequestParams) : vector<u8> {
        arg0.signature
    }

    public fun withdraw_request_params_timestamp_ms(arg0: &WithdrawRequestParams) : u64 {
        arg0.timestamp_ms
    }

    public(friend) fun withdraw_request_params_to_response(arg0: &WithdrawRequestParams, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u256) : WithdrawResponse {
        WithdrawResponse{
            chain_id   : arg1,
            wallet_key : arg2,
            user       : arg3,
            token      : arg4,
            amount     : arg5,
            recipient  : arg0.recipient,
            message    : arg0.message,
        }
    }

    public fun withdraw_request_params_tx_bytes(arg0: &WithdrawRequestParams) : vector<u8> {
        arg0.tx_bytes
    }

    // decompiled from Move bytecode v6
}

