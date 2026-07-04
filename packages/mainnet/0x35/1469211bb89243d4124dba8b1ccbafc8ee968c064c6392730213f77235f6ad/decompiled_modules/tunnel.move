module 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel {
    struct PartyConfig has copy, drop, store {
        address: address,
        public_key: vector<u8>,
        signature_type: u8,
    }

    struct StateCommitment has copy, drop, store {
        state_hash: vector<u8>,
        nonce: u64,
        timestamp: u64,
        party_a_balance: u64,
        party_b_balance: u64,
    }

    struct Tunnel<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        party_a: PartyConfig,
        party_b: PartyConfig,
        balance: 0x2::balance::Balance<T0>,
        party_a_deposit: u64,
        party_b_deposit: u64,
        status: u8,
        state: StateCommitment,
        created_at: u64,
        last_activity: u64,
        timeout_ms: u64,
        penalty_amount: u64,
        dispute_raiser: 0x1::option::Option<address>,
        last_disputed_nonce: u64,
    }

    struct SettlementData has copy, drop {
        tunnel_id: 0x2::object::ID,
        party_a_balance: u64,
        party_b_balance: u64,
        final_nonce: u64,
        timestamp: u64,
    }

    struct SettlementWithRootData has copy, drop {
        tunnel_id: 0x2::object::ID,
        party_a_balance: u64,
        party_b_balance: u64,
        final_nonce: u64,
        timestamp: u64,
        transcript_root: vector<u8>,
    }

    struct StateUpdateData has copy, drop {
        tunnel_id: 0x2::object::ID,
        state_hash: vector<u8>,
        nonce: u64,
        timestamp: u64,
        party_a_balance: u64,
        party_b_balance: u64,
    }

    struct TunnelCreated has copy, drop {
        tunnel_id: 0x2::object::ID,
        party_a: address,
        party_b: address,
        created_at: u64,
    }

    struct TunnelDeposit has copy, drop {
        tunnel_id: 0x2::object::ID,
        party: address,
        amount: u64,
        total_balance: u64,
    }

    struct TunnelActivated has copy, drop {
        tunnel_id: 0x2::object::ID,
        party_a_deposit: u64,
        party_b_deposit: u64,
        activated_at: u64,
    }

    struct StateUpdated has copy, drop {
        tunnel_id: 0x2::object::ID,
        state_hash: vector<u8>,
        nonce: u64,
        timestamp: u64,
    }

    struct TunnelClosed has copy, drop {
        tunnel_id: 0x2::object::ID,
        party_a_balance: u64,
        party_b_balance: u64,
        final_nonce: u64,
        closed_at: u64,
    }

    struct TunnelClosedWithRoot has copy, drop {
        tunnel_id: 0x2::object::ID,
        party_a_balance: u64,
        party_b_balance: u64,
        final_nonce: u64,
        transcript_root: vector<u8>,
        closed_at: u64,
    }

    struct DisputeRaised has copy, drop {
        tunnel_id: 0x2::object::ID,
        raised_by: address,
        state_hash: vector<u8>,
        nonce: u64,
        timestamp: u64,
    }

    struct DisputeResolved has copy, drop {
        tunnel_id: 0x2::object::ID,
        state_hash: vector<u8>,
        nonce: u64,
        party_a_balance: u64,
        party_b_balance: u64,
        timestamp: u64,
    }

    struct TunnelWithdrawal has copy, drop {
        tunnel_id: 0x2::object::ID,
        party: address,
        amount: u64,
        timestamp: u64,
    }

    struct TunnelDestroyed has copy, drop {
        tunnel_id: 0x2::object::ID,
        destroyed_by: address,
        timestamp: u64,
    }

    struct TunnelTimeoutExtended has copy, drop {
        tunnel_id: 0x2::object::ID,
        extended_by: address,
        additional_ms: u64,
        new_timeout_ms: u64,
        timestamp: u64,
    }

    struct HTLCLocked has copy, drop {
        tunnel_id: 0x2::object::ID,
        payment_hash: vector<u8>,
        amount: u64,
        sender: address,
        receiver: address,
        expiry_ms: u64,
    }

    struct HTLCClaimedInTunnel has copy, drop {
        tunnel_id: 0x2::object::ID,
        payment_hash: vector<u8>,
        amount: u64,
        claimed_by: address,
    }

    struct HTLCExpiredInTunnel has copy, drop {
        tunnel_id: 0x2::object::ID,
        payment_hash: vector<u8>,
        amount: u64,
        returned_to: address,
    }

    struct RefereeAssigned has copy, drop {
        tunnel_id: 0x2::object::ID,
        referee: address,
    }

    struct DisputeResolvedByReferee has copy, drop {
        tunnel_id: 0x2::object::ID,
        referee: address,
        party_a_balance: u64,
        party_b_balance: u64,
        timestamp: u64,
    }

    struct DisputeResolvedByVerifiedProof has copy, drop {
        tunnel_id: 0x2::object::ID,
        party_a_balance: u64,
        party_b_balance: u64,
        timestamp: u64,
    }

    struct HTLCKey has copy, drop, store {
        payment_hash: vector<u8>,
    }

    struct HTLCPartyCounterKey has copy, drop, store {
        party: address,
    }

    struct RefereeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct HTLCPartyCounter has drop, store {
        count: u64,
        total_locked: u64,
    }

    struct TunnelHTLC<phantom T0> has store {
        payment_hash: vector<u8>,
        amount: u64,
        sender: address,
        receiver: address,
        expiry_ms: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    struct HTLCLockData has copy, drop {
        tunnel_id: 0x2::object::ID,
        payment_hash: vector<u8>,
        amount: u64,
        sender: address,
        receiver: address,
        expiry_ms: u64,
    }

    public fun id<T0>(arg0: &Tunnel<T0>) : 0x2::object::ID {
        0x2::object::id<Tunnel<T0>>(arg0)
    }

    public fun agree_to_dispute<T0>(arg0: &mut Tunnel<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906841076357529627);
        assert!(arg0.status == 3, 13906841080652890145);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::option::is_some<address>(&arg0.dispute_raiser), 13906841097830662145);
        assert!(v0 != *0x1::option::borrow<address>(&arg0.dispute_raiser), 13906841106420596737);
        assert!(v0 == arg0.party_a.address || v0 == arg0.party_b.address, 13906841119305498625);
        let v1 = arg0.state.party_a_balance;
        let v2 = arg0.state.party_b_balance;
        assert_balance_split(v1, v2, 0x2::balance::value<T0>(&arg0.balance));
        let v3 = 0x2::clock::timestamp_ms(arg1);
        arg0.status = 2;
        arg0.last_activity = v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg2), arg0.party_a.address);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v2), arg2), arg0.party_b.address);
        let v4 = TunnelClosed{
            tunnel_id       : 0x2::object::id<Tunnel<T0>>(arg0),
            party_a_balance : v1,
            party_b_balance : v2,
            final_nonce     : arg0.state.nonce,
            closed_at       : v3,
        };
        0x2::event::emit<TunnelClosed>(v4);
    }

    fun assert_balance_split(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 <= arg2, 13906838138601472051);
        assert!(arg1 == arg2 - arg0, 13906838142896439347);
    }

    public fun assert_current_version<T0>(arg0: &Tunnel<T0>) {
        assert!(is_current_version<T0>(arg0), 13906845710627242011);
    }

    fun build_tunnel<T0>(arg0: address, arg1: vector<u8>, arg2: u8, arg3: address, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Tunnel<T0> {
        validate_create_params(arg0, arg3, arg2, arg5, &arg1, &arg4);
        assert!(arg6 > 0, 13906836558052720679);
        assert!(arg6 <= 2592000000, 13906836570939195455);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = 0x2::object::new(arg9);
        let v2 = PartyConfig{
            address        : arg0,
            public_key     : arg1,
            signature_type : arg2,
        };
        let v3 = PartyConfig{
            address        : arg3,
            public_key     : arg4,
            signature_type : arg5,
        };
        let v4 = StateCommitment{
            state_hash      : b"",
            nonce           : 0,
            timestamp       : v0,
            party_a_balance : 0,
            party_b_balance : 0,
        };
        let v5 = Tunnel<T0>{
            id                  : v1,
            version             : 1,
            party_a             : v2,
            party_b             : v3,
            balance             : 0x2::balance::zero<T0>(),
            party_a_deposit     : 0,
            party_b_deposit     : 0,
            status              : 0,
            state               : v4,
            created_at          : v0,
            last_activity       : v0,
            timeout_ms          : arg6,
            penalty_amount      : arg7,
            dispute_raiser      : 0x1::option::none<address>(),
            last_disputed_nonce : 0,
        };
        let v6 = TunnelCreated{
            tunnel_id  : 0x2::object::uid_to_inner(&v1),
            party_a    : arg0,
            party_b    : arg3,
            created_at : v0,
        };
        0x2::event::emit<TunnelCreated>(v6);
        v5
    }

    public fun can_claim_timeout<T0>(arg0: &Tunnel<T0>, arg1: &0x2::clock::Clock) : bool {
        if (arg0.timeout_ms == 0) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) >= arg0.last_activity + arg0.timeout_ms
    }

    public fun can_extend_timeout<T0>(arg0: &Tunnel<T0>) : bool {
        arg0.status == 1
    }

    public fun can_extend_timeout_by<T0>(arg0: &Tunnel<T0>, arg1: u64) : bool {
        if (can_extend_timeout<T0>(arg0)) {
            if (arg1 > 0) {
                if (arg1 <= 604800000) {
                    arg0.timeout_ms <= 2592000000 - arg1
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun claim_htlc_in_tunnel<T0>(arg0: &mut Tunnel<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906842180164124699);
        assert!(arg0.status != 4, 13906842184457519107);
        let v0 = HTLCKey{payment_hash: arg1};
        assert!(0x2::dynamic_field::exists<HTLCKey>(&arg0.id, v0), 13906842197342814217);
        let v1 = 0x2::dynamic_field::remove<HTLCKey, TunnelHTLC<T0>>(&mut arg0.id, v0);
        assert!(0x2::tx_context::sender(arg4) == v1.receiver, 13906842218817126401);
        assert!(0x2::hash::blake2b256(&arg2) == v1.payment_hash, 13906842235999617065);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v2 < v1.expiry_ms, 13906842253179617323);
        let v3 = v1.amount;
        let v4 = v1.receiver;
        let TunnelHTLC {
            payment_hash : _,
            amount       : _,
            sender       : _,
            receiver     : _,
            expiry_ms    : _,
            balance      : v10,
        } = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v10, arg4), v4);
        update_party_htlc_counter<T0>(arg0, v1.sender, false, v3);
        arg0.last_activity = v2;
        let v11 = HTLCClaimedInTunnel{
            tunnel_id    : 0x2::object::id<Tunnel<T0>>(arg0),
            payment_hash : arg1,
            amount       : v3,
            claimed_by   : v4,
        };
        0x2::event::emit<HTLCClaimedInTunnel>(v11);
    }

    public fun close_cooperative<T0>(arg0: &mut Tunnel<T0>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906838727010418715);
        assert!(arg0.status == 1 || arg0.status == 0, 13906838739894927381);
        assert_balance_split(arg1, arg2, 0x2::balance::value<T0>(&arg0.balance));
        assert!(!0x1::vector::is_empty<u8>(&arg3) && !0x1::vector::is_empty<u8>(&arg4), 13906838778549239823);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::object::id<Tunnel<T0>>(arg0);
        let v2 = arg0.state.nonce + 1;
        assert!(arg5 <= v0, 13906838808613355525);
        assert!(arg5 >= arg0.created_at, 13906838812908322821);
        let v3 = SettlementData{
            tunnel_id       : v1,
            party_a_balance : arg1,
            party_b_balance : arg2,
            final_nonce     : v2,
            timestamp       : arg5,
        };
        let v4 = serialize_settlement(&v3);
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::verify(arg0.party_a.signature_type, &arg0.party_a.public_key, &v4, &arg3), 13906838907398258703);
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::verify(arg0.party_b.signature_type, &arg0.party_b.public_key, &v4, &arg4), 13906838950347931663);
        arg0.status = 2;
        arg0.last_activity = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg7), arg0.party_a.address);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg7), arg0.party_b.address);
        let v5 = TunnelClosed{
            tunnel_id       : v1,
            party_a_balance : arg1,
            party_b_balance : arg2,
            final_nonce     : v2,
            closed_at       : v0,
        };
        0x2::event::emit<TunnelClosed>(v5);
    }

    public fun close_cooperative_and_transfer<T0>(arg0: &mut Tunnel<T0>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        close_cooperative<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun close_cooperative_with_root<T0>(arg0: &mut Tunnel<T0>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906839122147409947);
        assert!(arg0.status == 1 || arg0.status == 0, 13906839135031918613);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 13906839143622508575);
        assert_balance_split(arg1, arg2, 0x2::balance::value<T0>(&arg0.balance));
        assert!(!0x1::vector::is_empty<u8>(&arg3) && !0x1::vector::is_empty<u8>(&arg4), 13906839160801329167);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x2::object::id<Tunnel<T0>>(arg0);
        let v2 = arg0.state.nonce + 1;
        assert!(arg5 <= v0, 13906839182275510277);
        assert!(arg5 >= arg0.created_at, 13906839186570477573);
        let v3 = SettlementWithRootData{
            tunnel_id       : v1,
            party_a_balance : arg1,
            party_b_balance : arg2,
            final_nonce     : v2,
            timestamp       : arg5,
            transcript_root : arg6,
        };
        let v4 = serialize_settlement_with_root(&v3);
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::verify(arg0.party_a.signature_type, &arg0.party_a.public_key, &v4, &arg3), 13906839268175511567);
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::verify(arg0.party_b.signature_type, &arg0.party_b.public_key, &v4, &arg4), 13906839306830217231);
        arg0.status = 2;
        arg0.last_activity = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg8), arg0.party_a.address);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg8), arg0.party_b.address);
        let v5 = TunnelClosedWithRoot{
            tunnel_id       : v1,
            party_a_balance : arg1,
            party_b_balance : arg2,
            final_nonce     : v2,
            transcript_root : v3.transcript_root,
            closed_at       : v0,
        };
        0x2::event::emit<TunnelClosedWithRoot>(v5);
    }

    public fun create<T0>(arg0: address, arg1: vector<u8>, arg2: u8, arg3: address, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Tunnel<T0> {
        build_tunnel<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun create_and_fund<T0>(arg0: address, arg1: vector<u8>, arg2: u8, arg3: address, arg4: vector<u8>, arg5: u8, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        create_and_fund_with_id<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun create_and_fund_with_id<T0>(arg0: address, arg1: vector<u8>, arg2: u8, arg3: address, arg4: vector<u8>, arg5: u8, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = build_tunnel<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg8, arg9, arg10, arg11);
        let v1 = &mut v0;
        deposit_internal<T0>(v1, arg6, true, arg10);
        let v2 = &mut v0;
        deposit_internal<T0>(v2, arg7, false, arg10);
        0x2::transfer::share_object<Tunnel<T0>>(v0);
        0x2::object::id<Tunnel<T0>>(&v0)
    }

    public fun create_and_share<T0>(arg0: address, arg1: vector<u8>, arg2: u8, arg3: address, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Tunnel<T0>>(build_tunnel<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public fun create_state_hash(arg0: &vector<u8>) : vector<u8> {
        0x2::hash::blake2b256(arg0)
    }

    public fun created_at<T0>(arg0: &Tunnel<T0>) : u64 {
        arg0.created_at
    }

    public fun current_version() : u64 {
        1
    }

    public fun deposit<T0>(arg0: &mut Tunnel<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (v0 == arg0.party_a.address) {
            true
        } else {
            assert!(v0 == arg0.party_b.address, 13906837700511531009);
            false
        };
        deposit_internal<T0>(arg0, arg1, v1, arg2);
    }

    fun deposit_internal<T0>(arg0: &mut Tunnel<T0>, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 13906837846542123035);
        assert!(arg0.status == 0, 13906837868016566293);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 1, 13906837880903565365);
        if (arg2) {
            arg0.party_a_deposit = arg0.party_a_deposit + v0;
        } else {
            arg0.party_b_deposit = arg0.party_b_deposit + v0;
        };
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.last_activity = 0x2::clock::timestamp_ms(arg3);
        let v1 = if (arg2) {
            arg0.party_a.address
        } else {
            arg0.party_b.address
        };
        let v2 = TunnelDeposit{
            tunnel_id     : 0x2::object::id<Tunnel<T0>>(arg0),
            party         : v1,
            amount        : v0,
            total_balance : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<TunnelDeposit>(v2);
        maybe_activate<T0>(arg0, arg3);
    }

    public fun deposit_party_a<T0>(arg0: &mut Tunnel<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.party_a.address, 13906837752051138561);
        deposit_internal<T0>(arg0, arg1, true, arg2);
    }

    public fun deposit_party_b<T0>(arg0: &mut Tunnel<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.party_b.address, 13906837799295778817);
        deposit_internal<T0>(arg0, arg1, false, arg2);
    }

    public fun destroy_tunnel<T0>(arg0: &mut Tunnel<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906844100014506011);
        assert!(arg0.status == 2, 13906844104307900419);
        assert!(0x2::balance::value<T0>(&arg0.balance) == 0, 13906844108605882417);
        assert!(party_htlc_locked_internal<T0>(arg0, arg0.party_a.address) == 0 && party_htlc_locked_internal<T0>(arg0, arg0.party_b.address) == 0, 13906844125785620527);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.party_a.address || v0 == arg0.party_b.address, 13906844151552409601);
        arg0.status = 4;
        let v1 = TunnelDestroyed{
            tunnel_id    : 0x2::object::id<Tunnel<T0>>(arg0),
            destroyed_by : v0,
            timestamp    : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<TunnelDestroyed>(v1);
    }

    public fun dispute_raiser<T0>(arg0: &Tunnel<T0>) : 0x1::option::Option<address> {
        arg0.dispute_raiser
    }

    entry fun entry_agree_to_dispute<T0>(arg0: &mut Tunnel<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        agree_to_dispute<T0>(arg0, arg1, arg2);
    }

    entry fun entry_claim_htlc<T0>(arg0: &mut Tunnel<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        claim_htlc_in_tunnel<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun entry_close_cooperative<T0>(arg0: &mut Tunnel<T0>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        close_cooperative_and_transfer<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    entry fun entry_close_cooperative_with_root<T0>(arg0: &mut Tunnel<T0>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        close_cooperative_with_root<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun entry_create_and_share<T0>(arg0: address, arg1: vector<u8>, arg2: u8, arg3: address, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        create_and_share<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    entry fun entry_deposit<T0>(arg0: &mut Tunnel<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        deposit<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun entry_expire_htlc<T0>(arg0: &mut Tunnel<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        expire_htlc_in_tunnel<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun entry_extend_timeout<T0>(arg0: &mut Tunnel<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        extend_timeout<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun entry_force_close<T0>(arg0: &mut Tunnel<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        force_close_after_timeout<T0>(arg0, arg1, arg2);
    }

    entry fun entry_lock_htlc<T0>(arg0: &mut Tunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: address, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        lock_htlc<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    entry fun entry_raise_dispute<T0>(arg0: &mut Tunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        raise_dispute<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun entry_raise_dispute_current_state<T0>(arg0: &mut Tunnel<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        raise_dispute_current_state<T0>(arg0, arg1, arg2);
    }

    entry fun entry_resolve_dispute<T0>(arg0: &mut Tunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        resolve_dispute<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun entry_resolve_dispute_external<T0>(arg0: &mut Tunnel<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        resolve_dispute_external<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun entry_set_referee<T0>(arg0: &mut Tunnel<T0>, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        set_referee_cosigned<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun entry_update_state<T0>(arg0: &mut Tunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        update_state<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun expire_htlc_in_tunnel<T0>(arg0: &mut Tunnel<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906842386322554907);
        assert!(arg0.status != 4, 13906842390615949315);
        let v0 = HTLCKey{payment_hash: arg1};
        assert!(0x2::dynamic_field::exists<HTLCKey>(&arg0.id, v0), 13906842403501244425);
        let v1 = 0x2::dynamic_field::remove<HTLCKey, TunnelHTLC<T0>>(&mut arg0.id, v0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v2 >= v1.expiry_ms, 13906842429273407533);
        assert!(0x2::tx_context::sender(arg3) == v1.sender, 13906842442155425793);
        let v3 = v1.amount;
        let v4 = v1.sender;
        let TunnelHTLC {
            payment_hash : _,
            amount       : _,
            sender       : _,
            receiver     : _,
            expiry_ms    : _,
            balance      : v10,
        } = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v10, arg3), v4);
        update_party_htlc_counter<T0>(arg0, v4, false, v3);
        arg0.last_activity = v2;
        let v11 = HTLCExpiredInTunnel{
            tunnel_id    : 0x2::object::id<Tunnel<T0>>(arg0),
            payment_hash : arg1,
            amount       : v3,
            returned_to  : v4,
        };
        0x2::event::emit<HTLCExpiredInTunnel>(v11);
    }

    public fun extend_timeout<T0>(arg0: &mut Tunnel<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906841407070011419);
        assert!(arg0.status != 3, 13906841419956748343);
        assert!(can_extend_timeout<T0>(arg0), 13906841424248307715);
        assert!(arg1 > 0, 13906841428543406085);
        assert!(arg1 <= 604800000, 13906841441431978045);
        assert!(arg0.timeout_ms <= 2592000000 - arg1, 13906841454317011007);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.party_a.address || v0 == arg0.party_b.address, 13906841480082751489);
        arg0.timeout_ms = arg0.timeout_ms + arg1;
        arg0.last_activity = 0x2::clock::timestamp_ms(arg2);
        let v1 = TunnelTimeoutExtended{
            tunnel_id      : 0x2::object::id<Tunnel<T0>>(arg0),
            extended_by    : v0,
            additional_ms  : arg1,
            new_timeout_ms : arg0.timeout_ms,
            timestamp      : arg0.last_activity,
        };
        0x2::event::emit<TunnelTimeoutExtended>(v1);
    }

    public fun force_close_after_timeout<T0>(arg0: &mut Tunnel<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906840728465178651);
        assert!(arg0.status == 3, 13906840732760539169);
        assert!(arg0.timeout_ms > 0, 13906840737054064651);
        assert!(0x1::option::is_some<address>(&arg0.dispute_raiser), 13906840754233278465);
        assert!(0x2::tx_context::sender(arg2) == *0x1::option::borrow<address>(&arg0.dispute_raiser), 13906840758528245761);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.state.timestamp + arg0.timeout_ms, 13906840784300277795);
        let v1 = arg0.state.party_a_balance;
        let v2 = v1;
        let v3 = arg0.state.party_b_balance;
        let v4 = v3;
        if (arg0.penalty_amount > 0) {
            if (*0x1::option::borrow<address>(&arg0.dispute_raiser) == arg0.party_a.address) {
                let v5 = 0x1::u64::min(arg0.penalty_amount, v3);
                v4 = v3 - v5;
                v2 = v1 + v5;
            } else {
                let v6 = 0x1::u64::min(arg0.penalty_amount, v1);
                v2 = v1 - v6;
                v4 = v3 + v6;
            };
        };
        assert_balance_split(v2, v4, 0x2::balance::value<T0>(&arg0.balance));
        arg0.status = 2;
        arg0.last_activity = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v2), arg2), arg0.party_a.address);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v4), arg2), arg0.party_b.address);
        let v7 = TunnelClosed{
            tunnel_id       : 0x2::object::id<Tunnel<T0>>(arg0),
            party_a_balance : v2,
            party_b_balance : v4,
            final_nonce     : arg0.state.nonce,
            closed_at       : v0,
        };
        0x2::event::emit<TunnelClosed>(v7);
    }

    public fun get_referee<T0>(arg0: &Tunnel<T0>) : address {
        let v0 = RefereeKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RefereeKey>(&arg0.id, v0), 13906846359166124041);
        let v1 = RefereeKey{dummy_field: false};
        *0x2::dynamic_field::borrow<RefereeKey, address>(&arg0.id, v1)
    }

    public fun has_htlc<T0>(arg0: &Tunnel<T0>, arg1: vector<u8>) : bool {
        let v0 = HTLCKey{payment_hash: arg1};
        0x2::dynamic_field::exists<HTLCKey>(&arg0.id, v0)
    }

    public fun has_referee<T0>(arg0: &Tunnel<T0>) : bool {
        let v0 = RefereeKey{dummy_field: false};
        0x2::dynamic_field::exists<RefereeKey>(&arg0.id, v0)
    }

    public fun is_active<T0>(arg0: &Tunnel<T0>) : bool {
        arg0.status == 1
    }

    public fun is_closed<T0>(arg0: &Tunnel<T0>) : bool {
        arg0.status == 2
    }

    public fun is_current_version<T0>(arg0: &Tunnel<T0>) : bool {
        arg0.version == 1
    }

    public fun is_disputed<T0>(arg0: &Tunnel<T0>) : bool {
        arg0.status == 3
    }

    public fun last_activity<T0>(arg0: &Tunnel<T0>) : u64 {
        arg0.last_activity
    }

    public fun lock_htlc<T0>(arg0: &mut Tunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: address, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906841638998245403);
        assert!(arg0.status == 1, 13906841643291639811);
        assert!(arg2 > 0, 13906841647586738181);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906841651882229773);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg4 > v0, 13906841664768835623);
        let v1 = 0x2::tx_context::sender(arg7);
        let (v2, v3) = if (v1 == arg0.party_a.address) {
            (true, &arg0.party_b)
        } else {
            assert!(v1 == arg0.party_b.address, 13906841699126083585);
            (false, &arg0.party_a)
        };
        let v4 = HTLCLockData{
            tunnel_id    : 0x2::object::id<Tunnel<T0>>(arg0),
            payment_hash : arg1,
            amount       : arg2,
            sender       : v1,
            receiver     : arg3,
            expiry_ms    : arg4,
        };
        let v5 = serialize_htlc_lock(&v4);
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::verify(v3.signature_type, &v3.public_key, &v5, &arg5), 13906841789321314319);
        lock_htlc_internal<T0>(arg0, arg1, arg2, v1, arg3, arg4, v2, v0);
    }

    fun lock_htlc_internal<T0>(arg0: &mut Tunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: bool, arg7: u64) {
        let v0 = if (arg6) {
            arg0.state.party_a_balance
        } else {
            arg0.state.party_b_balance
        };
        assert!(arg2 <= v0, 13906841948237332529);
        let v1 = HTLCKey{payment_hash: arg1};
        assert!(!0x2::dynamic_field::exists<HTLCKey>(&arg0.id, v1), 13906841965414449159);
        let v2 = TunnelHTLC<T0>{
            payment_hash : arg1,
            amount       : arg2,
            sender       : arg3,
            receiver     : arg4,
            expiry_ms    : arg5,
            balance      : 0x2::balance::split<T0>(&mut arg0.balance, arg2),
        };
        0x2::dynamic_field::add<HTLCKey, TunnelHTLC<T0>>(&mut arg0.id, v1, v2);
        update_party_htlc_counter<T0>(arg0, arg3, true, arg2);
        if (arg6) {
            arg0.state.party_a_balance = arg0.state.party_a_balance - arg2;
        } else {
            arg0.state.party_b_balance = arg0.state.party_b_balance - arg2;
        };
        arg0.last_activity = arg7;
        let v3 = HTLCLocked{
            tunnel_id    : 0x2::object::id<Tunnel<T0>>(arg0),
            payment_hash : arg1,
            amount       : arg2,
            sender       : arg3,
            receiver     : arg4,
            expiry_ms    : arg5,
        };
        0x2::event::emit<HTLCLocked>(v3);
    }

    fun maybe_activate<T0>(arg0: &mut Tunnel<T0>, arg1: &0x2::clock::Clock) {
        let v0 = if (arg0.status == 0) {
            if (arg0.party_a_deposit > 0) {
                arg0.party_b_deposit > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            arg0.status = 1;
            arg0.state.party_a_balance = arg0.party_a_deposit;
            arg0.state.party_b_balance = arg0.party_b_deposit;
            let v1 = TunnelActivated{
                tunnel_id       : 0x2::object::id<Tunnel<T0>>(arg0),
                party_a_deposit : arg0.party_a_deposit,
                party_b_deposit : arg0.party_b_deposit,
                activated_at    : 0x2::clock::timestamp_ms(arg1),
            };
            0x2::event::emit<TunnelActivated>(v1);
        };
    }

    public fun migrate<T0>(arg0: &mut Tunnel<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.party_a.address || v0 == arg0.party_b.address, 13906845766460112897);
        assert!(arg0.version < 1, 13906845775054241857);
        arg0.version = 1;
    }

    public fun party_a<T0>(arg0: &Tunnel<T0>) : &PartyConfig {
        &arg0.party_a
    }

    public fun party_a_deposit<T0>(arg0: &Tunnel<T0>) : u64 {
        arg0.party_a_deposit
    }

    public fun party_address(arg0: &PartyConfig) : address {
        arg0.address
    }

    public fun party_b<T0>(arg0: &Tunnel<T0>) : &PartyConfig {
        &arg0.party_b
    }

    public fun party_b_deposit<T0>(arg0: &Tunnel<T0>) : u64 {
        arg0.party_b_deposit
    }

    public fun party_htlc_count<T0>(arg0: &Tunnel<T0>, arg1: address) : u64 {
        let v0 = HTLCPartyCounterKey{party: arg1};
        if (0x2::dynamic_field::exists<HTLCPartyCounterKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<HTLCPartyCounterKey, HTLCPartyCounter>(&arg0.id, v0).count
        } else {
            0
        }
    }

    public fun party_htlc_locked<T0>(arg0: &Tunnel<T0>, arg1: address) : u64 {
        party_htlc_locked_internal<T0>(arg0, arg1)
    }

    fun party_htlc_locked_internal<T0>(arg0: &Tunnel<T0>, arg1: address) : u64 {
        let v0 = HTLCPartyCounterKey{party: arg1};
        if (0x2::dynamic_field::exists<HTLCPartyCounterKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<HTLCPartyCounterKey, HTLCPartyCounter>(&arg0.id, v0).total_locked
        } else {
            0
        }
    }

    public fun party_public_key(arg0: &PartyConfig) : &vector<u8> {
        &arg0.public_key
    }

    public fun party_signature_type(arg0: &PartyConfig) : u8 {
        arg0.signature_type
    }

    public fun penalty_amount<T0>(arg0: &Tunnel<T0>) : u64 {
        arg0.penalty_amount
    }

    public fun raise_dispute<T0>(arg0: &mut Tunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906839624658583579);
        assert!(arg0.status == 1, 13906839628951977987);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906839633247600653);
        assert_balance_split(arg3, arg4, 0x2::balance::value<T0>(&arg0.balance));
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = if (v0 == arg0.party_a.address) {
            let v1 = &arg0.party_b;
            let _ = true;
            v1
        } else {
            assert!(v0 == arg0.party_b.address, 13906839693376356353);
            let v1 = &arg0.party_a;
            let _ = false;
            v1
        };
        assert!(arg2 > arg0.state.nonce, 13906839710558060573);
        assert!(arg2 < 18446744073709551615, 13906839723442700313);
        assert!(arg2 >= arg0.last_disputed_nonce, 13906839736327864349);
        let v3 = 0x2::clock::timestamp_ms(arg7);
        assert!(arg5 <= v3, 13906839757801127941);
        assert!(arg5 >= arg0.created_at, 13906839762096095237);
        let v4 = StateUpdateData{
            tunnel_id       : 0x2::object::id<Tunnel<T0>>(arg0),
            state_hash      : arg1,
            nonce           : arg2,
            timestamp       : arg5,
            party_a_balance : arg3,
            party_b_balance : arg4,
        };
        let v5 = serialize_state_update(&v4);
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::verify(v1.signature_type, &v1.public_key, &v5, &arg6), 13906839860880998415);
        arg0.status = 3;
        arg0.dispute_raiser = 0x1::option::some<address>(v0);
        arg0.last_disputed_nonce = arg2 + 1;
        let v6 = StateCommitment{
            state_hash      : arg1,
            nonce           : arg2,
            timestamp       : v3,
            party_a_balance : arg3,
            party_b_balance : arg4,
        };
        arg0.state = v6;
        arg0.last_activity = v3;
        let v7 = DisputeRaised{
            tunnel_id  : 0x2::object::id<Tunnel<T0>>(arg0),
            raised_by  : v0,
            state_hash : arg1,
            nonce      : arg2,
            timestamp  : v3,
        };
        0x2::event::emit<DisputeRaised>(v7);
    }

    public fun raise_dispute_current_state<T0>(arg0: &mut Tunnel<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906840522306748443);
        assert!(arg0.status == 1, 13906840526600142851);
        assert!(arg0.timeout_ms > 0, 13906840530895634443);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.party_a.address || v0 == arg0.party_b.address, 13906840552369815553);
        assert!(arg0.state.nonce >= arg0.last_disputed_nonce, 13906840599616290845);
        arg0.last_disputed_nonce = arg0.state.nonce + 1;
        let v1 = 0x2::clock::timestamp_ms(arg1);
        arg0.status = 3;
        arg0.dispute_raiser = 0x1::option::some<address>(v0);
        arg0.state.timestamp = v1;
        arg0.last_activity = v1;
        let v2 = DisputeRaised{
            tunnel_id  : 0x2::object::id<Tunnel<T0>>(arg0),
            raised_by  : v0,
            state_hash : arg0.state.state_hash,
            nonce      : arg0.state.nonce,
            timestamp  : v1,
        };
        0x2::event::emit<DisputeRaised>(v2);
    }

    public fun resolve_dispute<T0>(arg0: &mut Tunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 13906840075630149659);
        assert!(arg0.status == 3, 13906840079925510177);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906840084219166733);
        assert!(arg2 > arg0.state.nonce, 13906840097105117213);
        assert!(arg2 < 18446744073709551615, 13906840109989756953);
        assert_balance_split(arg3, arg4, 0x2::balance::value<T0>(&arg0.balance));
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg5 <= v0, 13906840148643151877);
        assert!(arg5 >= arg0.created_at, 13906840152938119173);
        let v1 = StateUpdateData{
            tunnel_id       : 0x2::object::id<Tunnel<T0>>(arg0),
            state_hash      : arg1,
            nonce           : arg2,
            timestamp       : arg5,
            party_a_balance : arg3,
            party_b_balance : arg4,
        };
        let v2 = serialize_state_update(&v1);
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::verify(arg0.party_a.signature_type, &arg0.party_a.public_key, &v2, &arg6), 13906840247428055055);
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::verify(arg0.party_b.signature_type, &arg0.party_b.public_key, &v2, &arg7), 13906840290377728015);
        arg0.status = 1;
        arg0.dispute_raiser = 0x1::option::none<address>();
        let v3 = StateCommitment{
            state_hash      : arg1,
            nonce           : arg2,
            timestamp       : v0,
            party_a_balance : arg3,
            party_b_balance : arg4,
        };
        arg0.state = v3;
        arg0.last_activity = v0;
        let v4 = DisputeResolved{
            tunnel_id       : 0x2::object::id<Tunnel<T0>>(arg0),
            state_hash      : arg1,
            nonce           : arg2,
            party_a_balance : arg3,
            party_b_balance : arg4,
            timestamp       : v0,
        };
        0x2::event::emit<DisputeResolved>(v4);
    }

    public fun resolve_dispute_external<T0>(arg0: &mut Tunnel<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906843219546210331);
        assert!(arg0.status == 3, 13906843223841570849);
        let v0 = RefereeKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RefereeKey>(&arg0.id, v0), 13906843236725030923);
        let v1 = *0x2::dynamic_field::borrow<RefereeKey, address>(&arg0.id, v0);
        assert!(0x2::tx_context::sender(arg4) == v1, 13906843245316669477);
        assert_balance_split(arg1, arg2, 0x2::balance::value<T0>(&arg0.balance));
        let v2 = 0x2::clock::timestamp_ms(arg3);
        arg0.status = 2;
        arg0.last_activity = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg4), arg0.party_a.address);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg4), arg0.party_b.address);
        let v3 = DisputeResolvedByReferee{
            tunnel_id       : 0x2::object::id<Tunnel<T0>>(arg0),
            referee         : v1,
            party_a_balance : arg1,
            party_b_balance : arg2,
            timestamp       : v2,
        };
        0x2::event::emit<DisputeResolvedByReferee>(v3);
    }

    public(friend) fun resolve_dispute_verified<T0>(arg0: &mut Tunnel<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906843434294575131);
        assert!(arg0.status == 3, 13906843438589935649);
        assert!(arg0.timeout_ms > 0, 13906843442883461131);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.state.timestamp + arg0.timeout_ms, 13906843468654837795);
        assert_balance_split(arg1, arg2, 0x2::balance::value<T0>(&arg0.balance));
        arg0.status = 2;
        arg0.last_activity = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg4), arg0.party_a.address);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg4), arg0.party_b.address);
        let v1 = DisputeResolvedByVerifiedProof{
            tunnel_id       : 0x2::object::id<Tunnel<T0>>(arg0),
            party_a_balance : arg1,
            party_b_balance : arg2,
            timestamp       : v0,
        };
        0x2::event::emit<DisputeResolvedByVerifiedProof>(v1);
    }

    public fun serialize_htlc_lock(arg0: &HTLCLockData) : vector<u8> {
        let v0 = b"sui_tunnel::htlc_lock";
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0.tunnel_id));
        0x1::vector::append<u8>(&mut v0, arg0.payment_hash);
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg0.amount));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.sender));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.receiver));
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg0.expiry_ms));
        v0
    }

    fun serialize_referee_assignment(arg0: 0x2::object::ID, arg1: address) : vector<u8> {
        let v0 = b"sui_tunnel::referee_assignment";
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        v0
    }

    public fun serialize_settlement(arg0: &SettlementData) : vector<u8> {
        let v0 = b"sui_tunnel::settlement";
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0.tunnel_id));
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg0.party_a_balance));
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg0.party_b_balance));
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg0.final_nonce));
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg0.timestamp));
        v0
    }

    public fun serialize_settlement_with_root(arg0: &SettlementWithRootData) : vector<u8> {
        let v0 = b"sui_tunnel::settlement_v2";
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0.tunnel_id));
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg0.party_a_balance));
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg0.party_b_balance));
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg0.final_nonce));
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg0.timestamp));
        0x1::vector::append<u8>(&mut v0, arg0.transcript_root);
        v0
    }

    public fun serialize_state_update(arg0: &StateUpdateData) : vector<u8> {
        let v0 = b"sui_tunnel::state_update";
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0.tunnel_id));
        0x1::vector::append<u8>(&mut v0, arg0.state_hash);
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg0.nonce));
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg0.timestamp));
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg0.party_a_balance));
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg0.party_b_balance));
        v0
    }

    public(friend) fun set_referee<T0>(arg0: &mut Tunnel<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906842979028041755);
        assert!(arg0.status == 0, 13906842983321436163);
        assert!(arg0.party_a_deposit == 0 && arg0.party_b_deposit == 0, 13906842996206338051);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.party_a.address || v0 == arg0.party_b.address, 13906843021976010753);
        write_referee<T0>(arg0, arg1);
    }

    public fun set_referee_cosigned<T0>(arg0: &mut Tunnel<T0>, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906842794344448027);
        assert!(arg0.status == 0, 13906842798637842435);
        assert!(arg0.party_a_deposit == 0 && arg0.party_b_deposit == 0, 13906842820112678915);
        assert!(!0x1::vector::is_empty<u8>(&arg2) && !0x1::vector::is_empty<u8>(&arg3), 13906842828703399951);
        let v0 = serialize_referee_assignment(0x2::object::id<Tunnel<T0>>(arg0), arg1);
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::verify(arg0.party_a.signature_type, &arg0.party_a.public_key, &v0, &arg2), 13906842871655825465);
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::verify(arg0.party_b.signature_type, &arg0.party_b.public_key, &v0, &arg3), 13906842910310662203);
        write_referee<T0>(arg0, arg1);
    }

    public fun state<T0>(arg0: &Tunnel<T0>) : &StateCommitment {
        &arg0.state
    }

    public fun state_hash(arg0: &StateCommitment) : &vector<u8> {
        &arg0.state_hash
    }

    public fun state_nonce(arg0: &StateCommitment) : u64 {
        arg0.nonce
    }

    public fun state_party_a_balance(arg0: &StateCommitment) : u64 {
        arg0.party_a_balance
    }

    public fun state_party_b_balance(arg0: &StateCommitment) : u64 {
        arg0.party_b_balance
    }

    public fun state_timestamp(arg0: &StateCommitment) : u64 {
        arg0.timestamp
    }

    public fun status<T0>(arg0: &Tunnel<T0>) : u8 {
        arg0.status
    }

    public fun status_active() : u8 {
        1
    }

    public fun status_closed() : u8 {
        2
    }

    public fun status_created() : u8 {
        0
    }

    public fun status_destroyed() : u8 {
        4
    }

    public fun status_disputed() : u8 {
        3
    }

    public fun timeout_ms<T0>(arg0: &Tunnel<T0>) : u64 {
        arg0.timeout_ms
    }

    public fun total_balance<T0>(arg0: &Tunnel<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun update_party_htlc_counter<T0>(arg0: &mut Tunnel<T0>, arg1: address, arg2: bool, arg3: u64) {
        let v0 = HTLCPartyCounterKey{party: arg1};
        if (!0x2::dynamic_field::exists<HTLCPartyCounterKey>(&arg0.id, v0)) {
            let v1 = HTLCPartyCounter{
                count        : 0,
                total_locked : 0,
            };
            0x2::dynamic_field::add<HTLCPartyCounterKey, HTLCPartyCounter>(&mut arg0.id, v0, v1);
        };
        let v2 = 0x2::dynamic_field::borrow_mut<HTLCPartyCounterKey, HTLCPartyCounter>(&mut arg0.id, v0);
        if (arg2) {
            v2.count = v2.count + 1;
            v2.total_locked = v2.total_locked + arg3;
        } else {
            v2.count = v2.count - 1;
            v2.total_locked = v2.total_locked - arg3;
        };
    }

    public fun update_state<T0>(arg0: &mut Tunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 13906838258858983451);
        assert!(arg0.status == 1, 13906838263152377859);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906838276037935117);
        assert!(arg2 > arg0.state.nonce, 13906838280333688857);
        assert!(arg2 < 18446744073709551615, 13906838297513558041);
        assert_balance_split(arg3, arg4, 0x2::balance::value<T0>(&arg0.balance));
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg5 <= v0, 13906838357641789445);
        assert!(arg5 >= arg0.created_at, 13906838361936756741);
        let v1 = 0x2::object::id<Tunnel<T0>>(arg0);
        let v2 = StateUpdateData{
            tunnel_id       : v1,
            state_hash      : arg1,
            nonce           : arg2,
            timestamp       : arg5,
            party_a_balance : arg3,
            party_b_balance : arg4,
        };
        let v3 = serialize_state_update(&v2);
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::verify(arg0.party_a.signature_type, &arg0.party_a.public_key, &v3, &arg6), 13906838469311594511);
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::verify(arg0.party_b.signature_type, &arg0.party_b.public_key, &v3, &arg7), 13906838512261267471);
        let v4 = StateCommitment{
            state_hash      : arg1,
            nonce           : arg2,
            timestamp       : v0,
            party_a_balance : arg3,
            party_b_balance : arg4,
        };
        arg0.state = v4;
        arg0.last_activity = v0;
        let v5 = StateUpdated{
            tunnel_id  : v1,
            state_hash : arg1,
            nonce      : arg2,
            timestamp  : v0,
        };
        0x2::event::emit<StateUpdated>(v5);
    }

    fun validate_create_params(arg0: address, arg1: address, arg2: u8, arg3: u8, arg4: &vector<u8>, arg5: &vector<u8>) {
        assert!(arg0 != arg1, 13906837545894150167);
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::is_valid_signature_type(arg2), 13906837558778789907);
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::is_valid_signature_type(arg3), 13906837575958659091);
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::is_valid_public_key_length(arg2, arg4), 13906837593138397201);
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::is_valid_public_key_length(arg3, arg5), 13906837610318266385);
    }

    public fun version<T0>(arg0: &Tunnel<T0>) : u64 {
        arg0.version
    }

    public fun withdraw_before_active<T0>(arg0: &mut Tunnel<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 13906843627568103451);
        assert!(arg0.status == 0, 13906843631861497859);
        let v0 = 0x2::tx_context::sender(arg2);
        let (v1, v2, v3) = if (v0 == arg0.party_a.address) {
            (arg0.party_a_deposit, arg0.party_b_deposit, true)
        } else {
            assert!(v0 == arg0.party_b.address, 13906843674811039745);
            (arg0.party_b_deposit, arg0.party_a_deposit, false)
        };
        assert!(v1 > 0, 13906843687699087409);
        assert!(v2 == 0, 13906843691991040003);
        let v4 = 0x2::clock::timestamp_ms(arg1);
        if (v3) {
            arg0.party_a_deposit = 0;
        } else {
            arg0.party_b_deposit = 0;
        };
        arg0.last_activity = v4;
        if (0x2::balance::value<T0>(&arg0.balance) == 0) {
            arg0.status = 2;
        };
        let v5 = TunnelWithdrawal{
            tunnel_id : 0x2::object::id<Tunnel<T0>>(arg0),
            party     : v0,
            amount    : v1,
            timestamp : v4,
        };
        0x2::event::emit<TunnelWithdrawal>(v5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg2)
    }

    public fun withdraw_timeout<T0>(arg0: &mut Tunnel<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 13906843846611435547);
        assert!(arg0.status == 0, 13906843850904829955);
        assert!(arg0.timeout_ms > 0, 13906843855200321547);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.created_at + arg0.timeout_ms, 13906843868086796323);
        let v1 = 0x2::tx_context::sender(arg2);
        let (v2, v3) = if (v1 == arg0.party_a.address) {
            (arg0.party_a_deposit, true)
        } else {
            assert!(v1 == arg0.party_b.address, 13906843902444306433);
            (arg0.party_b_deposit, false)
        };
        assert!(v2 > 0, 13906843915332354097);
        if (v3) {
            arg0.party_a_deposit = 0;
        } else {
            arg0.party_b_deposit = 0;
        };
        arg0.last_activity = v0;
        if (0x2::balance::value<T0>(&arg0.balance) == 0) {
            arg0.status = 2;
        };
        let v4 = TunnelWithdrawal{
            tunnel_id : 0x2::object::id<Tunnel<T0>>(arg0),
            party     : v1,
            amount    : v2,
            timestamp : v0,
        };
        0x2::event::emit<TunnelWithdrawal>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v2), arg2)
    }

    fun write_referee<T0>(arg0: &mut Tunnel<T0>, arg1: address) {
        let v0 = RefereeKey{dummy_field: false};
        if (0x2::dynamic_field::exists<RefereeKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<RefereeKey, address>(&mut arg0.id, v0) = arg1;
        } else {
            0x2::dynamic_field::add<RefereeKey, address>(&mut arg0.id, v0, arg1);
        };
        let v1 = RefereeAssigned{
            tunnel_id : 0x2::object::id<Tunnel<T0>>(arg0),
            referee   : arg1,
        };
        0x2::event::emit<RefereeAssigned>(v1);
    }

    // decompiled from Move bytecode v7
}

