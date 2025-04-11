module 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        houses: vector<0x2::object::ID>,
        protocol_fee_bps: u64,
    }

    struct REGISTRY has drop {
        dummy_field: bool,
    }

    struct OpenPlayAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun admin_allow_version(arg0: &mut Registry, arg1: &OpenPlayAdminCap, arg2: u64) {
        assert!(!0x2::vec_set::contains<u64>(&arg0.allowed_versions, &arg2), 2);
        0x2::vec_set::insert<u64>(&mut arg0.allowed_versions, arg2);
    }

    public fun admin_disallow_version(arg0: &mut Registry, arg1: &OpenPlayAdminCap, arg2: u64) {
        assert!(0x2::vec_set::contains<u64>(&arg0.allowed_versions, &arg2), 3);
        0x2::vec_set::remove<u64>(&mut arg0.allowed_versions, &arg2);
    }

    fun assert_version(arg0: &Registry) {
        let v0 = 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.allowed_versions, &v0), 1);
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::empty<u64>();
        0x2::vec_set::insert<u64>(&mut v0, 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::constants::current_version());
        let v1 = Registry{
            id               : 0x2::object::new(arg1),
            allowed_versions : v0,
            houses           : 0x1::vector::empty<0x2::object::ID>(),
            protocol_fee_bps : 50,
        };
        0x2::transfer::share_object<Registry>(v1);
        let v2 = OpenPlayAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<OpenPlayAdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun protocol_fee_factor(arg0: &Registry) : 0x1::uq32_32::UQ32_32 {
        assert_version(arg0);
        0x1::uq32_32::from_quotient(arg0.protocol_fee_bps, 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::constants::max_bps())
    }

    public(friend) fun register_house(arg0: &mut Registry, arg1: 0x2::object::ID) {
        assert_version(arg0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.houses, arg1);
    }

    public fun update_protocol_fee_bps(arg0: &mut Registry, arg1: &OpenPlayAdminCap, arg2: u64) {
        arg0.protocol_fee_bps = arg2;
    }

    // decompiled from Move bytecode v6
}

