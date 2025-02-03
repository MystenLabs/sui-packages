module 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::mint_pass {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct MintPass<phantom T0> has store, key {
        id: 0x2::object::UID,
        supply: 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::Supply,
    }

    struct MetadataDfKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun new<T0: key>(arg0: &mut 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::mint_cap::MintCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : MintPass<T0> {
        0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::mint_cap::assert_limited<T0>(arg0);
        0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::mint_cap::increment_supply<T0>(arg0, arg1);
        MintPass<T0>{
            id     : 0x2::object::new(arg2),
            supply : 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::new(arg1),
        }
    }

    public fun new_display<T0: store + key>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::frozen_publisher::FrozenPublisher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<MintPass<T0>> {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::frozen_publisher::new_display<Witness, MintPass<T0>>(v0, arg1, arg2);
        0x2::display::add<MintPass<T0>>(&mut v1, 0x1::string::utf8(b"type"), 0x1::string::utf8(b"MintPass"));
        v1
    }

    public fun merge<T0: key>(arg0: &mut MintPass<T0>, arg1: MintPass<T0>) {
        let MintPass {
            id     : v0,
            supply : v1,
        } = arg1;
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::merge(&mut arg0.supply, v1);
        0x2::object::delete(v0);
    }

    public fun increment_supply<T0>(arg0: &mut MintPass<T0>, arg1: u64) {
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::increment(&mut arg0.supply, arg1);
    }

    public fun borrow_supply<T0>(arg0: &MintPass<T0>) : &0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::Supply {
        &arg0.supply
    }

    public fun delete_mint_pass<T0>(arg0: MintPass<T0>) {
        let MintPass {
            id     : v0,
            supply : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_supply<T0>(arg0: &MintPass<T0>) : &0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::Supply {
        &arg0.supply
    }

    public fun new_<T0>(arg0: &0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::mint_cap::MintCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : MintPass<T0> {
        0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::mint_cap::assert_unlimited<T0>(arg0);
        MintPass<T0>{
            id     : 0x2::object::new(arg2),
            supply : 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::new(arg1),
        }
    }

    public fun new_with_metadata<T0: key>(arg0: &mut 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::mint_cap::MintCap<T0>, arg1: u64, arg2: &vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : MintPass<T0> {
        let v0 = new<T0>(arg0, arg1, arg3);
        let v1 = MetadataDfKey{dummy_field: false};
        0x2::dynamic_field::add<MetadataDfKey, 0x2::bcs::BCS>(&mut v0.id, v1, 0x2::bcs::new(*arg2));
        v0
    }

    public fun new_with_metadata_<T0: key>(arg0: &0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::mint_cap::MintCap<T0>, arg1: u64, arg2: &vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : MintPass<T0> {
        let v0 = new_<T0>(arg0, arg1, arg3);
        let v1 = MetadataDfKey{dummy_field: false};
        0x2::dynamic_field::add<MetadataDfKey, 0x2::bcs::BCS>(&mut v0.id, v1, 0x2::bcs::new(*arg2));
        v0
    }

    public fun split<T0: key>(arg0: &mut MintPass<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : MintPass<T0> {
        increment_supply<T0>(arg0, arg1);
        MintPass<T0>{
            id     : 0x2::object::new(arg2),
            supply : 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::new(arg1),
        }
    }

    public fun supply<T0>(arg0: &MintPass<T0>) : u64 {
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::get_current(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

