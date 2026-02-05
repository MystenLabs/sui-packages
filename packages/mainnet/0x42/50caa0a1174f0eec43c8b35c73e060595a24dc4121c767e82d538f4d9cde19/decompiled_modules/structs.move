module 0x4250caa0a1174f0eec43c8b35c73e060595a24dc4121c767e82d538f4d9cde19::structs {
    struct MintRequestCreated has copy, drop {
        request_id: 0x2::object::ID,
        user: address,
        source_chain: u64,
        source_token: vector<u8>,
        source_decimals: u8,
        source_address: vector<u8>,
        source_amount: u256,
    }

    struct MintDigestSet has copy, drop {
        request_id: 0x2::object::ID,
        digest: vector<u8>,
    }

    struct MintRequestCancelled has copy, drop {
        request_id: 0x2::object::ID,
        source_chain: u64,
        source_token: vector<u8>,
        source_amount: u256,
        signature_request_id: 0x2::object::ID,
    }

    struct MintCompleted has copy, drop {
        request_id: 0x2::object::ID,
        source_chain: u64,
        source_token: vector<u8>,
        source_amount: u256,
        minted_amount: u64,
        digest: vector<u8>,
    }

    struct BurnRequestCreated has copy, drop {
        request_id: 0x2::object::ID,
        user: address,
        source_chain: u64,
        source_token: vector<u8>,
        source_decimals: u8,
        destination_address: vector<u8>,
        source_amount: u256,
    }

    struct BurnCompleted has copy, drop {
        request_id: 0x2::object::ID,
        source_chain: u64,
        source_token: vector<u8>,
        destination_address: vector<u8>,
        source_amount: u256,
        burned_amount: u64,
        signature_request_id: 0x2::object::ID,
    }

    struct BurnRequestCancelled has copy, drop {
        request_id: 0x2::object::ID,
        source_chain: u64,
        source_token: vector<u8>,
        source_amount: u256,
    }

    struct TokenAdded has copy, drop {
        source_chain: u64,
        source_token: vector<u8>,
        source_decimals: u8,
        decimals: u8,
    }

    struct ChainAdded has copy, drop {
        pos0: u64,
    }

    struct ChainRemoved has copy, drop {
        pos0: u64,
    }

    struct WalletAdded has copy, drop {
        chain_id: u64,
        wallet_key: u64,
    }

    struct MintFeeSet has copy, drop {
        pos0: u64,
    }

    struct BurnFeeSet has copy, drop {
        pos0: u64,
    }

    struct PresignFeeSet has copy, drop {
        pos0: u64,
    }

    struct FeesCollected has copy, drop {
        pos0: u64,
    }

    struct Paused has copy, drop {
        dummy_field: bool,
    }

    struct Unpaused has copy, drop {
        dummy_field: bool,
    }

    struct ValidatorTypeAdded has copy, drop {
        validator_type: 0x1::type_name::TypeName,
    }

    struct ValidatorTypeRemoved has copy, drop {
        validator_type: 0x1::type_name::TypeName,
    }

    struct MinVotesSet has copy, drop {
        pos0: u64,
    }

    struct MaxSupplySet has copy, drop {
        source_chain: u64,
        source_token: vector<u8>,
        max_supply: u64,
    }

    struct ExpectedPcrsSet has copy, drop {
        pcr0: vector<u8>,
        pcr2: vector<u8>,
    }

    struct MintParams has copy, drop {
        signature: vector<u8>,
        digest: vector<u8>,
        timestamp_ms: u64,
        chain_id: u64,
        wallet_key: u64,
        user: vector<u8>,
        token: vector<u8>,
        amount: u256,
    }

    struct BurnParams has copy, drop {
        signature: vector<u8>,
        timestamp_ms: u64,
        chain_id: u64,
        wallet_key: u64,
        user: vector<u8>,
        token: vector<u8>,
        amount: u256,
        recipient: vector<u8>,
        message: vector<u8>,
        message_centralized_signature: vector<u8>,
    }

    struct MintResponse has copy, drop {
        digest: vector<u8>,
        chain_id: u64,
        wallet_key: u64,
        user: vector<u8>,
        token: vector<u8>,
        amount: u256,
    }

    struct BurnResponse has copy, drop {
        chain_id: u64,
        wallet_key: u64,
        user: vector<u8>,
        token: vector<u8>,
        amount: u256,
        recipient: vector<u8>,
        message: vector<u8>,
    }

    struct VoteResponse has copy, drop {
        request_id: 0x2::object::ID,
        wallet_key: u64,
        source_chain: u64,
        source_token: vector<u8>,
        source_decimals: u8,
        source_address: vector<u8>,
        source_amount: u256,
        digest: vector<u8>,
    }

    struct VoteBurnResponse has copy, drop {
        request_id: 0x2::object::ID,
        wallet_key: u64,
        source_chain: u64,
        source_token: vector<u8>,
        source_decimals: u8,
        destination_address: vector<u8>,
        source_amount: u256,
        message: vector<u8>,
    }

    struct CancelMintResponse has copy, drop {
        request_id: 0x2::object::ID,
        wallet_key: u64,
        source_chain: u64,
        source_token: vector<u8>,
        source_decimals: u8,
        source_address: vector<u8>,
        source_amount: u256,
        digest: vector<u8>,
        message: vector<u8>,
    }

    struct LockRequestCreated has copy, drop {
        request_id: 0x2::object::ID,
        user: address,
        target_chain: u64,
        foreign_token: vector<u8>,
        recipient_address: vector<u8>,
        lock_amount: u64,
        foreign_amount: u256,
    }

    struct LockCompleted has copy, drop {
        request_id: 0x2::object::ID,
        target_chain: u64,
        foreign_token: vector<u8>,
        recipient_address: vector<u8>,
        lock_amount: u64,
        foreign_amount: u256,
        signature_request_id: 0x2::object::ID,
    }

    struct LockRequestCancelled has copy, drop {
        request_id: 0x2::object::ID,
        target_chain: u64,
        lock_amount: u64,
    }

    struct UnlockRequestCreated has copy, drop {
        request_id: 0x2::object::ID,
        user: address,
        source_chain: u64,
        foreign_token: vector<u8>,
        sender_address: vector<u8>,
        sui_recipient: address,
        foreign_amount: u256,
    }

    struct UnlockDigestSet has copy, drop {
        request_id: 0x2::object::ID,
        digest: vector<u8>,
    }

    struct UnlockCompleted has copy, drop {
        request_id: 0x2::object::ID,
        source_chain: u64,
        foreign_token: vector<u8>,
        sender_address: vector<u8>,
        foreign_amount: u256,
        unlock_amount: u64,
        digest: vector<u8>,
    }

    struct UnlockRequestCancelled has copy, drop {
        request_id: 0x2::object::ID,
        source_chain: u64,
        foreign_amount: u256,
        signature_request_id: 0x2::object::ID,
    }

    struct OutTokenRegistered has copy, drop {
        target_chain: u64,
        foreign_token: vector<u8>,
        foreign_decimals: u8,
        sui_decimals: u8,
    }

    struct MaxLockSet has copy, drop {
        target_chain: u64,
        foreign_token: vector<u8>,
        max_lock: u64,
    }

    struct LockFeeSet has copy, drop {
        pos0: u64,
    }

    struct UnlockFeeSet has copy, drop {
        pos0: u64,
    }

    struct VoteLockResponse has copy, drop {
        request_id: 0x2::object::ID,
        wallet_key: u64,
        target_chain: u64,
        foreign_token: vector<u8>,
        foreign_decimals: u8,
        recipient_address: vector<u8>,
        foreign_amount: u256,
        message: vector<u8>,
    }

    struct VoteUnlockResponse has copy, drop {
        request_id: 0x2::object::ID,
        wallet_key: u64,
        source_chain: u64,
        foreign_token: vector<u8>,
        foreign_decimals: u8,
        sender_address: vector<u8>,
        sui_recipient: address,
        foreign_amount: u256,
        digest: vector<u8>,
    }

    struct CancelUnlockResponse has copy, drop {
        request_id: 0x2::object::ID,
        wallet_key: u64,
        source_chain: u64,
        foreign_token: vector<u8>,
        foreign_decimals: u8,
        sender_address: vector<u8>,
        foreign_amount: u256,
        digest: vector<u8>,
        message: vector<u8>,
    }

    struct WatchtowerAdded has copy, drop {
        pos0: address,
    }

    struct WatchtowerRemoved has copy, drop {
        pos0: address,
    }

    struct WatchtowerPaused has copy, drop {
        pos0: address,
    }

    struct RateLimitSet has copy, drop {
        window_ms: u64,
        amount: u64,
    }

    public(friend) fun burn_params_amount(arg0: &BurnParams) : u256 {
        arg0.amount
    }

    public(friend) fun burn_params_chain_id(arg0: &BurnParams) : u64 {
        arg0.chain_id
    }

    public(friend) fun burn_params_message(arg0: &BurnParams) : vector<u8> {
        arg0.message
    }

    public(friend) fun burn_params_message_centralized_signature(arg0: &BurnParams) : vector<u8> {
        arg0.message_centralized_signature
    }

    public(friend) fun burn_params_recipient(arg0: &BurnParams) : vector<u8> {
        arg0.recipient
    }

    public(friend) fun burn_params_signature(arg0: &BurnParams) : vector<u8> {
        arg0.signature
    }

    public(friend) fun burn_params_timestamp_ms(arg0: &BurnParams) : u64 {
        arg0.timestamp_ms
    }

    public(friend) fun burn_params_to_response(arg0: &BurnParams) : BurnResponse {
        BurnResponse{
            chain_id   : arg0.chain_id,
            wallet_key : arg0.wallet_key,
            user       : arg0.user,
            token      : arg0.token,
            amount     : arg0.amount,
            recipient  : arg0.recipient,
            message    : arg0.message,
        }
    }

    public(friend) fun burn_params_token(arg0: &BurnParams) : vector<u8> {
        arg0.token
    }

    public(friend) fun burn_params_user(arg0: &BurnParams) : vector<u8> {
        arg0.user
    }

    public(friend) fun burn_params_wallet_key(arg0: &BurnParams) : u64 {
        arg0.wallet_key
    }

    public(friend) fun emit_burn_completed(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: u256, arg5: u64, arg6: 0x2::object::ID) {
        let v0 = BurnCompleted{
            request_id           : arg0,
            source_chain         : arg1,
            source_token         : arg2,
            destination_address  : arg3,
            source_amount        : arg4,
            burned_amount        : arg5,
            signature_request_id : arg6,
        };
        0x2::event::emit<BurnCompleted>(v0);
    }

    public(friend) fun emit_burn_fee_set(arg0: u64) {
        let v0 = BurnFeeSet{pos0: arg0};
        0x2::event::emit<BurnFeeSet>(v0);
    }

    public(friend) fun emit_burn_request_cancelled(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>, arg3: u256) {
        let v0 = BurnRequestCancelled{
            request_id    : arg0,
            source_chain  : arg1,
            source_token  : arg2,
            source_amount : arg3,
        };
        0x2::event::emit<BurnRequestCancelled>(v0);
    }

    public(friend) fun emit_burn_request_created(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: u256) {
        let v0 = BurnRequestCreated{
            request_id          : arg0,
            user                : arg1,
            source_chain        : arg2,
            source_token        : arg3,
            source_decimals     : arg4,
            destination_address : arg5,
            source_amount       : arg6,
        };
        0x2::event::emit<BurnRequestCreated>(v0);
    }

    public(friend) fun emit_chain_added(arg0: u64) {
        let v0 = ChainAdded{pos0: arg0};
        0x2::event::emit<ChainAdded>(v0);
    }

    public(friend) fun emit_chain_removed(arg0: u64) {
        let v0 = ChainRemoved{pos0: arg0};
        0x2::event::emit<ChainRemoved>(v0);
    }

    public(friend) fun emit_expected_pcrs_set(arg0: vector<u8>, arg1: vector<u8>) {
        let v0 = ExpectedPcrsSet{
            pcr0 : arg0,
            pcr2 : arg1,
        };
        0x2::event::emit<ExpectedPcrsSet>(v0);
    }

    public(friend) fun emit_fees_collected(arg0: u64) {
        let v0 = FeesCollected{pos0: arg0};
        0x2::event::emit<FeesCollected>(v0);
    }

    public(friend) fun emit_lock_completed(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u256, arg6: 0x2::object::ID) {
        let v0 = LockCompleted{
            request_id           : arg0,
            target_chain         : arg1,
            foreign_token        : arg2,
            recipient_address    : arg3,
            lock_amount          : arg4,
            foreign_amount       : arg5,
            signature_request_id : arg6,
        };
        0x2::event::emit<LockCompleted>(v0);
    }

    public(friend) fun emit_lock_fee_set(arg0: u64) {
        let v0 = LockFeeSet{pos0: arg0};
        0x2::event::emit<LockFeeSet>(v0);
    }

    public(friend) fun emit_lock_request_cancelled(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = LockRequestCancelled{
            request_id   : arg0,
            target_chain : arg1,
            lock_amount  : arg2,
        };
        0x2::event::emit<LockRequestCancelled>(v0);
    }

    public(friend) fun emit_lock_request_created(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u256) {
        let v0 = LockRequestCreated{
            request_id        : arg0,
            user              : arg1,
            target_chain      : arg2,
            foreign_token     : arg3,
            recipient_address : arg4,
            lock_amount       : arg5,
            foreign_amount    : arg6,
        };
        0x2::event::emit<LockRequestCreated>(v0);
    }

    public(friend) fun emit_max_lock_set(arg0: u64, arg1: vector<u8>, arg2: u64) {
        let v0 = MaxLockSet{
            target_chain  : arg0,
            foreign_token : arg1,
            max_lock      : arg2,
        };
        0x2::event::emit<MaxLockSet>(v0);
    }

    public(friend) fun emit_max_supply_set(arg0: u64, arg1: vector<u8>, arg2: u64) {
        let v0 = MaxSupplySet{
            source_chain : arg0,
            source_token : arg1,
            max_supply   : arg2,
        };
        0x2::event::emit<MaxSupplySet>(v0);
    }

    public(friend) fun emit_min_votes_set(arg0: u64) {
        let v0 = MinVotesSet{pos0: arg0};
        0x2::event::emit<MinVotesSet>(v0);
    }

    public(friend) fun emit_mint_completed(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>, arg3: u256, arg4: u64, arg5: vector<u8>) {
        let v0 = MintCompleted{
            request_id    : arg0,
            source_chain  : arg1,
            source_token  : arg2,
            source_amount : arg3,
            minted_amount : arg4,
            digest        : arg5,
        };
        0x2::event::emit<MintCompleted>(v0);
    }

    public(friend) fun emit_mint_digest_set(arg0: 0x2::object::ID, arg1: vector<u8>) {
        let v0 = MintDigestSet{
            request_id : arg0,
            digest     : arg1,
        };
        0x2::event::emit<MintDigestSet>(v0);
    }

    public(friend) fun emit_mint_fee_set(arg0: u64) {
        let v0 = MintFeeSet{pos0: arg0};
        0x2::event::emit<MintFeeSet>(v0);
    }

    public(friend) fun emit_mint_request_cancelled(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>, arg3: u256, arg4: 0x2::object::ID) {
        let v0 = MintRequestCancelled{
            request_id           : arg0,
            source_chain         : arg1,
            source_token         : arg2,
            source_amount        : arg3,
            signature_request_id : arg4,
        };
        0x2::event::emit<MintRequestCancelled>(v0);
    }

    public(friend) fun emit_mint_request_created(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: u256) {
        let v0 = MintRequestCreated{
            request_id      : arg0,
            user            : arg1,
            source_chain    : arg2,
            source_token    : arg3,
            source_decimals : arg4,
            source_address  : arg5,
            source_amount   : arg6,
        };
        0x2::event::emit<MintRequestCreated>(v0);
    }

    public(friend) fun emit_out_token_registered(arg0: u64, arg1: vector<u8>, arg2: u8, arg3: u8) {
        let v0 = OutTokenRegistered{
            target_chain     : arg0,
            foreign_token    : arg1,
            foreign_decimals : arg2,
            sui_decimals     : arg3,
        };
        0x2::event::emit<OutTokenRegistered>(v0);
    }

    public(friend) fun emit_paused() {
        let v0 = Paused{dummy_field: false};
        0x2::event::emit<Paused>(v0);
    }

    public(friend) fun emit_presign_fee_set(arg0: u64) {
        let v0 = PresignFeeSet{pos0: arg0};
        0x2::event::emit<PresignFeeSet>(v0);
    }

    public(friend) fun emit_rate_limit_set(arg0: u64, arg1: u64) {
        let v0 = RateLimitSet{
            window_ms : arg0,
            amount    : arg1,
        };
        0x2::event::emit<RateLimitSet>(v0);
    }

    public(friend) fun emit_token_added(arg0: u64, arg1: vector<u8>, arg2: u8, arg3: u8) {
        let v0 = TokenAdded{
            source_chain    : arg0,
            source_token    : arg1,
            source_decimals : arg2,
            decimals        : arg3,
        };
        0x2::event::emit<TokenAdded>(v0);
    }

    public(friend) fun emit_unlock_completed(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: u256, arg5: u64, arg6: vector<u8>) {
        let v0 = UnlockCompleted{
            request_id     : arg0,
            source_chain   : arg1,
            foreign_token  : arg2,
            sender_address : arg3,
            foreign_amount : arg4,
            unlock_amount  : arg5,
            digest         : arg6,
        };
        0x2::event::emit<UnlockCompleted>(v0);
    }

    public(friend) fun emit_unlock_digest_set(arg0: 0x2::object::ID, arg1: vector<u8>) {
        let v0 = UnlockDigestSet{
            request_id : arg0,
            digest     : arg1,
        };
        0x2::event::emit<UnlockDigestSet>(v0);
    }

    public(friend) fun emit_unlock_fee_set(arg0: u64) {
        let v0 = UnlockFeeSet{pos0: arg0};
        0x2::event::emit<UnlockFeeSet>(v0);
    }

    public(friend) fun emit_unlock_request_cancelled(arg0: 0x2::object::ID, arg1: u64, arg2: u256, arg3: 0x2::object::ID) {
        let v0 = UnlockRequestCancelled{
            request_id           : arg0,
            source_chain         : arg1,
            foreign_amount       : arg2,
            signature_request_id : arg3,
        };
        0x2::event::emit<UnlockRequestCancelled>(v0);
    }

    public(friend) fun emit_unlock_request_created(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: u256) {
        let v0 = UnlockRequestCreated{
            request_id     : arg0,
            user           : arg1,
            source_chain   : arg2,
            foreign_token  : arg3,
            sender_address : arg4,
            sui_recipient  : arg5,
            foreign_amount : arg6,
        };
        0x2::event::emit<UnlockRequestCreated>(v0);
    }

    public(friend) fun emit_unpaused() {
        let v0 = Unpaused{dummy_field: false};
        0x2::event::emit<Unpaused>(v0);
    }

    public(friend) fun emit_validator_type_added(arg0: 0x1::type_name::TypeName) {
        let v0 = ValidatorTypeAdded{validator_type: arg0};
        0x2::event::emit<ValidatorTypeAdded>(v0);
    }

    public(friend) fun emit_validator_type_removed(arg0: 0x1::type_name::TypeName) {
        let v0 = ValidatorTypeRemoved{validator_type: arg0};
        0x2::event::emit<ValidatorTypeRemoved>(v0);
    }

    public(friend) fun emit_wallet_added(arg0: u64, arg1: u64) {
        let v0 = WalletAdded{
            chain_id   : arg0,
            wallet_key : arg1,
        };
        0x2::event::emit<WalletAdded>(v0);
    }

    public(friend) fun emit_watchtower_added(arg0: address) {
        let v0 = WatchtowerAdded{pos0: arg0};
        0x2::event::emit<WatchtowerAdded>(v0);
    }

    public(friend) fun emit_watchtower_paused(arg0: address) {
        let v0 = WatchtowerPaused{pos0: arg0};
        0x2::event::emit<WatchtowerPaused>(v0);
    }

    public(friend) fun emit_watchtower_removed(arg0: address) {
        let v0 = WatchtowerRemoved{pos0: arg0};
        0x2::event::emit<WatchtowerRemoved>(v0);
    }

    public(friend) fun mint_params_amount(arg0: &MintParams) : u256 {
        arg0.amount
    }

    public(friend) fun mint_params_chain_id(arg0: &MintParams) : u64 {
        arg0.chain_id
    }

    public(friend) fun mint_params_digest(arg0: &MintParams) : vector<u8> {
        arg0.digest
    }

    public(friend) fun mint_params_signature(arg0: &MintParams) : vector<u8> {
        arg0.signature
    }

    public(friend) fun mint_params_timestamp_ms(arg0: &MintParams) : u64 {
        arg0.timestamp_ms
    }

    public(friend) fun mint_params_to_response(arg0: &MintParams) : MintResponse {
        MintResponse{
            digest     : arg0.digest,
            chain_id   : arg0.chain_id,
            wallet_key : arg0.wallet_key,
            user       : arg0.user,
            token      : arg0.token,
            amount     : arg0.amount,
        }
    }

    public(friend) fun mint_params_token(arg0: &MintParams) : vector<u8> {
        arg0.token
    }

    public(friend) fun mint_params_user(arg0: &MintParams) : vector<u8> {
        arg0.user
    }

    public(friend) fun mint_params_wallet_key(arg0: &MintParams) : u64 {
        arg0.wallet_key
    }

    public fun new_burn_params(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: u256, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>) : BurnParams {
        BurnParams{
            signature                     : arg0,
            timestamp_ms                  : arg1,
            chain_id                      : arg2,
            wallet_key                    : arg3,
            user                          : arg4,
            token                         : arg5,
            amount                        : arg6,
            recipient                     : arg7,
            message                       : arg8,
            message_centralized_signature : arg9,
        }
    }

    public fun new_cancel_mint_response(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: u256, arg7: vector<u8>, arg8: vector<u8>) : CancelMintResponse {
        CancelMintResponse{
            request_id      : arg0,
            wallet_key      : arg1,
            source_chain    : arg2,
            source_token    : arg3,
            source_decimals : arg4,
            source_address  : arg5,
            source_amount   : arg6,
            digest          : arg7,
            message         : arg8,
        }
    }

    public fun new_cancel_unlock_response(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: u256, arg7: vector<u8>, arg8: vector<u8>) : CancelUnlockResponse {
        CancelUnlockResponse{
            request_id       : arg0,
            wallet_key       : arg1,
            source_chain     : arg2,
            foreign_token    : arg3,
            foreign_decimals : arg4,
            sender_address   : arg5,
            foreign_amount   : arg6,
            digest           : arg7,
            message          : arg8,
        }
    }

    public fun new_mint_params(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: u256) : MintParams {
        MintParams{
            signature    : arg0,
            digest       : arg1,
            timestamp_ms : arg2,
            chain_id     : arg3,
            wallet_key   : arg4,
            user         : arg5,
            token        : arg6,
            amount       : arg7,
        }
    }

    public fun new_vote_burn_response(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: u256, arg7: vector<u8>) : VoteBurnResponse {
        VoteBurnResponse{
            request_id          : arg0,
            wallet_key          : arg1,
            source_chain        : arg2,
            source_token        : arg3,
            source_decimals     : arg4,
            destination_address : arg5,
            source_amount       : arg6,
            message             : arg7,
        }
    }

    public fun new_vote_lock_response(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: u256, arg7: vector<u8>) : VoteLockResponse {
        VoteLockResponse{
            request_id        : arg0,
            wallet_key        : arg1,
            target_chain      : arg2,
            foreign_token     : arg3,
            foreign_decimals  : arg4,
            recipient_address : arg5,
            foreign_amount    : arg6,
            message           : arg7,
        }
    }

    public fun new_vote_response(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: u256, arg7: vector<u8>) : VoteResponse {
        VoteResponse{
            request_id      : arg0,
            wallet_key      : arg1,
            source_chain    : arg2,
            source_token    : arg3,
            source_decimals : arg4,
            source_address  : arg5,
            source_amount   : arg6,
            digest          : arg7,
        }
    }

    public fun new_vote_unlock_response(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: address, arg7: u256, arg8: vector<u8>) : VoteUnlockResponse {
        VoteUnlockResponse{
            request_id       : arg0,
            wallet_key       : arg1,
            source_chain     : arg2,
            foreign_token    : arg3,
            foreign_decimals : arg4,
            sender_address   : arg5,
            sui_recipient    : arg6,
            foreign_amount   : arg7,
            digest           : arg8,
        }
    }

    // decompiled from Move bytecode v6
}

