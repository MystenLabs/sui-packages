module 0xbb469356be0c7439aada140ada7ebe59f5a8484bfd29058276af5479f7fe9153::keepsake_nft {
    struct MintEvent has copy, drop {
        item_id: 0x2::object::ID,
    }

    struct KEEPSAKE_NFT has drop {
        dummy_field: bool,
    }

    struct KEEPSAKE has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    struct OneTimeWitness has drop, store {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: KEEPSAKE) {
        let KEEPSAKE {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            attributes  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun create(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<KEEPSAKE>, arg4: &mut 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::TransferPolicy<KEEPSAKE>, arg5: &0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::TransferPolicyCap<KEEPSAKE>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<KEEPSAKE, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<KEEPSAKE, Witness>(v0), arg3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(arg0, arg1));
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<KEEPSAKE>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<KEEPSAKE, Witness>(v1), arg3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_address(0x2::tx_context::sender(arg6), arg6), (arg2 as u16), arg6);
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::keepsake_royalties::create_and_add_strategy<KEEPSAKE>(arg4, arg5, arg2, arg6);
    }

    public entry fun getDelegatedWitness(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<KEEPSAKE>) : 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<KEEPSAKE> {
        let v0 = Witness{dummy_field: false};
        0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<KEEPSAKE, Witness>(v0)
    }

    public entry fun getWitness(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<KEEPSAKE>) : Witness {
        Witness{dummy_field: false}
    }

    public fun get_nft<T0: drop>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, KEEPSAKE>) : KEEPSAKE {
        let v0 = Witness{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft<T0, KEEPSAKE>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<KEEPSAKE, Witness>(v0), arg0)
    }

    public fun get_nft_field<T0: drop, T1: store>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, KEEPSAKE>) : (T1, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::ReturnPromise<KEEPSAKE, T1>) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<KEEPSAKE, Witness>(v0);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_field<KEEPSAKE, T1>(v1, &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft_ref_mut<T0, KEEPSAKE>(v1, arg0).id)
    }

    fun init(arg0: KEEPSAKE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<KEEPSAKE_NFT, KEEPSAKE>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = 0x2::package::claim<KEEPSAKE_NFT>(arg0, arg1);
        let (v4, v5) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<KEEPSAKE>(&v3, arg1);
        let v6 = v5;
        let v7 = v4;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<KEEPSAKE>(&mut v7, &v6);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<KEEPSAKE>>(v6, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<KEEPSAKE>>(v7);
        let (v8, v9) = 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::new<KEEPSAKE>(&v3, arg1);
        0x2::transfer::public_transfer<0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::TransferPolicyCap<KEEPSAKE>>(v9, v0);
        0x2::transfer::public_share_object<0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::TransferPolicy<KEEPSAKE>>(v8);
        let (v10, v11) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<KEEPSAKE>(&v3, arg1);
        let v12 = v11;
        let v13 = v10;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::p2p_list::enforce<KEEPSAKE>(&mut v13, &v12);
        let v14 = 0x1::vector::empty<0x1::string::String>();
        let v15 = &mut v14;
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"description"));
        let v16 = 0x1::vector::empty<0x1::string::String>();
        let v17 = &mut v16;
        0x1::vector::push_back<0x1::string::String>(v17, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v17, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v17, 0x1::string::utf8(b"{description}"));
        let v18 = 0x2::display::new_with_fields<KEEPSAKE>(&v3, v14, v16, arg1);
        0x2::display::update_version<KEEPSAKE>(&mut v18);
        0x2::transfer::public_transfer<0x2::display::Display<KEEPSAKE>>(v18, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<KEEPSAKE>>(v12, v0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<KEEPSAKE>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<KEEPSAKE>>(v1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<KEEPSAKE>>(v13);
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<KEEPSAKE>, arg6: &mut 0x2::tx_context::TxContext) : KEEPSAKE {
        let v0 = KEEPSAKE{
            id          : 0x2::object::new(arg6),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg3, arg4),
        };
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<KEEPSAKE>(arg5, 1);
        let v1 = MintEvent{item_id: 0x2::object::id<KEEPSAKE>(&v0)};
        0x2::event::emit<MintEvent>(v1);
        let v2 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<KEEPSAKE>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<KEEPSAKE, Witness>(v2), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<KEEPSAKE>(arg5), &v0);
        v0
    }

    public entry fun mint_launchpad(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<KEEPSAKE>, arg6: &mut 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::listing::Listing, arg7: 0x2::object::ID, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg8) {
            let v1 = mint(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
            0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::listing::add_nft<KEEPSAKE>(arg6, arg7, v1, arg9);
            v0 = v0 + 1;
        };
    }

    public fun mint_many(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<KEEPSAKE>, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) : vector<KEEPSAKE> {
        let v0 = 0x1::vector::empty<KEEPSAKE>();
        let v1 = 0;
        while (v1 < arg6) {
            v1 = v1 + 1;
            0x1::vector::push_back<KEEPSAKE>(&mut v0, mint(arg0, arg1, arg2, arg3, arg4, arg5, arg7));
        };
        v0
    }

    public entry fun mint_to(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<KEEPSAKE>, arg6: address, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg7) {
            0x2::transfer::public_transfer<KEEPSAKE>(mint(arg0, arg1, arg2, arg3, arg4, arg5, arg8), arg6);
            v0 = v0 + 1;
        };
    }

    public fun return_nft<T0: drop>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, KEEPSAKE>, arg1: KEEPSAKE) {
        let v0 = Witness{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::return_nft<T0, KEEPSAKE>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<KEEPSAKE, Witness>(v0), arg0, arg1);
    }

    public fun return_nft_field<T0: drop, T1: store>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, KEEPSAKE>, arg1: T1, arg2: 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::ReturnPromise<KEEPSAKE, T1>) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<KEEPSAKE, Witness>(v0);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::return_field<KEEPSAKE, T1>(v1, &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft_ref_mut<T0, KEEPSAKE>(v1, arg0).id, arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

