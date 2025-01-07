module 0x2bfbfef0dcb16ba94cc0bdab6ae6119e9039b56fe2f6fecd5400127ef559c21c::revealAurahma {
    struct REVEALAURAHMA has drop {
        dummy_field: bool,
    }

    struct RevealAurahmaNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    fun init(arg0: REVEALAURAHMA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<REVEALAURAHMA, RevealAurahmaNFT>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<REVEALAURAHMA>(arg0, arg1);
        let v5 = 0x2::display::new<RevealAurahmaNFT>(&v4, arg1);
        0x2::display::add<RevealAurahmaNFT>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<RevealAurahmaNFT>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<RevealAurahmaNFT>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://{url}"));
        0x2::display::update_version<RevealAurahmaNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<RevealAurahmaNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<RevealAurahmaNFT, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<RevealAurahmaNFT, Witness>(v6), &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Simple"), 0x1::string::utf8(b"Simple collection on Sui")));
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<RevealAurahmaNFT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<RevealAurahmaNFT>>(v3);
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<RevealAurahmaNFT>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = RevealAurahmaNFT{
            id          : 0x2::object::new(arg5),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        0x2::transfer::public_transfer<RevealAurahmaNFT>(v0, arg4);
    }

    // decompiled from Move bytecode v6
}

