module 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state {
    struct StateCreated has copy, drop {
        state: 0x2::object::ID,
    }

    struct FundsReceiverCreated has copy, drop {
        funds_receiver: 0x2::object::ID,
    }

    struct EmitterPaired has store {
        auction: address,
        pairs: 0x2::table::Table<u16, address>,
    }

    struct FundsReceiver has key {
        id: 0x2::object::UID,
    }

    struct LockedFunds<phantom T0> has key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<T0>,
    }

    struct LockedFeeBridge has store {
        status: u8,
        locked_fee: 0x2::object::ID,
        gas_drop: u64,
        addr_dest: address,
    }

    struct MayanRecipientKey has copy, drop, store {
        cctp_dest_domain: u32,
        coin_metadata_id: address,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        paused: bool,
        emitter_cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        consumed_vaas: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::ConsumedVAAs,
        emitter_paired: EmitterPaired,
        cctp_used_nonce: 0x2::table::Table<address, bool>,
        cctp_mayan_recipient_registry: 0x2::table::Table<MayanRecipientKey, address>,
        cctp_mayan_caller_registry: 0x2::table::Table<u32, address>,
        wh_chain_cctp_pair_registry: 0x2::table::Table<u16, u32>,
        locked_fee_registry: 0x2::table::Table<u64, LockedFeeBridge>,
        version_set: 0x2::vec_set::VecSet<u64>,
        latest_package_id: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun add_cctp_mayan_caller(arg0: &AdminCap, arg1: &mut State, arg2: u32, arg3: address) {
        assert!(!0x2::table::contains<u32, address>(&arg1.cctp_mayan_caller_registry, arg2), 5);
        0x2::table::add<u32, address>(&mut arg1.cctp_mayan_caller_registry, arg2, arg3);
    }

    public(friend) fun add_cctp_mayan_recipient(arg0: &AdminCap, arg1: &mut State, arg2: u32, arg3: address, arg4: address) {
        let v0 = MayanRecipientKey{
            cctp_dest_domain : arg2,
            coin_metadata_id : arg3,
        };
        assert!(!0x2::table::contains<MayanRecipientKey, address>(&arg1.cctp_mayan_recipient_registry, v0), 4);
        0x2::table::add<MayanRecipientKey, address>(&mut arg1.cctp_mayan_recipient_registry, v0, arg4);
    }

    entry fun add_compatible_state_version(arg0: &AdminCap, arg1: address, arg2: &mut State) {
        assert!(max_compatible_state_version(arg2) < current_state_version(), 8);
        0x2::vec_set::insert<u64>(&mut arg2.version_set, current_state_version());
        arg2.latest_package_id = arg1;
    }

    public(friend) fun add_paired_emitter(arg0: &AdminCap, arg1: &mut State, arg2: u16, arg3: address) {
        assert!(!0x2::table::contains<u16, address>(&arg1.emitter_paired.pairs, arg2), 9);
        0x2::table::add<u16, address>(&mut arg1.emitter_paired.pairs, arg2, arg3);
    }

    public(friend) fun add_wh_chain_cctp_domain(arg0: &AdminCap, arg1: &mut State, arg2: u16, arg3: u32) {
        assert!(!0x2::table::contains<u16, u32>(&arg1.wh_chain_cctp_pair_registry, arg2), 10);
        0x2::table::add<u16, u32>(&mut arg1.wh_chain_cctp_pair_registry, arg2, arg3);
    }

    public fun assert_valid_version(arg0: &State) {
        let v0 = current_state_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 8);
    }

    public(friend) fun borrow_mut_emitter_cap(arg0: &mut State) : &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap {
        &mut arg0.emitter_cap
    }

    public(friend) fun consume_vaa(arg0: &mut State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::consume(&mut arg0.consumed_vaas, arg1);
    }

    public fun current_state_version() : u64 {
        1
    }

    public(friend) fun generate_used_nonce_key(arg0: u32, arg1: u64) : address {
        let v0 = 0x2::bcs::to_bytes<u32>(&arg0);
        0x1::vector::append<u8>(&mut v0, b"-");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x2::address::from_bytes(0x2::hash::keccak256(&v0))
    }

    public(friend) fun get_cctp_mayan_caller(arg0: &State, arg1: u32) : address {
        *0x2::table::borrow<u32, address>(&arg0.cctp_mayan_caller_registry, arg1)
    }

    public(friend) fun get_cctp_mayan_recipient(arg0: &State, arg1: u32, arg2: address) : address {
        let v0 = MayanRecipientKey{
            cctp_dest_domain : arg1,
            coin_metadata_id : arg2,
        };
        *0x2::table::borrow<MayanRecipientKey, address>(&arg0.cctp_mayan_recipient_registry, v0)
    }

    public(friend) fun get_locked_fee_addr_dest(arg0: &State, arg1: u64) : address {
        0x2::table::borrow<u64, LockedFeeBridge>(&arg0.locked_fee_registry, arg1).addr_dest
    }

    public(friend) fun get_locked_fee_funds_id(arg0: &State, arg1: u64) : address {
        0x2::object::id_to_address(&0x2::table::borrow<u64, LockedFeeBridge>(&arg0.locked_fee_registry, arg1).locked_fee)
    }

    public(friend) fun get_locked_fee_gas_drop(arg0: &State, arg1: u64) : u64 {
        0x2::table::borrow<u64, LockedFeeBridge>(&arg0.locked_fee_registry, arg1).gas_drop
    }

    public(friend) fun get_locked_fee_status(arg0: &State, arg1: u64) : u8 {
        0x2::table::borrow<u64, LockedFeeBridge>(&arg0.locked_fee_registry, arg1).status
    }

    public(friend) fun get_paired_emitter(arg0: &State, arg1: u16) : address {
        *0x2::table::borrow<u16, address>(&arg0.emitter_paired.pairs, arg1)
    }

    public(friend) fun get_sui_emitter(arg0: &State) : address {
        let v0 = 0x2::object::id<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap>(&arg0.emitter_cap);
        0x2::object::id_to_address(&v0)
    }

    public(friend) fun get_wh_chain_cctp_domain(arg0: &State, arg1: u16) : u32 {
        *0x2::table::borrow<u16, u32>(&arg0.wh_chain_cctp_pair_registry, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FundsReceiver{id: 0x2::object::new(arg0)};
        let v2 = FundsReceiverCreated{funds_receiver: 0x2::object::id<FundsReceiver>(&v1)};
        0x2::event::emit<FundsReceiverCreated>(v2);
        0x2::transfer::share_object<FundsReceiver>(v1);
    }

    public(friend) fun is_locked_fee_status_created(arg0: &State, arg1: u64) : bool {
        0x2::table::borrow<u64, LockedFeeBridge>(&arg0.locked_fee_registry, arg1).status == 1
    }

    public(friend) fun is_mayan_used_nonce(arg0: &State, arg1: u32, arg2: u64) : bool {
        0x2::table::contains<address, bool>(&arg0.cctp_used_nonce, generate_used_nonce_key(arg1, arg2))
    }

    public(friend) fun is_paused(arg0: &State) : bool {
        arg0.paused
    }

    public(friend) fun lock_fee_redeem<T0>(arg0: &mut State, arg1: u64, arg2: address, arg3: u64, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0x2::tx_context::TxContext) : address {
        assert!(!0x2::table::contains<u64, LockedFeeBridge>(&arg0.locked_fee_registry, arg1), 6);
        let v0 = LockedFunds<T0>{
            id    : 0x2::object::new(arg5),
            funds : arg4,
        };
        let v1 = 0x2::object::id<LockedFunds<T0>>(&v0);
        let v2 = LockedFeeBridge{
            status     : 1,
            locked_fee : v1,
            gas_drop   : arg3,
            addr_dest  : arg2,
        };
        0x2::table::add<u64, LockedFeeBridge>(&mut arg0.locked_fee_registry, arg1, v2);
        0x2::transfer::share_object<LockedFunds<T0>>(v0);
        0x2::object::id_to_address(&v1)
    }

    public(friend) fun mark_mayan_nonce_used(arg0: &mut State, arg1: u32, arg2: u64) {
        let v0 = generate_used_nonce_key(arg1, arg2);
        assert!(!0x2::table::contains<address, bool>(&arg0.cctp_used_nonce, v0), 7);
        0x2::table::add<address, bool>(&mut arg0.cctp_used_nonce, v0, true);
    }

    fun max_compatible_state_version(arg0: &State) : u64 {
        let v0 = 0x2::vec_set::keys<u64>(&arg0.version_set);
        let v1 = 0x1::vector::length<u64>(v0);
        assert!(v1 > 0, 1);
        let v2 = *0x1::vector::borrow<u64>(v0, 0);
        let v3 = 1;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u64>(v0, v3);
            if (v4 > v2) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        v2
    }

    public(friend) fun new_state(arg0: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : State {
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::sequence(&arg0) == 0, 0);
        let v0 = 0x2::vec_set::empty<u64>();
        0x2::vec_set::insert<u64>(&mut v0, 1);
        let v1 = EmitterPaired{
            auction : arg1,
            pairs   : 0x2::table::new<u16, address>(arg3),
        };
        let v2 = State{
            id                            : 0x2::object::new(arg3),
            paused                        : false,
            emitter_cap                   : arg0,
            consumed_vaas                 : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::new(arg3),
            emitter_paired                : v1,
            cctp_used_nonce               : 0x2::table::new<address, bool>(arg3),
            cctp_mayan_recipient_registry : 0x2::table::new<MayanRecipientKey, address>(arg3),
            cctp_mayan_caller_registry    : 0x2::table::new<u32, address>(arg3),
            wh_chain_cctp_pair_registry   : 0x2::table::new<u16, u32>(arg3),
            locked_fee_registry           : 0x2::table::new<u64, LockedFeeBridge>(arg3),
            version_set                   : v0,
            latest_package_id             : arg2,
        };
        let v3 = StateCreated{state: 0x2::object::id<State>(&v2)};
        0x2::event::emit<StateCreated>(v3);
        v2
    }

    public(friend) fun receive_minted_funds<T0>(arg0: &mut FundsReceiver, arg1: u64, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg2);
        assert!(0x2::coin::value<T0>(&v0) == arg1, 2);
        v0
    }

    public(friend) fun release_locked_fee<T0>(arg0: &mut State, arg1: u64, arg2: address, arg3: LockedFunds<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let LockedFunds {
            id    : v0,
            funds : v1,
        } = arg3;
        0x2::table::borrow_mut<u64, LockedFeeBridge>(&mut arg0.locked_fee_registry, arg1).status = 2;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg4), arg2);
    }

    entry fun remove_old_state_version(arg0: &AdminCap, arg1: &mut State, arg2: u64) {
        assert_valid_version(arg1);
        assert!(current_state_version() > arg2, 8);
        0x2::vec_set::remove<u64>(&mut arg1.version_set, &arg2);
    }

    public(friend) fun solana_cctp_domain() : u32 {
        5
    }

    public(friend) fun verify_auction_emitter(arg0: &State, arg1: address, arg2: u16) {
        assert!(arg2 != 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 1);
        assert!(arg1 == arg0.emitter_paired.auction, 1);
        assert!(arg2 == 1, 1);
    }

    public(friend) fun verify_local_token_coin_type<T0: drop>(arg0: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg1: u32, arg2: address) {
        assert!(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::token_utils::calculate_token_id<T0>() == 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::local_token_from_remote_token(arg0, arg1, arg2), 3);
    }

    public(friend) fun verify_mctp_emitter(arg0: &State, arg1: address, arg2: u16) {
        assert!(arg2 != 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 1);
        assert!(arg1 == get_paired_emitter(arg0, arg2), 1);
    }

    // decompiled from Move bytecode v6
}

