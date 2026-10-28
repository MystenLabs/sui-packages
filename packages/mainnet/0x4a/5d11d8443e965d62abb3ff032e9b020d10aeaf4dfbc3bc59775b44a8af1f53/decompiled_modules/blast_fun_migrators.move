module 0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_fun_migrators {
    struct BLAST_FUN_MIGRATORS has drop {
        dummy_field: bool,
    }

    struct PackageVersion has key {
        id: 0x2::object::UID,
        generation: 0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::operational_version::OperationalVersion<BLAST_FUN_MIGRATORS>,
    }

    fun new(arg0: &BLAST_FUN_MIGRATORS, arg1: &mut 0x2::tx_context::TxContext) : PackageVersion {
        PackageVersion{
            id         : 0x2::object::new(arg1),
            generation : 0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::operational_version::new<BLAST_FUN_MIGRATORS>(arg0),
        }
    }

    public(friend) fun advance(arg0: &mut PackageVersion) {
        0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::operational_version::advance<BLAST_FUN_MIGRATORS>(&mut arg0.generation, &arg0.id, 2);
    }

    public(friend) fun assert_current(arg0: &PackageVersion) {
        0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::operational_version::assert_current<BLAST_FUN_MIGRATORS>(&arg0.generation, 1);
    }

    public(friend) fun assert_next(arg0: &PackageVersion) {
        0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::operational_version::assert_next<BLAST_FUN_MIGRATORS>(&arg0.generation, 2);
    }

    fun init(arg0: BLAST_FUN_MIGRATORS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new(&arg0, arg1);
        0x2::transfer::share_object<PackageVersion>(v0);
        0x2::package::claim_and_keep<BLAST_FUN_MIGRATORS>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

