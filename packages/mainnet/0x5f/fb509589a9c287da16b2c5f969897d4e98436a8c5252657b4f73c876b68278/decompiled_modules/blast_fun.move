module 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun {
    struct BLAST_FUN has drop {
        dummy_field: bool,
    }

    struct Bootstrap has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        generation: 0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::operational_version::OperationalVersion<BLAST_FUN>,
    }

    struct PackageVersion has key {
        id: 0x2::object::UID,
        generation: 0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::operational_version::OperationalVersion<BLAST_FUN>,
    }

    public(friend) fun advance(arg0: &mut PackageVersion) {
        0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::operational_version::advance<BLAST_FUN>(&mut arg0.generation, &arg0.id, 2);
    }

    public(friend) fun assert_current(arg0: &PackageVersion) {
        0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::operational_version::assert_current<BLAST_FUN>(&arg0.generation, 1);
    }

    public(friend) fun assert_next(arg0: &PackageVersion) {
        0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::operational_version::assert_next<BLAST_FUN>(&arg0.generation, 2);
    }

    public(friend) fun destroy(arg0: Bootstrap) : (0x2::package::Publisher, 0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::operational_version::OperationalVersion<BLAST_FUN>) {
        let Bootstrap {
            id         : v0,
            publisher  : v1,
            generation : v2,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2)
    }

    fun init(arg0: BLAST_FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Bootstrap{
            id         : 0x2::object::new(arg1),
            publisher  : 0x2::package::claim<BLAST_FUN>(arg0, arg1),
            generation : 0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::operational_version::new<BLAST_FUN>(&arg0),
        };
        0x2::transfer::transfer<Bootstrap>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun share_version(arg0: 0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::operational_version::OperationalVersion<BLAST_FUN>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PackageVersion{
            id         : 0x2::object::new(arg1),
            generation : arg0,
        };
        0x2::transfer::share_object<PackageVersion>(v0);
    }

    // decompiled from Move bytecode v7
}

