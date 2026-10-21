module 0x1027f94afc3820d4c00b043fc6eb44061fb79d9022acfdd6ac87c464e590ecdc::blast_presale_package {
    struct BLAST_PRESALE_PACKAGE has drop {
        dummy_field: bool,
    }

    struct Bootstrap has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        generation: 0x5ee566d3a7925b47d1f532ced047bd8e4d970864ed1cb639eef9b8efdb2ae380::operational_version::OperationalVersion<BLAST_PRESALE_PACKAGE>,
    }

    struct PackageVersion has key {
        id: 0x2::object::UID,
        generation: 0x5ee566d3a7925b47d1f532ced047bd8e4d970864ed1cb639eef9b8efdb2ae380::operational_version::OperationalVersion<BLAST_PRESALE_PACKAGE>,
    }

    public(friend) fun advance(arg0: &mut PackageVersion) {
        0x5ee566d3a7925b47d1f532ced047bd8e4d970864ed1cb639eef9b8efdb2ae380::operational_version::advance<BLAST_PRESALE_PACKAGE>(&mut arg0.generation, &arg0.id, 2);
    }

    public(friend) fun assert_current(arg0: &PackageVersion) {
        0x5ee566d3a7925b47d1f532ced047bd8e4d970864ed1cb639eef9b8efdb2ae380::operational_version::assert_current<BLAST_PRESALE_PACKAGE>(&arg0.generation, 1);
    }

    public(friend) fun assert_next(arg0: &PackageVersion) {
        0x5ee566d3a7925b47d1f532ced047bd8e4d970864ed1cb639eef9b8efdb2ae380::operational_version::assert_next<BLAST_PRESALE_PACKAGE>(&arg0.generation, 2);
    }

    public(friend) fun destroy(arg0: Bootstrap) : (0x2::package::Publisher, 0x5ee566d3a7925b47d1f532ced047bd8e4d970864ed1cb639eef9b8efdb2ae380::operational_version::OperationalVersion<BLAST_PRESALE_PACKAGE>) {
        let Bootstrap {
            id         : v0,
            publisher  : v1,
            generation : v2,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2)
    }

    fun init(arg0: BLAST_PRESALE_PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Bootstrap{
            id         : 0x2::object::new(arg1),
            publisher  : 0x2::package::claim<BLAST_PRESALE_PACKAGE>(arg0, arg1),
            generation : 0x5ee566d3a7925b47d1f532ced047bd8e4d970864ed1cb639eef9b8efdb2ae380::operational_version::new<BLAST_PRESALE_PACKAGE>(&arg0),
        };
        0x2::transfer::transfer<Bootstrap>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun share_version(arg0: 0x5ee566d3a7925b47d1f532ced047bd8e4d970864ed1cb639eef9b8efdb2ae380::operational_version::OperationalVersion<BLAST_PRESALE_PACKAGE>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PackageVersion{
            id         : 0x2::object::new(arg1),
            generation : arg0,
        };
        0x2::transfer::share_object<PackageVersion>(v0);
    }

    // decompiled from Move bytecode v7
}

