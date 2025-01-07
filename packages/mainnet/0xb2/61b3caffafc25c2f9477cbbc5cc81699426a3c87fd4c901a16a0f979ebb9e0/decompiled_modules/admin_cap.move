module 0xb261b3caffafc25c2f9477cbbc5cc81699426a3c87fd4c901a16a0f979ebb9e0::admin_cap {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PartnerPolicy has store, key {
        id: 0x2::object::UID,
        partner_id: 0x1::string::String,
        partner_recipient_address: address,
        umi_recipient_address: address,
        fee_bps: u64,
        partner_fee_ratio_bps: u64,
    }

    public fun create_admin_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public fun create_partner_policy(arg0: &AdminCap, arg1: 0x1::string::String, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 <= 10000, 2);
        assert!(arg5 <= 10000, 3);
        assert!(arg5 <= arg4, 4);
        let v0 = PartnerPolicy{
            id                        : 0x2::object::new(arg6),
            partner_id                : arg1,
            partner_recipient_address : arg2,
            umi_recipient_address     : arg3,
            fee_bps                   : arg4,
            partner_fee_ratio_bps     : arg5,
        };
        0x2::transfer::public_share_object<PartnerPolicy>(v0);
    }

    public fun get_partner_info(arg0: &PartnerPolicy) : (0x1::string::String, address, address, u64, u64) {
        (arg0.partner_id, arg0.partner_recipient_address, arg0.umi_recipient_address, arg0.fee_bps, arg0.partner_fee_ratio_bps)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun update_partner_policy(arg0: &AdminCap, arg1: &mut PartnerPolicy, arg2: address, arg3: address, arg4: u64, arg5: u64) {
        assert!(arg4 <= 10000, 2);
        assert!(arg5 <= 10000, 3);
        assert!(arg5 <= arg4, 4);
        arg1.partner_recipient_address = arg2;
        arg1.umi_recipient_address = arg3;
        arg1.fee_bps = arg4;
        arg1.partner_fee_ratio_bps = arg5;
    }

    // decompiled from Move bytecode v6
}

