module 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun {
    struct BLAST_FUN has drop {
        dummy_field: bool,
    }

    struct Publication has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        generation: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::operational_version::OperationalVersion<BLAST_FUN>,
    }

    struct PackageVersion has key {
        id: 0x2::object::UID,
        paused: u8,
        generation: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::operational_version::OperationalVersion<BLAST_FUN>,
    }

    public(friend) fun advance(arg0: &mut PackageVersion) {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::operational_version::advance<BLAST_FUN>(&mut arg0.generation, &arg0.id, 2);
    }

    public(friend) fun assert_current(arg0: &PackageVersion) {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::operational_version::assert_current<BLAST_FUN>(&arg0.generation, 1);
    }

    public(friend) fun assert_next(arg0: &PackageVersion) {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::operational_version::assert_next<BLAST_FUN>(&arg0.generation, 2);
    }

    public(friend) fun assert_not_paused(arg0: &PackageVersion, arg1: u8) {
        assert!(arg0.paused & arg1 == 0, 40);
    }

    public(friend) fun destroy(arg0: Publication) : (0x2::package::Publisher, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::operational_version::OperationalVersion<BLAST_FUN>) {
        let Publication {
            id         : v0,
            publisher  : v1,
            generation : v2,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2)
    }

    fun init(arg0: BLAST_FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Publication{
            id         : 0x2::object::new(arg1),
            publisher  : 0x2::package::claim<BLAST_FUN>(arg0, arg1),
            generation : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::operational_version::new<BLAST_FUN>(&arg0),
        };
        0x2::transfer::transfer<Publication>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun pause(arg0: &mut PackageVersion, arg1: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::PauseAdmin>, arg2: u8) {
        assert_current(arg0);
        assert!(arg2 != 0 && arg2 & 7 == arg2, 38);
        assert!(arg0.paused | arg2 != arg0.paused, 39);
        arg0.paused = arg0.paused | arg2;
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::paused(arg2, arg0.paused);
    }

    public(friend) fun share_version(arg0: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::operational_version::OperationalVersion<BLAST_FUN>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PackageVersion{
            id         : 0x2::object::new(arg1),
            paused     : 7,
            generation : arg0,
        };
        0x2::transfer::share_object<PackageVersion>(v0);
    }

    public fun unpause(arg0: &mut PackageVersion, arg1: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::UnpauseAdmin>, arg2: u8) {
        assert_current(arg0);
        assert!(arg2 != 0 && arg2 & 7 == arg2, 38);
        assert!(arg0.paused & arg2 != 0, 39);
        arg0.paused = arg0.paused ^ arg0.paused & arg2;
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::unpaused(arg2, arg0.paused);
    }

    // decompiled from Move bytecode v7
}

