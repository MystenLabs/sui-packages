module 0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin {
    struct Admins has store, key {
        id: 0x2::object::UID,
        admins: 0x2::vec_set::VecSet<address>,
        amount_bp: u16,
    }

    struct ADMIN has drop {
        dummy_field: bool,
    }

    public fun add_address(arg0: &0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin_proof::AuthorizationProof, arg1: &mut Admins, arg2: address) {
        assert!(!0x2::vec_set::contains<address>(&arg1.admins, &arg2), 13906834359027105795);
        0x2::vec_set::insert<address>(&mut arg1.admins, arg2);
    }

    public fun get_aount_bp(arg0: &Admins) : u16 {
        arg0.amount_bp
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ADMIN>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = Admins{
            id        : 0x2::object::new(arg1),
            admins    : 0x2::vec_set::empty<address>(),
            amount_bp : 0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::default_bp(),
        };
        0x2::transfer::share_object<Admins>(v0);
    }

    public fun is_admin(arg0: &Admins, arg1: &address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, arg1)
    }

    public fun remove_address(arg0: &0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin_proof::AuthorizationProof, arg1: &mut Admins, arg2: &address) {
        assert!(!0x2::vec_set::is_empty<address>(&arg1.admins), 13906834384796778497);
        assert!(0x2::vec_set::contains<address>(&arg1.admins, arg2), 13906834389092007941);
        0x2::vec_set::remove<address>(&mut arg1.admins, arg2);
    }

    public fun set_amount_bp(arg0: &0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin_proof::AuthorizationProof, arg1: &mut Admins, arg2: u16) {
        assert!(0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::max_bp() >= arg2, 13906834432041811975);
        arg1.amount_bp = arg2;
    }

    // decompiled from Move bytecode v6
}

