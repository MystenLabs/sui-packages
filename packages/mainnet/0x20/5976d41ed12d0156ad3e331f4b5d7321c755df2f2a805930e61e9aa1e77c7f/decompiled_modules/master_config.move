module 0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::master_config {
    struct MASTER_CONFIG has drop {
        dummy_field: bool,
    }

    struct PinkSaleAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MasterConfig has key {
        id: 0x2::object::UID,
        admin: address,
        fee_receiver: address,
        operators: 0x2::vec_map::VecMap<address, bool>,
    }

    public fun add_operators(arg0: &PinkSaleAdminCap, arg1: &mut MasterConfig, arg2: &vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg2)) {
            let v1 = 0x1::vector::borrow<address>(arg2, v0);
            if (!0x2::vec_map::contains<address, bool>(&arg1.operators, v1)) {
                0x2::vec_map::insert<address, bool>(&mut arg1.operators, *v1, true);
            };
            v0 = v0 + 1;
        };
    }

    public fun admin(arg0: &MasterConfig) : address {
        arg0.fee_receiver
    }

    public fun fee_receiver(arg0: &MasterConfig) : address {
        arg0.fee_receiver
    }

    fun init(arg0: MASTER_CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PinkSaleAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<PinkSaleAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = MasterConfig{
            id           : 0x2::object::new(arg1),
            admin        : @0x7980bfbc596031bb55e95dec68d5abab26aa17dcde3548a2ffcf98c0c6b26b4c,
            fee_receiver : @0xb389a630b3995915e8cc94a202363a82d830e7dc5d27062069f5f691216bf1f2,
            operators    : 0x2::vec_map::empty<address, bool>(),
        };
        0x2::vec_map::insert<address, bool>(&mut v1.operators, @0x7980bfbc596031bb55e95dec68d5abab26aa17dcde3548a2ffcf98c0c6b26b4c, true);
        0x2::transfer::share_object<MasterConfig>(v1);
    }

    public fun is_operator(arg0: &MasterConfig, arg1: address) : bool {
        arg0.admin == arg1 || 0x2::vec_map::contains<address, bool>(&arg0.operators, &arg1)
    }

    public fun master_config_id(arg0: &MasterConfig) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun remove_operators(arg0: &PinkSaleAdminCap, arg1: &mut MasterConfig, arg2: &vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg2)) {
            let v1 = 0x1::vector::borrow<address>(arg2, v0);
            if (0x2::vec_map::contains<address, bool>(&arg1.operators, v1)) {
                let (_, _) = 0x2::vec_map::remove<address, bool>(&mut arg1.operators, v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun set_fee_receiver(arg0: &PinkSaleAdminCap, arg1: &mut MasterConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_operator(arg1, 0x2::tx_context::sender(arg3)), 1);
        arg1.fee_receiver = arg2;
    }

    // decompiled from Move bytecode v6
}

