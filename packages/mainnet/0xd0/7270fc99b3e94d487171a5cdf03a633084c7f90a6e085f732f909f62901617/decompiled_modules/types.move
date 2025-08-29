module 0xd07270fc99b3e94d487171a5cdf03a633084c7f90a6e085f732f909f62901617::types {
    struct CoinId has copy, drop, store {
        bytes: vector<u8>,
    }

    struct EpochInfo has copy, drop, store {
        epoch_number: u64,
        epoch_hash: vector<u8>,
        merkle_root: vector<u8>,
        timestamp: u64,
        difficulty: u64,
    }

    struct UnchainedBridgeEvent has copy, drop, store {
        event_id: vector<u8>,
        coin_id: CoinId,
        amount: u64,
        recipient: address,
        epoch_hash: vector<u8>,
        merkle_proof: vector<vector<u8>>,
        tx_hash: vector<u8>,
        nullifier: vector<u8>,
        commitment: vector<u8>,
    }

    struct BridgeState has store, key {
        id: 0x2::object::UID,
        processed_events: vector<vector<u8>>,
        total_bridged_in: u64,
        total_bridged_out: u64,
        is_paused: bool,
    }

    struct AttestorSignature has copy, drop, store {
        attestor: address,
        signature: vector<u8>,
        public_key: vector<u8>,
    }

    struct BridgeOutRequest has copy, drop, store {
        request_id: vector<u8>,
        sender: address,
        recipient: vector<u8>,
        amount: u64,
        timestamp: u64,
    }

    struct BridgeInEvent has copy, drop {
        event_id: vector<u8>,
        recipient: address,
        amount: u64,
        coin_id: vector<u8>,
    }

    struct BridgeOutEvent has copy, drop {
        request_id: vector<u8>,
        sender: address,
        recipient: vector<u8>,
        amount: u64,
    }

    public fun coin_id_bytes(arg0: &CoinId) : vector<u8> {
        arg0.bytes
    }

    public fun emit_bridge_in_event(arg0: vector<u8>, arg1: address, arg2: u64, arg3: vector<u8>) {
        let v0 = BridgeInEvent{
            event_id  : arg0,
            recipient : arg1,
            amount    : arg2,
            coin_id   : arg3,
        };
        0x2::event::emit<BridgeInEvent>(v0);
    }

    public fun emit_bridge_out_event(arg0: vector<u8>, arg1: address, arg2: vector<u8>, arg3: u64) {
        let v0 = BridgeOutEvent{
            request_id : arg0,
            sender     : arg1,
            recipient  : arg2,
            amount     : arg3,
        };
        0x2::event::emit<BridgeOutEvent>(v0);
    }

    public fun get_amount(arg0: &UnchainedBridgeEvent) : u64 {
        arg0.amount
    }

    public fun get_attestor_address(arg0: &AttestorSignature) : address {
        arg0.attestor
    }

    public fun get_chain_id() : vector<u8> {
        b"2ada83c1819a5372dae1238fc1ded123c8104fdaa15862aaee69428a1820fcda"
    }

    public fun get_coin_decimals() : u8 {
        0
    }

    public fun get_coin_id(arg0: &UnchainedBridgeEvent) : &CoinId {
        &arg0.coin_id
    }

    public fun get_coin_value() : u64 {
        1
    }

    public fun get_epoch_difficulty(arg0: &EpochInfo) : u64 {
        arg0.difficulty
    }

    public fun get_epoch_hash(arg0: &UnchainedBridgeEvent) : &vector<u8> {
        &arg0.epoch_hash
    }

    public fun get_epoch_hash_from_info(arg0: &EpochInfo) : &vector<u8> {
        &arg0.epoch_hash
    }

    public fun get_epoch_number(arg0: &EpochInfo) : u64 {
        arg0.epoch_number
    }

    public fun get_epoch_timestamp(arg0: &UnchainedBridgeEvent) : u64 {
        0
    }

    public fun get_epoch_timestamp_from_info(arg0: &EpochInfo) : u64 {
        arg0.timestamp
    }

    public fun get_event_id(arg0: &UnchainedBridgeEvent) : &vector<u8> {
        &arg0.event_id
    }

    public fun get_finality_epochs() : u8 {
        3
    }

    public fun get_merkle_proof(arg0: &UnchainedBridgeEvent) : &vector<vector<u8>> {
        &arg0.merkle_proof
    }

    public fun get_merkle_root_from_epoch(arg0: &UnchainedBridgeEvent) : vector<u8> {
        arg0.epoch_hash
    }

    public fun get_merkle_root_from_info(arg0: &EpochInfo) : &vector<u8> {
        &arg0.merkle_root
    }

    public fun get_public_key(arg0: &AttestorSignature) : &vector<u8> {
        &arg0.public_key
    }

    public fun get_recipient(arg0: &UnchainedBridgeEvent) : address {
        arg0.recipient
    }

    public fun get_signature_bytes(arg0: &AttestorSignature) : &vector<u8> {
        &arg0.signature
    }

    public fun get_total_bridged_in(arg0: &BridgeState) : u64 {
        arg0.total_bridged_in
    }

    public fun get_total_bridged_out(arg0: &BridgeState) : u64 {
        arg0.total_bridged_out
    }

    public fun get_tx_hash(arg0: &UnchainedBridgeEvent) : &vector<u8> {
        &arg0.tx_hash
    }

    public fun init_bridge_state(arg0: &mut 0x2::tx_context::TxContext) : BridgeState {
        BridgeState{
            id                : 0x2::object::new(arg0),
            processed_events  : 0x1::vector::empty<vector<u8>>(),
            total_bridged_in  : 0,
            total_bridged_out : 0,
            is_paused         : false,
        }
    }

    public fun is_bridge_paused(arg0: &BridgeState) : bool {
        arg0.is_paused
    }

    public fun is_event_processed(arg0: &BridgeState, arg1: &vector<u8>) : bool {
        0x1::vector::contains<vector<u8>>(&arg0.processed_events, arg1)
    }

    public fun mark_event_processed(arg0: &mut BridgeState, arg1: vector<u8>) {
        if (!0x1::vector::contains<vector<u8>>(&arg0.processed_events, &arg1)) {
            0x1::vector::push_back<vector<u8>>(&mut arg0.processed_events, arg1);
        };
    }

    public fun new_attestor_signature(arg0: address, arg1: vector<u8>, arg2: vector<u8>) : AttestorSignature {
        AttestorSignature{
            attestor   : arg0,
            signature  : arg1,
            public_key : arg2,
        }
    }

    public fun new_bridge_event(arg0: vector<u8>, arg1: CoinId, arg2: u64, arg3: address, arg4: vector<u8>, arg5: vector<vector<u8>>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>) : UnchainedBridgeEvent {
        UnchainedBridgeEvent{
            event_id     : arg0,
            coin_id      : arg1,
            amount       : arg2,
            recipient    : arg3,
            epoch_hash   : arg4,
            merkle_proof : arg5,
            tx_hash      : arg6,
            nullifier    : arg7,
            commitment   : arg8,
        }
    }

    public fun new_bridge_out_request(arg0: vector<u8>, arg1: address, arg2: vector<u8>, arg3: u64, arg4: u64) : BridgeOutRequest {
        BridgeOutRequest{
            request_id : arg0,
            sender     : arg1,
            recipient  : arg2,
            amount     : arg3,
            timestamp  : arg4,
        }
    }

    public fun new_coin_id(arg0: vector<u8>) : CoinId {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 0);
        CoinId{bytes: arg0}
    }

    public fun new_epoch_info(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64) : EpochInfo {
        EpochInfo{
            epoch_number : arg0,
            epoch_hash   : arg1,
            merkle_root  : arg2,
            timestamp    : arg3,
            difficulty   : arg4,
        }
    }

    public fun set_bridge_paused(arg0: &mut BridgeState, arg1: bool) {
        arg0.is_paused = arg1;
    }

    public fun update_bridge_in_stats(arg0: &mut BridgeState, arg1: u64) {
        arg0.total_bridged_in = arg0.total_bridged_in + arg1;
    }

    public fun update_bridge_out_stats(arg0: &mut BridgeState, arg1: u64) {
        arg0.total_bridged_out = arg0.total_bridged_out + arg1;
    }

    // decompiled from Move bytecode v6
}

