module 0x96fbe2db7337dea5ef6926203d32cf602e527d5e2dcae176fbbc3e3d2a30d94f::blast_partners {
    struct PartnerAdmin {
        dummy_field: bool,
    }

    struct Partner has key {
        id: 0x2::object::UID,
        recipient: address,
        share_bps: 0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::Timelocked<u64>,
        cap_id: 0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::Timelocked<0x2::object::ID>,
    }

    struct PartnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct PartnerUpdated has copy, drop {
        partner_id: 0x2::object::ID,
        recipient: address,
        share_bps: 0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::Timelocked<u64>,
        cap_id: 0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::Timelocked<0x2::object::ID>,
    }

    struct PartnerPaid<phantom T0> has copy, drop {
        partner_id: 0x2::object::ID,
        amount: u64,
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
            share_bps  : arg0.share_bps,
            cap_id     : arg0.cap_id,
        };
        0x2::event::emit<PartnerUpdated>(v0);
    }

    public fun new_cap(arg0: &mut 0x2::tx_context::TxContext) : PartnerCap {
        PartnerCap{id: 0x2::object::new(arg0)}
    }

    public fun pay<T0>(arg0: &Partner, arg1: &mut 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::u64::mul_div(0x2::balance::value<T0>(arg1), 0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::value<u64>(&arg0.share_bps, arg2), 10000);
        if (v0 > 0) {
            0x2::balance::send_funds<T0>(0x2::balance::split<T0>(arg1, v0), arg0.recipient);
            let v1 = PartnerPaid<T0>{
                partner_id : 0x2::object::uid_to_inner(&arg0.id),
                amount     : v0,
            };
            0x2::event::emit<PartnerPaid<T0>>(v1);
        };
        v0
    }

    public fun register(arg0: &0x726fb49b880faa89719b95c6ef3a91be794f771ed3560fe5894d0a605c8469f9::blast_acl::AdminWitness<PartnerAdmin>, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 13835058312980398084);
        assert!(arg3 <= 8000, 13835339792252207110);
        let v0 = Partner{
            id        : 0x2::object::new(arg4),
            recipient : arg2,
            share_bps : 0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::new<u64>(arg3, 604800000),
            cap_id    : 0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::new<0x2::object::ID>(arg1, 604800000),
        };
        emit_updated(&v0);
        0x2::transfer::share_object<Partner>(v0);
    }

    public fun schedule_cap(arg0: &mut Partner, arg1: &0x726fb49b880faa89719b95c6ef3a91be794f771ed3560fe5894d0a605c8469f9::blast_acl::AdminWitness<PartnerAdmin>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert!(arg2 != 0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::scheduled<0x2::object::ID>(&arg0.cap_id), 13835621443322707976);
        0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::schedule<0x2::object::ID>(&mut arg0.cap_id, arg2, arg3);
        emit_updated(arg0);
    }

    public fun schedule_share(arg0: &mut Partner, arg1: &0x726fb49b880faa89719b95c6ef3a91be794f771ed3560fe5894d0a605c8469f9::blast_acl::AdminWitness<PartnerAdmin>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg2 <= 8000, 13835339891036454918);
        assert!(arg2 != 0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::scheduled<u64>(&arg0.share_bps), 13835621370308263944);
        0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::schedule<u64>(&mut arg0.share_bps, arg2, arg3);
        emit_updated(arg0);
    }

    public fun set_recipient(arg0: &mut Partner, arg1: &PartnerCap, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(0x2::object::uid_to_inner(&arg1.id) == 0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::value<0x2::object::ID>(&arg0.cap_id, arg3), 13835902956954255370);
        assert!(arg2 != @0x0, 13835058536318697476);
        assert!(arg2 != arg0.recipient, 13835621490567348232);
        arg0.recipient = arg2;
        emit_updated(arg0);
    }

    // decompiled from Move bytecode v7
}

