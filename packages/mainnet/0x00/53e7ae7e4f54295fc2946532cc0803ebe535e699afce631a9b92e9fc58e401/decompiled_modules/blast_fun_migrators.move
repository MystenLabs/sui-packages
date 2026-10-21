module 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::blast_fun_migrators {
    struct BLAST_FUN_MIGRATORS has drop {
        dummy_field: bool,
    }

    struct PackageVersion has key {
        id: 0x2::object::UID,
        generation: 0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::operational_version::OperationalVersion<BLAST_FUN_MIGRATORS>,
    }

    fun new(arg0: &BLAST_FUN_MIGRATORS, arg1: &mut 0x2::tx_context::TxContext) : PackageVersion {
        PackageVersion{
            id         : 0x2::object::new(arg1),
            generation : 0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::operational_version::new<BLAST_FUN_MIGRATORS>(arg0),
        }
    }

    public(friend) fun advance(arg0: &mut PackageVersion) {
        0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::operational_version::advance<BLAST_FUN_MIGRATORS>(&mut arg0.generation, &arg0.id, 2);
    }

    public(friend) fun assert_current(arg0: &PackageVersion) {
        0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::operational_version::assert_current<BLAST_FUN_MIGRATORS>(&arg0.generation, 1);
    }

    public(friend) fun assert_next(arg0: &PackageVersion) {
        0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::operational_version::assert_next<BLAST_FUN_MIGRATORS>(&arg0.generation, 2);
    }

    fun init(arg0: BLAST_FUN_MIGRATORS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new(&arg0, arg1);
        0x2::transfer::share_object<PackageVersion>(v0);
        0x2::package::claim_and_keep<BLAST_FUN_MIGRATORS>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

