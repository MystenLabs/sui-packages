module 0x94739365c4f3546dde682a1554de063626c8351a1b37522d493f089e03776f6e::oft_fee {
    struct OFTFee has store {
        default_fee_bps: u64,
        fee_bps: 0x2::table::Table<u32, u64>,
        fee_deposit_address: address,
    }

    struct DefaultFeeBpsSetEvent has copy, drop {
        fee_bps: u64,
    }

    struct FeeBpsSetEvent has copy, drop {
        dst_eid: u32,
        fee_bps: u64,
    }

    struct FeeBpsUnsetEvent has copy, drop {
        dst_eid: u32,
    }

    struct FeeDepositAddressSetEvent has copy, drop {
        fee_deposit_address: address,
    }

    public(friend) fun drop(arg0: OFTFee) {
        let OFTFee {
            default_fee_bps     : _,
            fee_bps             : v1,
            fee_deposit_address : _,
        } = arg0;
        0x2::table::drop<u32, u64>(v1);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : OFTFee {
        OFTFee{
            default_fee_bps     : 0,
            fee_bps             : 0x2::table::new<u32, u64>(arg0),
            fee_deposit_address : @0x0,
        }
    }

    public(friend) fun apply_fee(arg0: &OFTFee, arg1: u32, arg2: u64) : u64 {
        assert!(arg0.fee_deposit_address != @0x0, 2);
        arg2 - (((arg2 as u128) * (effective_fee_bps(arg0, arg1) as u128) / (10000 as u128)) as u64)
    }

    public(friend) fun default_fee_bps(arg0: &OFTFee) : u64 {
        arg0.default_fee_bps
    }

    public(friend) fun effective_fee_bps(arg0: &OFTFee, arg1: u32) : u64 {
        let v0 = &arg0.fee_bps;
        let v1 = if (0x2::table::contains<u32, u64>(v0, arg1)) {
            0x2::table::borrow<u32, u64>(v0, arg1)
        } else {
            &arg0.default_fee_bps
        };
        *v1
    }

    public(friend) fun fee_bps(arg0: &OFTFee, arg1: u32) : u64 {
        *0x2::table::borrow<u32, u64>(&arg0.fee_bps, arg1)
    }

    public(friend) fun fee_deposit_address(arg0: &OFTFee) : address {
        arg0.fee_deposit_address
    }

    public(friend) fun has_oft_fee(arg0: &OFTFee, arg1: u32) : bool {
        effective_fee_bps(arg0, arg1) > 0
    }

    public(friend) fun set_default_fee_bps(arg0: &mut OFTFee, arg1: u64) {
        assert!(arg1 <= 10000, 1);
        assert!(arg0.default_fee_bps != arg1, 4);
        arg0.default_fee_bps = arg1;
        let v0 = DefaultFeeBpsSetEvent{fee_bps: arg1};
        0x2::event::emit<DefaultFeeBpsSetEvent>(v0);
    }

    public(friend) fun set_fee_bps(arg0: &mut OFTFee, arg1: u32, arg2: u64) {
        assert!(arg2 <= 10000, 1);
        assert!(!0x2::table::contains<u32, u64>(&arg0.fee_bps, arg1) || *0x2::table::borrow<u32, u64>(&arg0.fee_bps, arg1) != arg2, 4);
        let v0 = &mut arg0.fee_bps;
        if (0x2::table::contains<u32, u64>(v0, arg1)) {
            *0x2::table::borrow_mut<u32, u64>(v0, arg1) = arg2;
        } else {
            0x2::table::add<u32, u64>(v0, arg1, arg2);
        };
        let v1 = FeeBpsSetEvent{
            dst_eid : arg1,
            fee_bps : arg2,
        };
        0x2::event::emit<FeeBpsSetEvent>(v1);
    }

    public(friend) fun set_fee_deposit_address(arg0: &mut OFTFee, arg1: address) {
        assert!(arg1 != @0x0, 2);
        assert!(arg0.fee_deposit_address != arg1, 4);
        arg0.fee_deposit_address = arg1;
        let v0 = FeeDepositAddressSetEvent{fee_deposit_address: arg1};
        0x2::event::emit<FeeDepositAddressSetEvent>(v0);
    }

    public(friend) fun unset_fee_bps(arg0: &mut OFTFee, arg1: u32) {
        assert!(0x2::table::contains<u32, u64>(&arg0.fee_bps, arg1), 3);
        0x2::table::remove<u32, u64>(&mut arg0.fee_bps, arg1);
        let v0 = FeeBpsUnsetEvent{dst_eid: arg1};
        0x2::event::emit<FeeBpsUnsetEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

