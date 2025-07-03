module 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins {
    struct Admins has store, key {
        id: 0x2::object::UID,
        admins: vector<address>,
    }

    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ADMINS has drop {
        dummy_field: bool,
    }

    public(friend) fun check_admin(arg0: &Admins, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0), 1);
    }

    public fun create_admin(arg0: &SuperAdminCap, arg1: &mut Admins, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x1::vector::contains<address>(&arg1.admins, &v0), 2);
        0x1::vector::push_back<address>(&mut arg1.admins, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: ADMINS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SuperAdminCap{id: 0x2::object::new(arg1)};
        let v1 = Admins{
            id     : 0x2::object::new(arg1),
            admins : 0x1::vector::empty<address>(),
        };
        0x1::vector::push_back<address>(&mut v1.admins, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<SuperAdminCap>(v0, @0x73e82e0c4c5f25a3607e4a58ce6b178c2ce77f568508fa65b03a9157d5144a1f);
        0x2::transfer::public_share_object<Admins>(v1);
    }

    // decompiled from Move bytecode v6
}

