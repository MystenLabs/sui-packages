module 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::demand {
    struct Tips has copy, drop, store {
        tips: 0x1::string::String,
        who: address,
    }

    struct PresentEvent has copy, drop {
        object: address,
        service: address,
        tips: 0x1::string::String,
    }

    struct BountyEvent has copy, drop {
        object: address,
        service: address,
        presenter: address,
    }

    public fun BOUNTY_COUNT(arg0: u64) {
        assert!(arg0 < 300, 1200);
    }

    public fun BountyEvent_emit(arg0: &address, arg1: &address, arg2: &Tips) {
        let v0 = BountyEvent{
            object    : *arg0,
            service   : *arg1,
            presenter : arg2.who,
        };
        0x2::event::emit<BountyEvent>(v0);
    }

    public fun HAS_YES(arg0: &0x1::option::Option<address>) {
        assert!(0x1::option::is_none<address>(arg0), 1203);
    }

    public fun PRESENTERS_COUNT(arg0: u64) {
        assert!(arg0 < 200, 1202);
    }

    public fun PresentEvent_emit(arg0: &address, arg1: &address, arg2: &0x1::string::String) {
        let v0 = PresentEvent{
            object  : *arg0,
            service : *arg1,
            tips    : *arg2,
        };
        0x2::event::emit<PresentEvent>(v0);
    }

    public fun TIME_NOT_COIMINT(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0, 1201);
    }

    public fun Tips_new(arg0: &0x1::string::String, arg1: &address) : Tips {
        Tips{
            tips : *arg0,
            who  : *arg1,
        }
    }

    public fun Tips_set(arg0: &mut Tips, arg1: &0x1::string::String, arg2: &address) {
        if (arg0.who == *arg2) {
            arg0.tips = *arg1;
        };
    }

    public fun Tips_who(arg0: &Tips) : &address {
        &arg0.who
    }

    // decompiled from Move bytecode v6
}

