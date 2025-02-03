module 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace {
    struct MembersDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Marketplace has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        receiver: address,
        default_fee: 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::object_box::ObjectBox,
    }

    public fun new<T0: store + key>(arg0: address, arg1: address, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) : Marketplace {
        Marketplace{
            id          : 0x2::object::new(arg3),
            version     : 3,
            admin       : arg0,
            receiver    : arg1,
            default_fee : 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::object_box::new<T0>(arg2, arg3),
        }
    }

    public entry fun add_member(arg0: &mut Marketplace, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        assert_marketplace_admin(arg0, arg2);
        let v0 = MembersDfKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<MembersDfKey>(&mut arg0.id, v0)) {
            let v1 = MembersDfKey{dummy_field: false};
            0x2::vec_set::insert<address>(0x2::dynamic_field::borrow_mut<MembersDfKey, 0x2::vec_set::VecSet<address>>(&mut arg0.id, v1), arg1);
        } else {
            let v2 = 0x2::vec_set::singleton<address>(arg1);
            0x2::vec_set::insert<address>(&mut v2, arg1);
        };
    }

    public fun admin(arg0: &Marketplace) : address {
        arg0.admin
    }

    public fun assert_listing_admin_or_member(arg0: &Marketplace, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg1) == arg0.admin == false) {
            let v0 = MembersDfKey{dummy_field: false};
            assert!(0x2::dynamic_field::exists_<MembersDfKey>(&arg0.id, v0), 2);
            let v1 = MembersDfKey{dummy_field: false};
            let v2 = 0x2::tx_context::sender(arg1);
            assert!(0x2::vec_set::contains<address>(0x2::dynamic_field::borrow<MembersDfKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v1), &v2), 2);
        };
    }

    public fun assert_marketplace_admin(arg0: &Marketplace, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
    }

    public(friend) fun assert_version(arg0: &Marketplace) {
        assert!(arg0.version == 3, 1000);
    }

    fun assert_version_and_upgrade(arg0: &mut Marketplace) {
        if (arg0.version < 3) {
            arg0.version = 3;
        };
        assert_version(arg0);
    }

    public fun default_fee(arg0: &Marketplace) : &0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::object_box::ObjectBox {
        &arg0.default_fee
    }

    public entry fun init_marketplace<T0: store + key>(arg0: address, arg1: address, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<Marketplace>(new<T0>(arg0, arg1, arg2, arg3));
    }

    public fun is_admin_or_member(arg0: &Marketplace, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1) == arg0.admin;
        let v1 = v0;
        let v2 = if (v0 == false) {
            let v3 = MembersDfKey{dummy_field: false};
            0x2::dynamic_field::exists_<MembersDfKey>(&arg0.id, v3)
        } else {
            false
        };
        if (v2) {
            let v4 = MembersDfKey{dummy_field: false};
            let v5 = 0x2::tx_context::sender(arg1);
            v1 = 0x2::vec_set::contains<address>(0x2::dynamic_field::borrow<MembersDfKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v4), &v5);
        };
        v1
    }

    entry fun migrate(arg0: &mut Marketplace, arg1: &mut 0x2::tx_context::TxContext) {
        assert_marketplace_admin(arg0, arg1);
        assert!(arg0.version < 3, 999);
        arg0.version = 3;
    }

    public fun receiver(arg0: &Marketplace) : address {
        arg0.receiver
    }

    public entry fun remove_member(arg0: &mut Marketplace, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        assert_marketplace_admin(arg0, arg2);
        let v0 = MembersDfKey{dummy_field: false};
        0x2::vec_set::remove<address>(0x2::dynamic_field::borrow_mut<MembersDfKey, 0x2::vec_set::VecSet<address>>(&mut arg0.id, v0), &arg1);
    }

    // decompiled from Move bytecode v6
}

