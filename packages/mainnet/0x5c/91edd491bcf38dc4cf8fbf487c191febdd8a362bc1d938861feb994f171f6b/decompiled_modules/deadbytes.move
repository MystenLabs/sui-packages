module 0x5c91edd491bcf38dc4cf8fbf487c191febdd8a362bc1d938861feb994f171f6b::deadbytes {
    struct DEADBYTES has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct DeadByte has store, key {
        id: 0x2::object::UID,
    }

    struct Gun<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: DEADBYTES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<DEADBYTES, DeadByte>(&arg0, 0x1::option::none<u64>(), arg1);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<DeadByte>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<DEADBYTES>(arg0, arg1), v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<DeadByte>>(v1);
    }

    public fun mint_gun_metadata<T0: key>(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<T0>(arg0), 0);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"accuracy"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"recoil"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, arg1);
        0x1::vector::push_back<0x1::string::String>(v3, arg2);
        0x1::vector::push_back<0x1::string::String>(v3, arg3);
        let v4 = 0x2::display::new_with_fields<T0>(arg0, v0, v2, arg4);
        0x2::display::update_version<T0>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<T0>>(v4, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

