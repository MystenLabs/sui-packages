module 0x5526582a1ae9d3cdde47e3b9ec1a24c285a2edff70d750a4b973229e3ae7b5b5::blast_partners {
    struct PartnerAdmin {
        dummy_field: bool,
    }

    struct Partner has key {
        id: 0x2::object::UID,
        recipient: address,
        share_bps: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<u64>,
        cap_id: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<0x2::object::ID>,
    }

    struct PartnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct PartnerUpdated has copy, drop {
        partner_id: 0x2::object::ID,
        recipient: address,
        share_bps: u64,
        pending_share: 0x1::option::Option<0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<u64>>,
        cap_id: 0x2::object::ID,
        pending_cap: 0x1::option::Option<0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<0x2::object::ID>>,
    }

    struct PartnerPaid<phantom T0> has copy, drop {
        partner_id: 0x2::object::ID,
        amount: u64,
    }

    public fun apply_cap(arg0: &mut Partner, arg1: &0x2::clock::Clock) {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::apply<0x2::object::ID>(&mut arg0.cap_id, arg1);
        emit_updated(arg0);
    }

    public fun apply_share(arg0: &mut Partner, arg1: &0x2::clock::Clock) {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::apply<u64>(&mut arg0.share_bps, arg1);
        emit_updated(arg0);
    }

    public fun cancel_cap(arg0: &mut Partner, arg1: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<PartnerAdmin>) {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::cancel<0x2::object::ID>(&mut arg0.cap_id);
        emit_updated(arg0);
    }

    public fun cancel_share(arg0: &mut Partner, arg1: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<PartnerAdmin>) {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::cancel<u64>(&mut arg0.share_bps);
        emit_updated(arg0);
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
            partner_id    : 0x2::object::uid_to_inner(&arg0.id),
            recipient     : arg0.recipient,
            share_bps     : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<u64>(&arg0.share_bps),
            pending_share : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::pending<u64>(&arg0.share_bps),
            cap_id        : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<0x2::object::ID>(&arg0.cap_id),
            pending_cap   : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::pending<0x2::object::ID>(&arg0.cap_id),
        };
        0x2::event::emit<PartnerUpdated>(v0);
    }

    public fun new_cap(arg0: &mut 0x2::tx_context::TxContext) : PartnerCap {
        PartnerCap{id: 0x2::object::new(arg0)}
    }

    public fun pay<T0>(arg0: &Partner, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::u64::mul_div(0x2::balance::value<T0>(arg1), 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<u64>(&arg0.share_bps), 10000);
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

    public fun register(arg0: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<PartnerAdmin>, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 13835058312980398084);
        assert!(arg3 <= 8000, 13835339792252207110);
        let v0 = Partner{
            id        : 0x2::object::new(arg4),
            recipient : arg2,
            share_bps : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::new<u64>(arg3, 604800000),
            cap_id    : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::new<0x2::object::ID>(arg1, 604800000),
        };
        emit_updated(&v0);
        0x2::transfer::share_object<Partner>(v0);
    }

    public fun schedule_cap(arg0: &mut Partner, arg1: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<PartnerAdmin>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::pending<0x2::object::ID>(&arg0.cap_id);
        assert!(arg2 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<0x2::object::ID>(&arg0.cap_id), 13835621503452250120);
        assert!(!0x1::option::is_some<0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<0x2::object::ID>>(&v0) || 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::pending_value<0x2::object::ID>(0x1::option::borrow<0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<0x2::object::ID>>(&v0)) != arg2, 13835621507747217416);
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::schedule_value<0x2::object::ID>(&mut arg0.cap_id, arg2, arg3);
        emit_updated(arg0);
    }

    public fun schedule_share(arg0: &mut Partner, arg1: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<PartnerAdmin>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg2 <= 8000, 13835339891036454918);
        let v0 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::pending<u64>(&arg0.share_bps);
        assert!(arg2 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<u64>(&arg0.share_bps), 13835621374603231240);
        assert!(!0x1::option::is_some<0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<u64>>(&v0) || 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::pending_value<u64>(0x1::option::borrow<0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<u64>>(&v0)) != arg2, 13835621378898198536);
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::schedule_value<u64>(&mut arg0.share_bps, arg2, arg3);
        emit_updated(arg0);
    }

    public fun set_recipient(arg0: &mut Partner, arg1: &PartnerCap, arg2: address) {
        assert!(0x2::object::uid_to_inner(&arg1.id) == 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<0x2::object::ID>(&arg0.cap_id), 13835903072918372362);
        assert!(arg2 != @0x0, 13835058652282814468);
        assert!(arg2 != arg0.recipient, 13835621606531465224);
        arg0.recipient = arg2;
        emit_updated(arg0);
    }

    // decompiled from Move bytecode v7
}

