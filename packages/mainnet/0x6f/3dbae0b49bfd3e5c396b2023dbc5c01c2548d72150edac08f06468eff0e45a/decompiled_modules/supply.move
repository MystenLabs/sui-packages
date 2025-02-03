module 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::supply {
    struct Supply<phantom T0> has drop, store {
        frozen: bool,
        inner: 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::Supply,
    }

    public fun assert_zero<T0>(arg0: &Supply<T0>) {
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::assert_zero(&arg0.inner);
    }

    public fun decrement<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Supply<T0>, arg2: u64) {
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::decrement(&mut arg1.inner, arg2);
    }

    public fun get_current<T0>(arg0: &Supply<T0>) : u64 {
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::get_current(&arg0.inner)
    }

    public fun get_max<T0>(arg0: &Supply<T0>) : u64 {
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::get_max(&arg0.inner)
    }

    public fun get_remaining<T0>(arg0: &Supply<T0>) : u64 {
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::get_remaining(&arg0.inner)
    }

    public fun increment<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Supply<T0>, arg2: u64) {
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::increment(&mut arg1.inner, arg2);
    }

    public fun merge<T0>(arg0: &mut Supply<T0>, arg1: Supply<T0>) {
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::merge(&mut arg0.inner, delete<T0>(arg1));
    }

    public fun new<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: u64, arg2: bool) : Supply<T0> {
        Supply<T0>{
            frozen : arg2,
            inner  : 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::new(arg1),
        }
    }

    public fun split<T0>(arg0: &mut Supply<T0>, arg1: u64) : Supply<T0> {
        Supply<T0>{
            frozen : true,
            inner  : 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::split(&mut arg0.inner, arg1),
        }
    }

    public fun add_domain<T0>(arg0: &mut 0x2::object::UID, arg1: Supply<T0>) {
        assert_no_supply<T0>(arg0);
        0x2::dynamic_field::add<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Supply<T0>>, Supply<T0>>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Supply<T0>>(), arg1);
    }

    public fun add_new<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0x2::object::UID, arg2: u64, arg3: bool) {
        add_domain<T0>(arg1, new<T0>(arg0, arg2, arg3));
    }

    public fun assert_no_supply<T0>(arg0: &0x2::object::UID) {
        assert!(!has_domain<T0>(arg0), 2);
    }

    public fun assert_not_frozen<T0>(arg0: &Supply<T0>) {
        assert!(!arg0.frozen, 3);
    }

    public fun assert_supply<T0>(arg0: &0x2::object::UID) {
        assert!(has_domain<T0>(arg0), 1);
    }

    public fun borrow_domain<T0>(arg0: &0x2::object::UID) : &Supply<T0> {
        assert_supply<T0>(arg0);
        0x2::dynamic_field::borrow<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Supply<T0>>, Supply<T0>>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Supply<T0>>())
    }

    public fun borrow_domain_mut<T0>(arg0: &mut 0x2::object::UID) : &mut Supply<T0> {
        assert_supply<T0>(arg0);
        0x2::dynamic_field::borrow_mut<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Supply<T0>>, Supply<T0>>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Supply<T0>>())
    }

    public fun borrow_inner<T0>(arg0: &Supply<T0>) : &0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::Supply {
        &arg0.inner
    }

    public fun decrease_supply_ceil<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Supply<T0>, arg2: u64) {
        assert_not_frozen<T0>(arg1);
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::decrease_maximum(&mut arg1.inner, arg2);
    }

    public fun decrease_supply_ceil_nft<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0x2::object::UID, arg2: u64) {
        let v0 = borrow_domain_mut<T0>(arg1);
        decrease_supply_ceil<T0>(arg0, v0, arg2);
    }

    public fun delete<T0>(arg0: Supply<T0>) : 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::Supply {
        assert!(!arg0.frozen || get_current<T0>(&arg0) == 0, 4);
        let Supply {
            frozen : _,
            inner  : v1,
        } = arg0;
        v1
    }

    public fun freeze_supply<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Supply<T0>) {
        assert_not_frozen<T0>(arg1);
        arg1.frozen = true;
    }

    public fun freeze_supply_nft<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0x2::object::UID) {
        let v0 = borrow_domain_mut<T0>(arg1);
        freeze_supply<T0>(arg0, v0);
    }

    public fun has_domain<T0>(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Supply<T0>>, Supply<T0>>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Supply<T0>>())
    }

    public fun increase_supply_ceil<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Supply<T0>, arg2: u64) {
        assert_not_frozen<T0>(arg1);
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply::increase_maximum(&mut arg1.inner, arg2);
    }

    public fun increase_supply_ceil_nft<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0x2::object::UID, arg2: u64) {
        let v0 = borrow_domain_mut<T0>(arg1);
        increase_supply_ceil<T0>(arg0, v0, arg2);
    }

    public fun is_frozen<T0>(arg0: &Supply<T0>) : bool {
        arg0.frozen
    }

    public fun remove_domain<T0>(arg0: &mut 0x2::object::UID) : Supply<T0> {
        assert_supply<T0>(arg0);
        0x2::dynamic_field::remove<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Supply<T0>>, Supply<T0>>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Supply<T0>>())
    }

    // decompiled from Move bytecode v6
}

