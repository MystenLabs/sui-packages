module 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::partner {
    struct Partners has key {
        id: 0x2::object::UID,
        partners: 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>,
    }

    struct PartnerCap has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        partner_id: 0x2::object::ID,
    }

    struct Partner has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        ref_fee_rate: u64,
        start_time: u64,
        end_time: u64,
        balances: 0x2::bag::Bag,
    }

    struct InitPartnerEvent has copy, drop {
        partners_id: 0x2::object::ID,
    }

    struct CreatePartnerEvent has copy, drop {
        recipient: address,
        partner_id: 0x2::object::ID,
        partner_cap_id: 0x2::object::ID,
        ref_fee_rate: u64,
        name: 0x1::string::String,
        start_time: u64,
        end_time: u64,
    }

    struct UpdateRefFeeRateEvent has copy, drop {
        partner_id: 0x2::object::ID,
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct UpdateTimeRangeEvent has copy, drop {
        partner_id: 0x2::object::ID,
        start_time: u64,
        end_time: u64,
    }

    struct ReceiveRefFeeEvent has copy, drop {
        partner_id: 0x2::object::ID,
        amount: u64,
        type_name: 0x1::string::String,
    }

    struct ClaimRefFeeEvent has copy, drop {
        partner_id: 0x2::object::ID,
        amount: u64,
        type_name: 0x1::string::String,
    }

    public fun balances(arg0: &Partner) : &0x2::bag::Bag {
        abort 0
    }

    public fun claim_ref_fee<T0>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &PartnerCap, arg2: &mut Partner, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun create_partner(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Partners, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun current_ref_fee_rate(arg0: &Partner, arg1: u64) : u64 {
        abort 0
    }

    public fun end_time(arg0: &Partner) : u64 {
        abort 0
    }

    public fun name(arg0: &Partner) : 0x1::string::String {
        abort 0
    }

    public fun receive_ref_fee<T0>(arg0: &mut Partner, arg1: 0x2::balance::Balance<T0>) {
        abort 0
    }

    public fun ref_fee_rate(arg0: &Partner) : u64 {
        abort 0
    }

    public fun start_time(arg0: &Partner) : u64 {
        abort 0
    }

    public fun update_ref_fee_rate(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Partner, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun update_time_range(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Partner, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

