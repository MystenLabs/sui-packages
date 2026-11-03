module 0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators {
    struct BLAST_FUN_MIGRATORS has drop {
        dummy_field: bool,
    }

    struct Publication has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        generation: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::operational_version::OperationalVersion<BLAST_FUN_MIGRATORS>,
    }

    struct PackageVersion has key {
        id: 0x2::object::UID,
        generation: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::operational_version::OperationalVersion<BLAST_FUN_MIGRATORS>,
    }

    public(friend) fun advance(arg0: &mut PackageVersion) {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::operational_version::advance<BLAST_FUN_MIGRATORS>(&mut arg0.generation, &arg0.id, 2);
    }

    public(friend) fun assert_current(arg0: &PackageVersion) {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::operational_version::assert_current<BLAST_FUN_MIGRATORS>(&arg0.generation, 1);
    }

    public(friend) fun assert_next(arg0: &PackageVersion) {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::operational_version::assert_next<BLAST_FUN_MIGRATORS>(&arg0.generation, 2);
    }

    public(friend) fun destroy(arg0: Publication) : (0x2::package::Publisher, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::operational_version::OperationalVersion<BLAST_FUN_MIGRATORS>) {
        let Publication {
            id         : v0,
            publisher  : v1,
            generation : v2,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2)
    }

    fun init(arg0: BLAST_FUN_MIGRATORS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Publication{
            id         : 0x2::object::new(arg1),
            publisher  : 0x2::package::claim<BLAST_FUN_MIGRATORS>(arg0, arg1),
            generation : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::operational_version::new<BLAST_FUN_MIGRATORS>(&arg0),
        };
        0x2::transfer::transfer<Publication>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun share_version(arg0: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::operational_version::OperationalVersion<BLAST_FUN_MIGRATORS>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PackageVersion{
            id         : 0x2::object::new(arg1),
            generation : arg0,
        };
        0x2::transfer::share_object<PackageVersion>(v0);
    }

    // decompiled from Move bytecode v7
}

