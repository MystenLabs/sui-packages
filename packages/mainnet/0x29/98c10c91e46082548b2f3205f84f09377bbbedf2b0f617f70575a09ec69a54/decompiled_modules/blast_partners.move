module 0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::blast_partners {
    struct PartnerAdmin {
        dummy_field: bool,
    }

    struct Partner has key {
        id: 0x2::object::UID,
        recipient: address,
        share_bps: 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Delayed<ShareKey, u64>,
        cap_id: 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Delayed<CapKey, 0x2::object::ID>,
    }

    struct ShareKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PartnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct PartnerUpdated has copy, drop {
        partner_id: 0x2::object::ID,
        recipient: address,
    }

    struct PartnerPaid<phantom T0> has copy, drop {
        partner_id: 0x2::object::ID,
        amount: u64,
    }

    fun new(arg0: address, arg1: u64, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : Partner {
        let v0 = 0x2::object::new(arg3);
        let v1 = ShareKey{dummy_field: false};
        let v2 = CapKey{dummy_field: false};
        Partner{
            id        : v0,
            recipient : arg0,
            share_bps : 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::new<ShareKey, u64>(v1, &v0, arg1, 604800000),
            cap_id    : 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::new<CapKey, 0x2::object::ID>(v2, &v0, arg2, 604800000),
        }
    }

    public fun apply_cap(arg0: &mut Partner, arg1: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::apply<CapKey, 0x2::object::ID>(&mut arg0.cap_id, arg1);
    }

    public fun apply_share(arg0: &mut Partner, arg1: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::apply<ShareKey, u64>(&mut arg0.share_bps, arg1);
    }

    public fun cancel_cap(arg0: &mut Partner, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<PartnerAdmin>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::cancel<CapKey, 0x2::object::ID>(&mut arg0.cap_id);
    }

    public fun cancel_share(arg0: &mut Partner, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<PartnerAdmin>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::cancel<ShareKey, u64>(&mut arg0.share_bps);
    }

    public fun cap_id(arg0: &Partner) : 0x2::object::ID {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::value<CapKey, 0x2::object::ID>(&arg0.cap_id)
    }

    public fun delay_ms() : u64 {
        604800000
    }

    public fun destroy_cap(arg0: PartnerCap) {
        let PartnerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun emit_updated(arg0: &Partner) {
        let v0 = PartnerUpdated{
            partner_id : 0x2::object::uid_to_inner(&arg0.id),
            recipient  : arg0.recipient,
        };
        0x2::event::emit<PartnerUpdated>(v0);
    }

    public fun is_cap_ready(arg0: &Partner, arg1: &0x2::clock::Clock) : bool {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::is_ready<CapKey, 0x2::object::ID>(&arg0.cap_id, arg1)
    }

    public fun is_share_ready(arg0: &Partner, arg1: &0x2::clock::Clock) : bool {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::is_ready<ShareKey, u64>(&arg0.share_bps, arg1)
    }

    public fun max_share_bps() : u64 {
        8000
    }

    public fun new_cap(arg0: &mut 0x2::tx_context::TxContext) : PartnerCap {
        PartnerCap{id: 0x2::object::new(arg0)}
    }

    public fun pay<T0>(arg0: &Partner, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::u64::mul_div(0x2::balance::value<T0>(arg1), 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::value<ShareKey, u64>(&arg0.share_bps), 10000);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg1, v0), arg2), arg0.recipient);
            let v1 = PartnerPaid<T0>{
                partner_id : 0x2::object::uid_to_inner(&arg0.id),
                amount     : v0,
            };
            0x2::event::emit<PartnerPaid<T0>>(v1);
        };
        v0
    }

    public fun pending_cap_id(arg0: &Partner) : 0x1::option::Option<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Proposal<0x2::object::ID>> {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::pending<CapKey, 0x2::object::ID>(&arg0.cap_id)
    }

    public fun pending_share_bps(arg0: &Partner) : 0x1::option::Option<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Proposal<u64>> {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::pending<ShareKey, u64>(&arg0.share_bps)
    }

    public fun recipient(arg0: &Partner) : address {
        arg0.recipient
    }

    public fun register(arg0: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<PartnerAdmin>, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 0);
        assert!(arg3 <= 8000, 1);
        let v0 = new(arg2, arg3, arg1, arg4);
        emit_updated(&v0);
        0x2::transfer::share_object<Partner>(v0);
    }

    public fun schedule_cap(arg0: &mut Partner, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<PartnerAdmin>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::pending<CapKey, 0x2::object::ID>(&arg0.cap_id);
        let v1 = &v0;
        let v2 = 0x1::option::is_some<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Proposal<0x2::object::ID>>(v1) && 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::proposal_value<0x2::object::ID>(0x1::option::borrow<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Proposal<0x2::object::ID>>(v1)) == arg2;
        assert!(!v2, 2);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::schedule_value<CapKey, 0x2::object::ID>(&mut arg0.cap_id, arg2, arg3);
    }

    public fun schedule_share(arg0: &mut Partner, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<PartnerAdmin>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg2 <= 8000, 1);
        let v0 = 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::pending<ShareKey, u64>(&arg0.share_bps);
        let v1 = &v0;
        let v2 = 0x1::option::is_some<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Proposal<u64>>(v1) && 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::proposal_value<u64>(0x1::option::borrow<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Proposal<u64>>(v1)) == arg2;
        assert!(!v2, 2);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::schedule_value<ShareKey, u64>(&mut arg0.share_bps, arg2, arg3);
    }

    public fun set_recipient(arg0: &mut Partner, arg1: &PartnerCap, arg2: address) {
        assert!(0x2::object::uid_to_inner(&arg1.id) == 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::value<CapKey, 0x2::object::ID>(&arg0.cap_id), 3);
        assert!(arg2 != @0x0, 0);
        assert!(arg2 != arg0.recipient, 2);
        arg0.recipient = arg2;
        emit_updated(arg0);
    }

    public fun share_bps(arg0: &Partner) : u64 {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::value<ShareKey, u64>(&arg0.share_bps)
    }

    // decompiled from Move bytecode v7
}

