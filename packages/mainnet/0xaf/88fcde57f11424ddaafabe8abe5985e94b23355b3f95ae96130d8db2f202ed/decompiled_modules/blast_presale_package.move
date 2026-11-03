module 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package {
    struct Paused has copy, drop {
        bits: u8,
        paused: u8,
    }

    struct Unpaused has copy, drop {
        bits: u8,
        paused: u8,
    }

    struct BLAST_PRESALE_PACKAGE has drop {
        dummy_field: bool,
    }

    struct Publication has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        generation: 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::operational_version::OperationalVersion<BLAST_PRESALE_PACKAGE>,
    }

    struct PackageVersion has key {
        id: 0x2::object::UID,
        paused: u8,
        generation: 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::operational_version::OperationalVersion<BLAST_PRESALE_PACKAGE>,
    }

    public(friend) fun advance(arg0: &mut PackageVersion) {
        0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::operational_version::advance<BLAST_PRESALE_PACKAGE>(&mut arg0.generation, &arg0.id, 2);
    }

    public(friend) fun assert_current(arg0: &PackageVersion) {
        0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::operational_version::assert_current<BLAST_PRESALE_PACKAGE>(&arg0.generation, 1);
    }

    public(friend) fun assert_next(arg0: &PackageVersion) {
        0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::operational_version::assert_next<BLAST_PRESALE_PACKAGE>(&arg0.generation, 2);
    }

    public(friend) fun assert_not_paused(arg0: &PackageVersion, arg1: u8) {
        assert!(arg0.paused & arg1 == 0, 13835621378898198536);
    }

    public(friend) fun destroy(arg0: Publication) : (0x2::package::Publisher, 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::operational_version::OperationalVersion<BLAST_PRESALE_PACKAGE>) {
        let Publication {
            id         : v0,
            publisher  : v1,
            generation : v2,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2)
    }

    fun init(arg0: BLAST_PRESALE_PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Publication{
            id         : 0x2::object::new(arg1),
            publisher  : 0x2::package::claim<BLAST_PRESALE_PACKAGE>(arg0, arg1),
            generation : 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::operational_version::new<BLAST_PRESALE_PACKAGE>(&arg0),
        };
        0x2::transfer::transfer<Publication>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun pause(arg0: &mut PackageVersion, arg1: &0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::blast_acl::AdminWitness<0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_domain::PauseAdmin>, arg2: u8) {
        assert_current(arg0);
        assert!(arg2 != 0 && arg2 & 11 == arg2, 13835058334455234564);
        assert!(arg0.paused | arg2 != arg0.paused, 13835339813727043590);
        arg0.paused = arg0.paused | arg2;
        let v0 = Paused{
            bits   : arg2,
            paused : arg0.paused,
        };
        0x2::event::emit<Paused>(v0);
    }

    public(friend) fun share_version(arg0: 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::operational_version::OperationalVersion<BLAST_PRESALE_PACKAGE>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PackageVersion{
            id         : 0x2::object::new(arg1),
            paused     : 11,
            generation : arg0,
        };
        0x2::transfer::share_object<PackageVersion>(v0);
    }

    public fun unpause(arg0: &mut PackageVersion, arg1: &0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::blast_acl::AdminWitness<0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_domain::UnpauseAdmin>, arg2: u8) {
        assert_current(arg0);
        assert!(arg2 != 0 && arg2 & 11 == arg2, 13835058381699874820);
        assert!(arg0.paused & arg2 != 0, 13835339860971683846);
        arg0.paused = arg0.paused ^ arg0.paused & arg2;
        let v0 = Unpaused{
            bits   : arg2,
            paused : arg0.paused,
        };
        0x2::event::emit<Unpaused>(v0);
    }

    // decompiled from Move bytecode v7
}

