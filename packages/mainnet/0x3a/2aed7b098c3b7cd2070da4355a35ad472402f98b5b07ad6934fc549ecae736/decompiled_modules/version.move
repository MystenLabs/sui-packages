module 0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::version {
    struct VERSION has drop {
        dummy_field: bool,
    }

    struct PaymentVerAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PaymentVersion has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
    }

    public fun checkVersion(arg0: &PaymentVersion, arg1: u64) {
        assert!(arg1 == arg0.version, 1001);
    }

    fun init(arg0: VERSION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PaymentVerAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<PaymentVerAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = PaymentVersion{
            id      : 0x2::object::new(arg1),
            version : 1,
            admin   : 0x2::object::id<PaymentVerAdminCap>(&v0),
        };
        0x2::transfer::share_object<PaymentVersion>(v1);
    }

    public entry fun migrate(arg0: &PaymentVerAdminCap, arg1: &mut PaymentVersion, arg2: u64) {
        assert!(0x2::object::id<PaymentVerAdminCap>(arg0) == arg1.admin, 1002);
        assert!(arg2 > arg1.version, 1001);
        arg1.version = arg2;
    }

    // decompiled from Move bytecode v6
}

