module 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events {
    struct WalletCreated has copy, drop {
        wallet_id: 0x2::object::ID,
        creator: address,
        signers: vector<address>,
        threshold: u64,
        admin_threshold: u64,
        dwallet_id: 0x2::object::ID,
        dwallet_cap_id: 0x2::object::ID,
    }

    struct DWalletAdded has copy, drop {
        wallet_id: 0x2::object::ID,
        curve: u32,
        dwallet_id: 0x2::object::ID,
        dwallet_cap_id: 0x2::object::ID,
    }

    struct ChainConfigured has copy, drop {
        wallet_id: 0x2::object::ID,
        chain_key: vector<u8>,
        kind: u8,
        enabled: bool,
    }

    struct AddressRecorded has copy, drop {
        wallet_id: 0x2::object::ID,
        chain_key: vector<u8>,
        identity: vector<u8>,
    }

    struct SetupFinalized has copy, drop {
        wallet_id: 0x2::object::ID,
    }

    struct SpendRequestCreated has copy, drop {
        wallet_id: 0x2::object::ID,
        request_id: u64,
        creator: address,
        chain_key: vector<u8>,
        asset: vector<u8>,
        destination: vector<u8>,
        amount: u128,
        verified_intent: bool,
        message_count: u64,
        expires_at_ms: u64,
    }

    struct SpendVoteCast has copy, drop {
        wallet_id: 0x2::object::ID,
        request_id: u64,
        voter: address,
        approve: bool,
        approvals: u64,
        rejections: u64,
    }

    struct SpendThresholdReached has copy, drop {
        wallet_id: 0x2::object::ID,
        request_id: u64,
        executable_at_ms: u64,
    }

    struct ProposalThresholdReached has copy, drop {
        wallet_id: 0x2::object::ID,
        proposal_id: u64,
        executable_at_ms: u64,
    }

    struct SpendExecuted has copy, drop {
        wallet_id: 0x2::object::ID,
        request_id: u64,
        executor: address,
        sign_ids: vector<0x2::object::ID>,
    }

    struct SpendRejected has copy, drop {
        wallet_id: 0x2::object::ID,
        request_id: u64,
    }

    struct SpendCancelled has copy, drop {
        wallet_id: 0x2::object::ID,
        request_id: u64,
    }

    struct ProposalCreated has copy, drop {
        wallet_id: 0x2::object::ID,
        proposal_id: u64,
        creator: address,
        action: u8,
        chain_key: vector<u8>,
        expires_at_ms: u64,
    }

    struct ProposalVoteCast has copy, drop {
        wallet_id: 0x2::object::ID,
        proposal_id: u64,
        voter: address,
        approve: bool,
        approvals: u64,
        rejections: u64,
    }

    struct ProposalExecuted has copy, drop {
        wallet_id: 0x2::object::ID,
        proposal_id: u64,
        action: u8,
    }

    struct ProposalRejected has copy, drop {
        wallet_id: 0x2::object::ID,
        proposal_id: u64,
    }

    struct WalletPaused has copy, drop {
        wallet_id: 0x2::object::ID,
        by: address,
    }

    struct WalletUnpaused has copy, drop {
        wallet_id: 0x2::object::ID,
    }

    struct SignerAdded has copy, drop {
        wallet_id: 0x2::object::ID,
        signer: address,
    }

    struct SignerRemoved has copy, drop {
        wallet_id: 0x2::object::ID,
        signer: address,
    }

    struct PresignAdded has copy, drop {
        wallet_id: 0x2::object::ID,
        curve: u32,
        signature_algorithm: u32,
        presign_cap_id: 0x2::object::ID,
    }

    struct BalanceDeposited has copy, drop {
        wallet_id: 0x2::object::ID,
        ika_amount: u64,
        sui_amount: u64,
    }

    struct VaultDeposit has copy, drop {
        wallet_id: 0x2::object::ID,
        coin_type: vector<u8>,
        amount: u64,
    }

    struct VaultWithdrawal has copy, drop {
        wallet_id: 0x2::object::ID,
        request_id: u64,
        coin_type: vector<u8>,
        amount: u64,
        destination: address,
    }

    struct AssetLimitsSet has copy, drop {
        wallet_id: 0x2::object::ID,
        chain_key: vector<u8>,
        asset: vector<u8>,
        fast_path_limit: u128,
        per_tx_limit: u128,
        window_limit: u128,
        window_ms: u64,
    }

    struct AssetLimitsRemoved has copy, drop {
        wallet_id: 0x2::object::ID,
        chain_key: vector<u8>,
        asset: vector<u8>,
    }

    struct SpendVetoed has copy, drop {
        wallet_id: 0x2::object::ID,
        request_id: u64,
        vetoer: address,
    }

    struct ProposalVetoed has copy, drop {
        wallet_id: 0x2::object::ID,
        proposal_id: u64,
        vetoer: address,
    }

    struct ProposalCancelled has copy, drop {
        wallet_id: 0x2::object::ID,
        proposal_id: u64,
    }

    public(friend) fun address_recorded(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = AddressRecorded{
            wallet_id : arg0,
            chain_key : arg1,
            identity  : arg2,
        };
        0x2::event::emit<AddressRecorded>(v0);
    }

    public(friend) fun asset_limits_removed(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = AssetLimitsRemoved{
            wallet_id : arg0,
            chain_key : arg1,
            asset     : arg2,
        };
        0x2::event::emit<AssetLimitsRemoved>(v0);
    }

    public(friend) fun asset_limits_set(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u8>, arg3: u128, arg4: u128, arg5: u128, arg6: u64) {
        let v0 = AssetLimitsSet{
            wallet_id       : arg0,
            chain_key       : arg1,
            asset           : arg2,
            fast_path_limit : arg3,
            per_tx_limit    : arg4,
            window_limit    : arg5,
            window_ms       : arg6,
        };
        0x2::event::emit<AssetLimitsSet>(v0);
    }

    public(friend) fun balance_deposited(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = BalanceDeposited{
            wallet_id  : arg0,
            ika_amount : arg1,
            sui_amount : arg2,
        };
        0x2::event::emit<BalanceDeposited>(v0);
    }

    public(friend) fun chain_configured(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u8, arg3: bool) {
        let v0 = ChainConfigured{
            wallet_id : arg0,
            chain_key : arg1,
            kind      : arg2,
            enabled   : arg3,
        };
        0x2::event::emit<ChainConfigured>(v0);
    }

    public(friend) fun dwallet_added(arg0: 0x2::object::ID, arg1: u32, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = DWalletAdded{
            wallet_id      : arg0,
            curve          : arg1,
            dwallet_id     : arg2,
            dwallet_cap_id : arg3,
        };
        0x2::event::emit<DWalletAdded>(v0);
    }

    public(friend) fun presign_added(arg0: 0x2::object::ID, arg1: u32, arg2: u32, arg3: 0x2::object::ID) {
        let v0 = PresignAdded{
            wallet_id           : arg0,
            curve               : arg1,
            signature_algorithm : arg2,
            presign_cap_id      : arg3,
        };
        0x2::event::emit<PresignAdded>(v0);
    }

    public(friend) fun proposal_cancelled(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ProposalCancelled{
            wallet_id   : arg0,
            proposal_id : arg1,
        };
        0x2::event::emit<ProposalCancelled>(v0);
    }

    public(friend) fun proposal_created(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u8, arg4: vector<u8>, arg5: u64) {
        let v0 = ProposalCreated{
            wallet_id     : arg0,
            proposal_id   : arg1,
            creator       : arg2,
            action        : arg3,
            chain_key     : arg4,
            expires_at_ms : arg5,
        };
        0x2::event::emit<ProposalCreated>(v0);
    }

    public(friend) fun proposal_executed(arg0: 0x2::object::ID, arg1: u64, arg2: u8) {
        let v0 = ProposalExecuted{
            wallet_id   : arg0,
            proposal_id : arg1,
            action      : arg2,
        };
        0x2::event::emit<ProposalExecuted>(v0);
    }

    public(friend) fun proposal_rejected(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ProposalRejected{
            wallet_id   : arg0,
            proposal_id : arg1,
        };
        0x2::event::emit<ProposalRejected>(v0);
    }

    public(friend) fun proposal_threshold_reached(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = ProposalThresholdReached{
            wallet_id        : arg0,
            proposal_id      : arg1,
            executable_at_ms : arg2,
        };
        0x2::event::emit<ProposalThresholdReached>(v0);
    }

    public(friend) fun proposal_vetoed(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = ProposalVetoed{
            wallet_id   : arg0,
            proposal_id : arg1,
            vetoer      : arg2,
        };
        0x2::event::emit<ProposalVetoed>(v0);
    }

    public(friend) fun proposal_vote_cast(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: bool, arg4: u64, arg5: u64) {
        let v0 = ProposalVoteCast{
            wallet_id   : arg0,
            proposal_id : arg1,
            voter       : arg2,
            approve     : arg3,
            approvals   : arg4,
            rejections  : arg5,
        };
        0x2::event::emit<ProposalVoteCast>(v0);
    }

    public(friend) fun setup_finalized(arg0: 0x2::object::ID) {
        let v0 = SetupFinalized{wallet_id: arg0};
        0x2::event::emit<SetupFinalized>(v0);
    }

    public(friend) fun signer_added(arg0: 0x2::object::ID, arg1: address) {
        let v0 = SignerAdded{
            wallet_id : arg0,
            signer    : arg1,
        };
        0x2::event::emit<SignerAdded>(v0);
    }

    public(friend) fun signer_removed(arg0: 0x2::object::ID, arg1: address) {
        let v0 = SignerRemoved{
            wallet_id : arg0,
            signer    : arg1,
        };
        0x2::event::emit<SignerRemoved>(v0);
    }

    public(friend) fun spend_cancelled(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = SpendCancelled{
            wallet_id  : arg0,
            request_id : arg1,
        };
        0x2::event::emit<SpendCancelled>(v0);
    }

    public(friend) fun spend_executed(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: vector<0x2::object::ID>) {
        let v0 = SpendExecuted{
            wallet_id  : arg0,
            request_id : arg1,
            executor   : arg2,
            sign_ids   : arg3,
        };
        0x2::event::emit<SpendExecuted>(v0);
    }

    public(friend) fun spend_rejected(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = SpendRejected{
            wallet_id  : arg0,
            request_id : arg1,
        };
        0x2::event::emit<SpendRejected>(v0);
    }

    public(friend) fun spend_request_created(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u128, arg7: bool, arg8: u64, arg9: u64) {
        let v0 = SpendRequestCreated{
            wallet_id       : arg0,
            request_id      : arg1,
            creator         : arg2,
            chain_key       : arg3,
            asset           : arg4,
            destination     : arg5,
            amount          : arg6,
            verified_intent : arg7,
            message_count   : arg8,
            expires_at_ms   : arg9,
        };
        0x2::event::emit<SpendRequestCreated>(v0);
    }

    public(friend) fun spend_threshold_reached(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = SpendThresholdReached{
            wallet_id        : arg0,
            request_id       : arg1,
            executable_at_ms : arg2,
        };
        0x2::event::emit<SpendThresholdReached>(v0);
    }

    public(friend) fun spend_vetoed(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = SpendVetoed{
            wallet_id  : arg0,
            request_id : arg1,
            vetoer     : arg2,
        };
        0x2::event::emit<SpendVetoed>(v0);
    }

    public(friend) fun spend_vote_cast(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: bool, arg4: u64, arg5: u64) {
        let v0 = SpendVoteCast{
            wallet_id  : arg0,
            request_id : arg1,
            voter      : arg2,
            approve    : arg3,
            approvals  : arg4,
            rejections : arg5,
        };
        0x2::event::emit<SpendVoteCast>(v0);
    }

    public(friend) fun vault_deposit(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64) {
        let v0 = VaultDeposit{
            wallet_id : arg0,
            coin_type : arg1,
            amount    : arg2,
        };
        0x2::event::emit<VaultDeposit>(v0);
    }

    public(friend) fun vault_withdrawal(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: address) {
        let v0 = VaultWithdrawal{
            wallet_id   : arg0,
            request_id  : arg1,
            coin_type   : arg2,
            amount      : arg3,
            destination : arg4,
        };
        0x2::event::emit<VaultWithdrawal>(v0);
    }

    public(friend) fun wallet_created(arg0: 0x2::object::ID, arg1: address, arg2: vector<address>, arg3: u64, arg4: u64, arg5: 0x2::object::ID, arg6: 0x2::object::ID) {
        let v0 = WalletCreated{
            wallet_id       : arg0,
            creator         : arg1,
            signers         : arg2,
            threshold       : arg3,
            admin_threshold : arg4,
            dwallet_id      : arg5,
            dwallet_cap_id  : arg6,
        };
        0x2::event::emit<WalletCreated>(v0);
    }

    public(friend) fun wallet_paused(arg0: 0x2::object::ID, arg1: address) {
        let v0 = WalletPaused{
            wallet_id : arg0,
            by        : arg1,
        };
        0x2::event::emit<WalletPaused>(v0);
    }

    public(friend) fun wallet_unpaused(arg0: 0x2::object::ID) {
        let v0 = WalletUnpaused{wallet_id: arg0};
        0x2::event::emit<WalletUnpaused>(v0);
    }

    // decompiled from Move bytecode v7
}

