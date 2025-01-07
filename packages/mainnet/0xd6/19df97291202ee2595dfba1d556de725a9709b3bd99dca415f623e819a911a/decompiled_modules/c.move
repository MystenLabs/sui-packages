module 0xd619df97291202ee2595dfba1d556de725a9709b3bd99dca415f623e819a911a::c {
    struct A has store, key {
        id: 0x2::object::UID,
    }

    struct G has store, key {
        id: 0x2::object::UID,
        a: 0xd619df97291202ee2595dfba1d556de725a9709b3bd99dca415f623e819a911a::a::A,
        pfa: u64,
        v: u64,
        pf: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct IE has copy, drop {
        gi: 0x2::object::ID,
        ai: 0x2::object::ID,
    }

    struct SRE has copy, drop {
        m: address,
        r: u128,
    }

    struct ARE has copy, drop {
        m: address,
        r: u8,
    }

    struct RRE has copy, drop {
        m: address,
        r: u8,
    }

    struct RME has copy, drop {
        m: address,
    }

    public fun rm(arg0: &A, arg1: &mut G, arg2: address) {
        cv(arg1);
        0xd619df97291202ee2595dfba1d556de725a9709b3bd99dca415f623e819a911a::a::rm(&mut arg1.a, arg2);
        let v0 = RME{m: arg2};
        0x2::event::emit<RME>(v0);
    }

    public fun ar(arg0: &A, arg1: &mut G, arg2: address, arg3: u8) {
        cv(arg1);
        0xd619df97291202ee2595dfba1d556de725a9709b3bd99dca415f623e819a911a::a::a(&mut arg1.a, arg2, arg3);
        let v0 = ARE{
            m : arg2,
            r : arg3,
        };
        0x2::event::emit<ARE>(v0);
    }

    public fun ca1(arg0: &G, arg1: address) {
        assert!(0xd619df97291202ee2595dfba1d556de725a9709b3bd99dca415f623e819a911a::a::h(&arg0.a, arg1, 1), 0);
    }

    public fun cv(arg0: &G) {
        assert!(1 >= arg0.v, 0);
    }

    public fun gm(arg0: &G) : vector<0xd619df97291202ee2595dfba1d556de725a9709b3bd99dca415f623e819a911a::a::M> {
        0xd619df97291202ee2595dfba1d556de725a9709b3bd99dca415f623e819a911a::a::g(&arg0.a)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = G{
            id  : 0x2::object::new(arg0),
            a   : 0xd619df97291202ee2595dfba1d556de725a9709b3bd99dca415f623e819a911a::a::new(arg0),
            pfa : 100000000000,
            v   : 1,
            pf  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = A{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<A>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<G>(v0);
        let v2 = IE{
            gi : 0x2::object::id<G>(&v0),
            ai : 0x2::object::id<A>(&v1),
        };
        0x2::event::emit<IE>(v2);
    }

    public fun rr(arg0: &A, arg1: &mut G, arg2: address, arg3: u8) {
        cv(arg1);
        0xd619df97291202ee2595dfba1d556de725a9709b3bd99dca415f623e819a911a::a::r(&mut arg1.a, arg2, arg3);
        let v0 = RRE{
            m : arg2,
            r : arg3,
        };
        0x2::event::emit<RRE>(v0);
    }

    public fun sr(arg0: &A, arg1: &mut G, arg2: address, arg3: u128) {
        cv(arg1);
        0xd619df97291202ee2595dfba1d556de725a9709b3bd99dca415f623e819a911a::a::s(&mut arg1.a, arg2, arg3);
        let v0 = SRE{
            m : arg2,
            r : arg3,
        };
        0x2::event::emit<SRE>(v0);
    }

    // decompiled from Move bytecode v6
}

