module 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::supply {
    struct Supply<phantom T0> has drop, store {
        frozen: bool,
        inner: 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply,
    }

    public fun add_domain<T0>(arg0: &mut 0x2::object::UID, arg1: Supply<T0>) {
        assert_no_supply<T0>(arg0);
        0x2::dynamic_field::add<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<Supply<T0>>, Supply<T0>>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<Supply<T0>>(), arg1);
    }

    public fun add_new<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut 0x2::object::UID, arg2: u64, arg3: bool) {
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

    public fun assert_zero<T0>(arg0: &Supply<T0>) {
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::assert_zero(&arg0.inner);
    }

    public fun borrow_domain<T0>(arg0: &0x2::object::UID) : &Supply<T0> {
        assert_supply<T0>(arg0);
        0x2::dynamic_field::borrow<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<Supply<T0>>, Supply<T0>>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<Supply<T0>>())
    }

    public fun borrow_domain_mut<T0>(arg0: &mut 0x2::object::UID) : &mut Supply<T0> {
        assert_supply<T0>(arg0);
        0x2::dynamic_field::borrow_mut<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<Supply<T0>>, Supply<T0>>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<Supply<T0>>())
    }

    public fun borrow_inner<T0>(arg0: &Supply<T0>) : &0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply {
        &arg0.inner
    }

    public fun decrease_supply_ceil<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut Supply<T0>, arg2: u64) {
        assert_not_frozen<T0>(arg1);
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::decrease_maximum(&mut arg1.inner, arg2);
    }

    public fun decrease_supply_ceil_nft<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut 0x2::object::UID, arg2: u64) {
        let v0 = borrow_domain_mut<T0>(arg1);
        decrease_supply_ceil<T0>(arg0, v0, arg2);
    }

    public fun decrement<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut Supply<T0>, arg2: u64) {
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::decrement(&mut arg1.inner, arg2);
    }

    public fun delete<T0>(arg0: Supply<T0>) : 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply {
        assert!(!arg0.frozen || get_current<T0>(&arg0) == 0, 4);
        let Supply {
            frozen : _,
            inner  : v1,
        } = arg0;
        v1
    }

    public fun freeze_supply<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut Supply<T0>) {
        assert_not_frozen<T0>(arg1);
        arg1.frozen = true;
    }

    public fun freeze_supply_nft<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut 0x2::object::UID) {
        let v0 = borrow_domain_mut<T0>(arg1);
        freeze_supply<T0>(arg0, v0);
    }

    public fun get_current<T0>(arg0: &Supply<T0>) : u64 {
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::get_current(&arg0.inner)
    }

    public fun get_max<T0>(arg0: &Supply<T0>) : u64 {
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::get_max(&arg0.inner)
    }

    public fun get_remaining<T0>(arg0: &Supply<T0>) : u64 {
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::get_remaining(&arg0.inner)
    }

    public fun has_domain<T0>(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<Supply<T0>>, Supply<T0>>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<Supply<T0>>())
    }

    public fun increase_supply_ceil<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut Supply<T0>, arg2: u64) {
        assert_not_frozen<T0>(arg1);
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::increase_maximum(&mut arg1.inner, arg2);
    }

    public fun increase_supply_ceil_nft<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut 0x2::object::UID, arg2: u64) {
        let v0 = borrow_domain_mut<T0>(arg1);
        increase_supply_ceil<T0>(arg0, v0, arg2);
    }

    public fun increment<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut Supply<T0>, arg2: u64) {
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::increment(&mut arg1.inner, arg2);
    }

    public fun is_frozen<T0>(arg0: &Supply<T0>) : bool {
        arg0.frozen
    }

    public fun merge<T0>(arg0: &mut Supply<T0>, arg1: Supply<T0>) {
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::merge(&mut arg0.inner, delete<T0>(arg1));
    }

    public fun new<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: u64, arg2: bool) : Supply<T0> {
        Supply<T0>{
            frozen : arg2,
            inner  : 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::new(arg1),
        }
    }

    public fun remove_domain<T0>(arg0: &mut 0x2::object::UID) : Supply<T0> {
        assert_supply<T0>(arg0);
        0x2::dynamic_field::remove<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<Supply<T0>>, Supply<T0>>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<Supply<T0>>())
    }

    public fun split<T0>(arg0: &mut Supply<T0>, arg1: u64) : Supply<T0> {
        Supply<T0>{
            frozen : true,
            inner  : 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::split(&mut arg0.inner, arg1),
        }
    }

    // decompiled from Move bytecode v6
}

