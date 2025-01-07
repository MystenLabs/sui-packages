module 0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::collection {
    struct Mobius has store, key {
        id: 0x2::object::UID,
        index: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        properties: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct COLLECTION has drop {
        dummy_field: bool,
    }

    public(friend) fun burn(arg0: Mobius) {
        let Mobius {
            id         : v0,
            index      : _,
            name       : _,
            image_url  : _,
            properties : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun create_display<T0: key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<T0> {
        let v0 = 0x2::display::new<T0>(arg0, arg1);
        0x2::display::add<T0>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<T0>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<T0>(&mut v0, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<T0>(&mut v0);
        v0
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<COLLECTION, Mobius>(&arg0, 0x1::option::none<u64>(), arg1);
        let v2 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v3 = create_display<Mobius>(&v2, arg1);
        let (v4, v5) = 0x2::transfer_policy::new<Mobius>(&v2, arg1);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Mobius>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Mobius>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Mobius>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Mobius>>(v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Mobius>>(v4);
    }

    public(friend) fun mint_nft_with_cap(arg0: &0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::utils::Version, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Mobius>, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) : Mobius {
        0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::utils::check_version(arg0);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg5);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg6), 1);
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v2 = 0;
        while (v2 < v0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::vector::pop_back<0x1::string::String>(&mut arg5), 0x1::vector::pop_back<0x1::string::String>(&mut arg6));
            v2 = v2 + 1;
        };
        Mobius{
            id         : 0x2::object::new(arg7),
            index      : arg1,
            name       : arg2,
            image_url  : arg3,
            properties : v1,
        }
    }

    public(friend) fun mutate_properties(arg0: &mut Mobius, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.properties, &arg1)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.properties, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.properties, arg1, arg2);
        };
    }

    public fun set_collection_info<T0: key>(arg0: &0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::utils::Version, arg1: &mut 0x2::display::Display<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::utils::check_version(arg0);
        0x2::display::add<T0>(arg1, 0x1::string::utf8(b"collection_name"), arg2);
        0x2::display::add<T0>(arg1, 0x1::string::utf8(b"collection_image"), arg3);
        0x2::display::add<T0>(arg1, 0x1::string::utf8(b"symbol"), arg4);
        0x2::display::add<T0>(arg1, 0x1::string::utf8(b"creator"), 0x2::address::to_string(arg6));
        0x2::display::add<T0>(arg1, 0x1::string::utf8(b"description"), arg5);
        0x2::display::update_version<T0>(arg1);
    }

    public entry fun set_display_and_royalty_rule<T0: store + key>(arg0: &0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::utils::Version, arg1: &mut 0x2::display::Display<T0>, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &0x2::transfer_policy::TransferPolicyCap<T0>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u16, arg7: u64) {
        0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::utils::check_version(arg0);
        0x2::display::add<T0>(arg1, arg4, arg5);
        0x2::display::update_version<T0>(arg1);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<T0>(arg2, arg3, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

