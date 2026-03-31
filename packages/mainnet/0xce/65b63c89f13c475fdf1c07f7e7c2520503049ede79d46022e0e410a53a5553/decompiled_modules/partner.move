module 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner {
    struct Partner has store, key {
        id: 0x2::object::UID,
        address: address,
        fee_discount_bps: u64,
        is_active: bool,
    }

    struct PartnerCap has store, key {
        id: 0x2::object::UID,
        partner_id: 0x2::object::ID,
    }

    public(friend) fun create_partner(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (Partner, PartnerCap) {
        assert!(arg1 <= 10000, 1);
        let v0 = Partner{
            id               : 0x2::object::new(arg2),
            address          : arg0,
            fee_discount_bps : arg1,
            is_active        : true,
        };
        let v1 = PartnerCap{
            id         : 0x2::object::new(arg2),
            partner_id : 0x2::object::id<Partner>(&v0),
        };
        (v0, v1)
    }

    public(friend) fun get_fee_discount_bps(arg0: &Partner) : u64 {
        arg0.fee_discount_bps
    }

    public(friend) fun get_partner_id(arg0: &PartnerCap) : 0x2::object::ID {
        arg0.partner_id
    }

    public(friend) fun update_fee_discount_bps(arg0: &mut Partner, arg1: u64) {
        assert!(arg1 <= 10000, 1);
        arg0.fee_discount_bps = arg1;
    }

    public(friend) fun update_is_active(arg0: &mut Partner, arg1: bool) {
        arg0.is_active = arg1;
    }

    public(friend) fun validate_partner_address(arg0: &Partner, arg1: address) {
        assert!(arg0.is_active, 2);
        assert!(arg0.address == arg1, 0);
    }

    public(friend) fun validate_partner_is_active(arg0: &Partner) {
        assert!(arg0.is_active, 2);
    }

    // decompiled from Move bytecode v6
}

