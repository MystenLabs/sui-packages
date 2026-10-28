module 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators {
    struct BLAST_FUN_MIGRATORS has drop {
        dummy_field: bool,
    }

    struct PackageVersion has key {
        id: 0x2::object::UID,
        generation: 0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::operational_version::OperationalVersion<BLAST_FUN_MIGRATORS>,
    }

    fun new(arg0: &BLAST_FUN_MIGRATORS, arg1: &mut 0x2::tx_context::TxContext) : PackageVersion {
        PackageVersion{
            id         : 0x2::object::new(arg1),
            generation : 0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::operational_version::new<BLAST_FUN_MIGRATORS>(arg0),
        }
    }

    public(friend) fun advance(arg0: &mut PackageVersion) {
        0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::operational_version::advance<BLAST_FUN_MIGRATORS>(&mut arg0.generation, &arg0.id, 2);
    }

    public(friend) fun assert_current(arg0: &PackageVersion) {
        0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::operational_version::assert_current<BLAST_FUN_MIGRATORS>(&arg0.generation, 1);
    }

    public(friend) fun assert_next(arg0: &PackageVersion) {
        0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::operational_version::assert_next<BLAST_FUN_MIGRATORS>(&arg0.generation, 2);
    }

    fun init(arg0: BLAST_FUN_MIGRATORS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new(&arg0, arg1);
        0x2::transfer::share_object<PackageVersion>(v0);
        0x2::package::claim_and_keep<BLAST_FUN_MIGRATORS>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

