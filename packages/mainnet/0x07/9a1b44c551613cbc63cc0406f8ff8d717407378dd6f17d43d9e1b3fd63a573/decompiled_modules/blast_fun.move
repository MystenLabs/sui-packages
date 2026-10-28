module 0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::blast_fun {
    struct BLAST_FUN has drop {
        dummy_field: bool,
    }

    struct Bootstrap has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        generation: 0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::operational_version::OperationalVersion<BLAST_FUN>,
    }

    struct PackageVersion has key {
        id: 0x2::object::UID,
        generation: 0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::operational_version::OperationalVersion<BLAST_FUN>,
    }

    public(friend) fun advance(arg0: &mut PackageVersion) {
        0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::operational_version::advance<BLAST_FUN>(&mut arg0.generation, &arg0.id, 2);
    }

    public(friend) fun assert_current(arg0: &PackageVersion) {
        0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::operational_version::assert_current<BLAST_FUN>(&arg0.generation, 1);
    }

    public(friend) fun assert_next(arg0: &PackageVersion) {
        0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::operational_version::assert_next<BLAST_FUN>(&arg0.generation, 2);
    }

    public(friend) fun destroy(arg0: Bootstrap) : (0x2::package::Publisher, 0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::operational_version::OperationalVersion<BLAST_FUN>) {
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
            generation : 0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::operational_version::new<BLAST_FUN>(&arg0),
        };
        0x2::transfer::transfer<Bootstrap>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun share_version(arg0: 0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::operational_version::OperationalVersion<BLAST_FUN>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PackageVersion{
            id         : 0x2::object::new(arg1),
            generation : arg0,
        };
        0x2::transfer::share_object<PackageVersion>(v0);
    }

    // decompiled from Move bytecode v7
}

