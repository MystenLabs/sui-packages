module 0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::hash_share_registry {
    struct AvailableSlot has copy, drop, store {
        cap_id: address,
        label: vector<u8>,
    }

    struct RoundBinding has copy, drop, store {
        cap_id: address,
        label: vector<u8>,
        bound_at_round_idx: u64,
    }

    struct RegisteredCapKey has copy, drop, store {
        cap_id: address,
    }

    struct HashShareRegistry has key {
        id: 0x2::object::UID,
        available_slots: vector<AvailableSlot>,
        rounds: 0x2::table::Table<u64, RoundBinding>,
        total_bound: u64,
        total_registered: u64,
        fee_bps: u64,
        fee_recipient: address,
    }

    struct SlotRegistered has copy, drop {
        cap_id: address,
        label: vector<u8>,
        index_in_buffer: u64,
    }

    struct SlotBoundToRound has copy, drop {
        round_id: u64,
        cap_id: address,
        label: vector<u8>,
        bound_at_round_idx: u64,
    }

    struct FeeBpsUpdated has copy, drop {
        old_bps: u64,
        new_bps: u64,
    }

    struct FeeRecipientUpdated has copy, drop {
        old_recipient: address,
        new_recipient: address,
    }

    public fun assert_cap_matches_round(arg0: &HashShareRegistry, arg1: u64, arg2: address) {
        assert!(0x2::table::contains<u64, RoundBinding>(&arg0.rounds, arg1), 13906835325394812932);
        assert!(0x2::table::borrow<u64, RoundBinding>(&arg0.rounds, arg1).cap_id == arg2, 13906835333985009672);
    }

    public fun available_slots(arg0: &HashShareRegistry) : u64 {
        0x1::vector::length<AvailableSlot>(&arg0.available_slots)
    }

    public fun bind_slot_to_round(arg0: &mut HashShareRegistry, arg1: u64) : RoundBinding {
        if (0x2::table::contains<u64, RoundBinding>(&arg0.rounds, arg1)) {
            return *0x2::table::borrow<u64, RoundBinding>(&arg0.rounds, arg1)
        };
        assert!(!0x1::vector::is_empty<AvailableSlot>(&arg0.available_slots), 13906835067696775172);
        let v0 = 0x1::vector::remove<AvailableSlot>(&mut arg0.available_slots, 0);
        let v1 = arg0.total_bound;
        arg0.total_bound = arg0.total_bound + 1;
        let v2 = RoundBinding{
            cap_id             : v0.cap_id,
            label              : v0.label,
            bound_at_round_idx : v1,
        };
        0x2::table::add<u64, RoundBinding>(&mut arg0.rounds, arg1, v2);
        let v3 = SlotBoundToRound{
            round_id           : arg1,
            cap_id             : v0.cap_id,
            label              : v0.label,
            bound_at_round_idx : v1,
        };
        0x2::event::emit<SlotBoundToRound>(v3);
        v2
    }

    public fun binding_cap_id(arg0: &RoundBinding) : address {
        arg0.cap_id
    }

    public fun binding_label(arg0: &RoundBinding) : vector<u8> {
        arg0.label
    }

    public fun binding_round_idx(arg0: &RoundBinding) : u64 {
        arg0.bound_at_round_idx
    }

    public fun bps_denom() : u64 {
        10000
    }

    public fun fee_bps(arg0: &HashShareRegistry) : u64 {
        arg0.fee_bps
    }

    public fun fee_recipient(arg0: &HashShareRegistry) : address {
        arg0.fee_recipient
    }

    public fun has_round_binding(arg0: &HashShareRegistry, arg1: u64) : bool {
        0x2::table::contains<u64, RoundBinding>(&arg0.rounds, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HashShareRegistry{
            id               : 0x2::object::new(arg0),
            available_slots  : 0x1::vector::empty<AvailableSlot>(),
            rounds           : 0x2::table::new<u64, RoundBinding>(arg0),
            total_bound      : 0,
            total_registered : 0,
            fee_bps          : 100,
            fee_recipient    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<HashShareRegistry>(v0);
    }

    public fun register_slot(arg0: &mut HashShareRegistry, arg1: address, arg2: vector<u8>) {
        let v0 = RegisteredCapKey{cap_id: arg1};
        assert!(!0x2::dynamic_field::exists<RegisteredCapKey>(&arg0.id, v0), 13906834956027756550);
        0x2::dynamic_field::add<RegisteredCapKey, bool>(&mut arg0.id, v0, true);
        let v1 = AvailableSlot{
            cap_id : arg1,
            label  : arg2,
        };
        0x1::vector::push_back<AvailableSlot>(&mut arg0.available_slots, v1);
        arg0.total_registered = arg0.total_registered + 1;
        let v2 = SlotRegistered{
            cap_id          : arg1,
            label           : arg2,
            index_in_buffer : 0x1::vector::length<AvailableSlot>(&arg0.available_slots),
        };
        0x2::event::emit<SlotRegistered>(v2);
    }

    public fun round_binding(arg0: &HashShareRegistry, arg1: u64) : RoundBinding {
        *0x2::table::borrow<u64, RoundBinding>(&arg0.rounds, arg1)
    }

    public fun set_fee_bps(arg0: &mut HashShareRegistry, arg1: &0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::pool::PoolAdminCap, arg2: u64) {
        assert!(arg2 <= 1000, 13906834801409196042);
        arg0.fee_bps = arg2;
        let v0 = FeeBpsUpdated{
            old_bps : arg0.fee_bps,
            new_bps : arg2,
        };
        0x2::event::emit<FeeBpsUpdated>(v0);
    }

    public fun set_fee_recipient(arg0: &mut HashShareRegistry, arg1: &0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::pool::PoolAdminCap, arg2: address) {
        arg0.fee_recipient = arg2;
        let v0 = FeeRecipientUpdated{
            old_recipient : arg0.fee_recipient,
            new_recipient : arg2,
        };
        0x2::event::emit<FeeRecipientUpdated>(v0);
    }

    public fun total_bound(arg0: &HashShareRegistry) : u64 {
        arg0.total_bound
    }

    public fun total_registered(arg0: &HashShareRegistry) : u64 {
        arg0.total_registered
    }

    // decompiled from Move bytecode v6
}

