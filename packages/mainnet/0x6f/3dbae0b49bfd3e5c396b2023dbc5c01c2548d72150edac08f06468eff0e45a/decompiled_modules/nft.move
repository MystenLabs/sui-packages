module 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct Nft<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct MintNftEvent has copy, drop {
        nft_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
    }

    public entry fun delete<T0>(arg0: Nft<T0>) {
        let Nft {
            id   : v0,
            name : _,
            url  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun new<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: 0x1::string::String, arg2: 0x2::url::Url, arg3: &mut 0x2::tx_context::TxContext) : Nft<T0> {
        new_<T0>(arg1, arg2, arg3)
    }

    public fun url<T0>(arg0: &Nft<T0>) : &0x2::url::Url {
        &arg0.url
    }

    public fun new_display<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::frozen_publisher::FrozenPublisher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<Nft<T0>> {
        let v0 = Witness{dummy_field: false};
        0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::frozen_publisher::new_display<Witness, Nft<T0>>(v0, arg1, arg2)
    }

    public fun add_domain<T0, T1: store>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Nft<T0>, arg2: T1) {
        assert_no_domain<T0, T1>(arg1);
        0x2::dynamic_field::add<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<T1>, T1>(borrow_uid_mut<T0>(arg0, arg1), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<T1>(), arg2);
    }

    public fun assert_domain<T0, T1: store>(arg0: &Nft<T0>) {
        assert!(has_domain<T0, T1>(arg0), 1);
    }

    public fun assert_no_domain<T0, T1: store>(arg0: &Nft<T0>) {
        assert!(!has_domain<T0, T1>(arg0), 2);
    }

    public fun borrow_domain<T0, T1: store>(arg0: &Nft<T0>) : &T1 {
        assert_domain<T0, T1>(arg0);
        0x2::dynamic_field::borrow<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<T1>, T1>(&arg0.id, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<T1>())
    }

    public fun borrow_domain_mut<T0, T1: store>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Nft<T0>) : &mut T1 {
        assert_domain<T0, T1>(arg1);
        0x2::dynamic_field::borrow_mut<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<T1>, T1>(borrow_uid_mut<T0>(arg0, arg1), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<T1>())
    }

    public fun borrow_uid<T0>(arg0: &Nft<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun borrow_uid_mut<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Nft<T0>) : &mut 0x2::object::UID {
        &mut arg1.id
    }

    public fun from_mint_cap<T0>(arg0: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0>, arg1: 0x1::string::String, arg2: 0x2::url::Url, arg3: &mut 0x2::tx_context::TxContext) : Nft<T0> {
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<T0>(arg0, 1);
        new_<T0>(arg1, arg2, arg3)
    }

    public fun has_domain<T0, T1: store>(arg0: &Nft<T0>) : bool {
        0x2::dynamic_field::exists_with_type<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<T1>, T1>(&arg0.id, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<T1>())
    }

    public fun name<T0>(arg0: &Nft<T0>) : &0x1::string::String {
        &arg0.name
    }

    fun new_<T0>(arg0: 0x1::string::String, arg1: 0x2::url::Url, arg2: &mut 0x2::tx_context::TxContext) : Nft<T0> {
        let v0 = 0x2::object::new(arg2);
        let v1 = MintNftEvent{
            nft_id   : 0x2::object::uid_to_inner(&v0),
            nft_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<MintNftEvent>(v1);
        Nft<T0>{
            id   : v0,
            name : arg0,
            url  : arg1,
        }
    }

    public fun remove_domain<T0, T1: store>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Nft<T0>) : T1 {
        assert_domain<T0, T1>(arg1);
        0x2::dynamic_field::remove<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<T1>, T1>(borrow_uid_mut<T0>(arg0, arg1), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<T1>())
    }

    public fun set_name<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Nft<T0>, arg2: 0x1::string::String) {
        arg1.name = arg2;
    }

    public fun set_url<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Nft<T0>, arg2: 0x2::url::Url) {
        arg1.url = arg2;
    }

    // decompiled from Move bytecode v6
}

