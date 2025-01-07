module 0x4125c462e4dc35631e7b31dc0c443930bd96fbd24858d8e772ff5b225c55a792::equipment {
    struct EQUIPMENT has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct Back has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        rarity: 0x1::string::String,
        type: 0x1::string::String,
    }

    struct Bottom has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        rarity: 0x1::string::String,
        type: 0x1::string::String,
    }

    struct Eyes has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        rarity: 0x1::string::String,
        type: 0x1::string::String,
    }

    struct Head has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        rarity: 0x1::string::String,
        type: 0x1::string::String,
    }

    struct Misc has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        rarity: 0x1::string::String,
        type: 0x1::string::String,
    }

    struct Mouth has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        rarity: 0x1::string::String,
        type: 0x1::string::String,
    }

    struct Neck has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        rarity: 0x1::string::String,
        type: 0x1::string::String,
    }

    struct Skin has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        rarity: 0x1::string::String,
        type: 0x1::string::String,
    }

    struct Top has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        rarity: 0x1::string::String,
        type: 0x1::string::String,
    }

    public entry fun burn_back(arg0: Back, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Back>) {
        let v0 = Witness{dummy_field: false};
        let Back {
            id          : v1,
            name        : _,
            description : _,
            image_url   : _,
            rarity      : _,
            type        : _,
        } = arg0;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<Back>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<Back>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Back, Witness>(v0), &arg0), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Back>>(arg1), v1);
    }

    public entry fun burn_back_in_kiosk(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Back>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Back, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        burn_back(withdraw_equipment<Back>(arg1, arg2, arg3, arg4), arg0);
    }

    public entry fun burn_bottom(arg0: Bottom, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Bottom>) {
        let v0 = Witness{dummy_field: false};
        let Bottom {
            id          : v1,
            name        : _,
            description : _,
            image_url   : _,
            rarity      : _,
            type        : _,
        } = arg0;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<Bottom>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<Bottom>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Bottom, Witness>(v0), &arg0), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Bottom>>(arg1), v1);
    }

    public entry fun burn_bottom_in_kiosk(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Bottom>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Bottom, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        burn_bottom(withdraw_equipment<Bottom>(arg1, arg2, arg3, arg4), arg0);
    }

    public entry fun burn_eyes(arg0: Eyes, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Eyes>) {
        let v0 = Witness{dummy_field: false};
        let Eyes {
            id          : v1,
            name        : _,
            description : _,
            image_url   : _,
            rarity      : _,
            type        : _,
        } = arg0;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<Eyes>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<Eyes>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Eyes, Witness>(v0), &arg0), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Eyes>>(arg1), v1);
    }

    public entry fun burn_eyes_in_kiosk(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Eyes>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Eyes, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        burn_eyes(withdraw_equipment<Eyes>(arg1, arg2, arg3, arg4), arg0);
    }

    public entry fun burn_head(arg0: Head, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Head>) {
        let v0 = Witness{dummy_field: false};
        let Head {
            id          : v1,
            name        : _,
            description : _,
            image_url   : _,
            rarity      : _,
            type        : _,
        } = arg0;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<Head>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<Head>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Head, Witness>(v0), &arg0), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Head>>(arg1), v1);
    }

    public entry fun burn_head_in_kiosk(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Head>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Head, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        burn_head(withdraw_equipment<Head>(arg1, arg2, arg3, arg4), arg0);
    }

    public entry fun burn_misc(arg0: Misc, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Misc>) {
        let v0 = Witness{dummy_field: false};
        let Misc {
            id          : v1,
            name        : _,
            description : _,
            image_url   : _,
            rarity      : _,
            type        : _,
        } = arg0;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<Misc>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<Misc>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Misc, Witness>(v0), &arg0), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Misc>>(arg1), v1);
    }

    public entry fun burn_misc_in_kiosk(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Misc>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Misc, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        burn_misc(withdraw_equipment<Misc>(arg1, arg2, arg3, arg4), arg0);
    }

    public entry fun burn_mouth(arg0: Mouth, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Mouth>) {
        let v0 = Witness{dummy_field: false};
        let Mouth {
            id          : v1,
            name        : _,
            description : _,
            image_url   : _,
            rarity      : _,
            type        : _,
        } = arg0;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<Mouth>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<Mouth>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Mouth, Witness>(v0), &arg0), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Mouth>>(arg1), v1);
    }

    public entry fun burn_mouth_in_kiosk(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Mouth>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Mouth, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        burn_mouth(withdraw_equipment<Mouth>(arg1, arg2, arg3, arg4), arg0);
    }

    public entry fun burn_neck(arg0: Neck, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Neck>) {
        let v0 = Witness{dummy_field: false};
        let Neck {
            id          : v1,
            name        : _,
            description : _,
            image_url   : _,
            rarity      : _,
            type        : _,
        } = arg0;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<Neck>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<Neck>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Neck, Witness>(v0), &arg0), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Neck>>(arg1), v1);
    }

    public entry fun burn_neck_in_kiosk(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Neck>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Neck, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        burn_neck(withdraw_equipment<Neck>(arg1, arg2, arg3, arg4), arg0);
    }

    public entry fun burn_skin(arg0: Skin, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Skin>) {
        let v0 = Witness{dummy_field: false};
        let Skin {
            id          : v1,
            name        : _,
            description : _,
            image_url   : _,
            rarity      : _,
            type        : _,
        } = arg0;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<Skin>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<Skin>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Skin, Witness>(v0), &arg0), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Skin>>(arg1), v1);
    }

    public entry fun burn_skin_in_kiosk(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Skin>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Skin, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        burn_skin(withdraw_equipment<Skin>(arg1, arg2, arg3, arg4), arg0);
    }

    public entry fun burn_top(arg0: Top, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Top>) {
        let v0 = Witness{dummy_field: false};
        let Top {
            id          : v1,
            name        : _,
            description : _,
            image_url   : _,
            rarity      : _,
            type        : _,
        } = arg0;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<Top>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<Top>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Top, Witness>(v0), &arg0), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Top>>(arg1), v1);
    }

    public entry fun burn_top_in_kiosk(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Top>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Top, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        burn_top(withdraw_equipment<Top>(arg1, arg2, arg3, arg4), arg0);
    }

    public(friend) fun confirm_withdrawal<T0>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WithdrawRequest<T0>) {
        let v0 = Witness{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::add_receipt<T0, Witness>(arg0, &v0);
    }

    fun create_collection<T0: store + key>(arg0: vector<u8>, arg1: vector<address>, arg2: &EQUIPMENT, arg3: &mut 0x2::tx_context::TxContext) : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<T0> {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<T0, Witness>(v0);
        let (v2, v3) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<EQUIPMENT, T0>(arg2, 0x1::option::none<u64>(), arg3);
        let v4 = v2;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<T0, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v1, &mut v4, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(arg0), 0x1::string::utf8(b"A play & earn community-based farming game on the Sui network by Lucky Kat Studios. This collection contains equipment NFTs.")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<T0, 0x2::url::Url>(v1, &mut v4, 0x2::url::new_unsafe_from_bytes(b"https://cosmocadia.io/"));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<T0, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v1, &mut v4, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&arg1)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<T0, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::Symbol>(v1, &mut v4, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::new(0x1::string::utf8(b"COSMO_EQUIPMENT")));
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0>>(v3, @0x8b65b5e40844345b64b761278ec578a34fa5290951bea4d96e8459be2e59771b);
        v4
    }

    public entry fun disable_orderbook<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<T0, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<T0>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true));
    }

    public entry fun enable_orderbook<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<T0, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<T0>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(false, false, false));
    }

    fun enforce_contract<T0>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<T0>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::enforce_rule_no_state<T0, Witness>(arg0, arg1);
    }

    fun init(arg0: EQUIPMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, @0x8b65b5e40844345b64b761278ec578a34fa5290951bea4d96e8459be2e59771b);
        let v1 = create_collection<Back>(b"Cosmocadia Equipment - Back", v0, &arg0, arg1);
        let v2 = create_collection<Bottom>(b"Cosmocadia Equipment - Bottom", v0, &arg0, arg1);
        let v3 = create_collection<Eyes>(b"Cosmocadia Equipment - Eyes", v0, &arg0, arg1);
        let v4 = create_collection<Head>(b"Cosmocadia Equipment - Head", v0, &arg0, arg1);
        let v5 = create_collection<Misc>(b"Cosmocadia Equipment - Misc", v0, &arg0, arg1);
        let v6 = create_collection<Mouth>(b"Cosmocadia Equipment - Mouth", v0, &arg0, arg1);
        let v7 = create_collection<Neck>(b"Cosmocadia Equipment - Neck", v0, &arg0, arg1);
        let v8 = create_collection<Skin>(b"Cosmocadia Equipment - Skin", v0, &arg0, arg1);
        let v9 = create_collection<Top>(b"Cosmocadia Equipment - Top", v0, &arg0, arg1);
        let v10 = 0x2::package::claim<EQUIPMENT>(arg0, arg1);
        setup_collection<Back>(v1, &v10, v0, arg1);
        setup_collection<Bottom>(v2, &v10, v0, arg1);
        setup_collection<Eyes>(v3, &v10, v0, arg1);
        setup_collection<Head>(v4, &v10, v0, arg1);
        setup_collection<Misc>(v5, &v10, v0, arg1);
        setup_collection<Mouth>(v6, &v10, v0, arg1);
        setup_collection<Neck>(v7, &v10, v0, arg1);
        setup_collection<Skin>(v8, &v10, v0, arg1);
        setup_collection<Top>(v9, &v10, v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v10, @0x8b65b5e40844345b64b761278ec578a34fa5290951bea4d96e8459be2e59771b);
    }

    public(friend) fun mint_back(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Back>, arg5: &mut 0x2::tx_context::TxContext) : Back {
        let v0 = Back{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            rarity      : 0x1::string::utf8(arg3),
            type        : 0x1::string::utf8(b"Back"),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Back>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Back, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Back>(arg4), &v0);
        v0
    }

    public(friend) fun mint_back_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Back>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_back(arg0, arg1, arg2, arg3, arg4, arg6);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Back>(arg5, v0, arg6);
        0x2::object::id<Back>(&v0)
    }

    public entry fun mint_back_to_address(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Back>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Back>(mint_back(arg0, arg1, arg2, arg3, arg4, arg6), arg5);
    }

    public entry fun mint_back_to_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Back>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) {
        mint_back_kiosk(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun mint_back_to_new_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Back>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg5, arg6);
        let v2 = v0;
        let v3 = &mut v2;
        mint_back_kiosk(arg0, arg1, arg2, arg3, arg4, v3, arg6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    fun mint_bottom(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Bottom>, arg5: &mut 0x2::tx_context::TxContext) : Bottom {
        let v0 = Bottom{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            rarity      : 0x1::string::utf8(arg3),
            type        : 0x1::string::utf8(b"Bottom"),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Bottom>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Bottom, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Bottom>(arg4), &v0);
        v0
    }

    public(friend) fun mint_bottom_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Bottom>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_bottom(arg0, arg1, arg2, arg3, arg4, arg6);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Bottom>(arg5, v0, arg6);
        0x2::object::id<Bottom>(&v0)
    }

    public entry fun mint_bottom_to_address(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Bottom>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Bottom>(mint_bottom(arg0, arg1, arg2, arg3, arg4, arg6), arg5);
    }

    public entry fun mint_bottom_to_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Bottom>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) {
        mint_bottom_kiosk(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun mint_bottom_to_new_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Bottom>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg5, arg6);
        let v2 = v0;
        let v3 = &mut v2;
        mint_bottom_kiosk(arg0, arg1, arg2, arg3, arg4, v3, arg6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    fun mint_eyes(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Eyes>, arg5: &mut 0x2::tx_context::TxContext) : Eyes {
        let v0 = Eyes{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            rarity      : 0x1::string::utf8(arg3),
            type        : 0x1::string::utf8(b"Eyes"),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Eyes>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Eyes, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Eyes>(arg4), &v0);
        v0
    }

    public(friend) fun mint_eyes_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Eyes>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_eyes(arg0, arg1, arg2, arg3, arg4, arg6);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Eyes>(arg5, v0, arg6);
        0x2::object::id<Eyes>(&v0)
    }

    public entry fun mint_eyes_to_address(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Eyes>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Eyes>(mint_eyes(arg0, arg1, arg2, arg3, arg4, arg6), arg5);
    }

    public entry fun mint_eyes_to_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Eyes>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) {
        mint_eyes_kiosk(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun mint_eyes_to_new_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Eyes>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg5, arg6);
        let v2 = v0;
        let v3 = &mut v2;
        mint_eyes_kiosk(arg0, arg1, arg2, arg3, arg4, v3, arg6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    fun mint_head(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Head>, arg5: &mut 0x2::tx_context::TxContext) : Head {
        let v0 = Head{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            rarity      : 0x1::string::utf8(arg3),
            type        : 0x1::string::utf8(b"Head"),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Head>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Head, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Head>(arg4), &v0);
        v0
    }

    public(friend) fun mint_head_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Head>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_head(arg0, arg1, arg2, arg3, arg4, arg6);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Head>(arg5, v0, arg6);
        0x2::object::id<Head>(&v0)
    }

    public entry fun mint_head_to_address(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Head>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Head>(mint_head(arg0, arg1, arg2, arg3, arg4, arg6), arg5);
    }

    public fun mint_head_to_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Head>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) {
        mint_head_kiosk(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun mint_head_to_new_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Head>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg5, arg6);
        let v2 = v0;
        let v3 = &mut v2;
        mint_head_kiosk(arg0, arg1, arg2, arg3, arg4, v3, arg6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    fun mint_misc(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Misc>, arg5: &mut 0x2::tx_context::TxContext) : Misc {
        let v0 = Misc{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            rarity      : 0x1::string::utf8(arg3),
            type        : 0x1::string::utf8(b"Misc"),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Misc>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Misc, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Misc>(arg4), &v0);
        v0
    }

    public(friend) fun mint_misc_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Misc>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_misc(arg0, arg1, arg2, arg3, arg4, arg6);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Misc>(arg5, v0, arg6);
        0x2::object::id<Misc>(&v0)
    }

    public entry fun mint_misc_to_address(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Misc>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Misc>(mint_misc(arg0, arg1, arg2, arg3, arg4, arg6), arg5);
    }

    public entry fun mint_misc_to_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Misc>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) {
        mint_misc_kiosk(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun mint_misc_to_new_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Misc>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg5, arg6);
        let v2 = v0;
        let v3 = &mut v2;
        mint_misc_kiosk(arg0, arg1, arg2, arg3, arg4, v3, arg6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    fun mint_mouth(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Mouth>, arg5: &mut 0x2::tx_context::TxContext) : Mouth {
        let v0 = Mouth{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            rarity      : 0x1::string::utf8(arg3),
            type        : 0x1::string::utf8(b"Mouth"),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Mouth>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Mouth, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Mouth>(arg4), &v0);
        v0
    }

    public(friend) fun mint_mouth_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Mouth>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_mouth(arg0, arg1, arg2, arg3, arg4, arg6);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Mouth>(arg5, v0, arg6);
        0x2::object::id<Mouth>(&v0)
    }

    public entry fun mint_mouth_to_address(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Mouth>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Mouth>(mint_mouth(arg0, arg1, arg2, arg3, arg4, arg6), arg5);
    }

    public entry fun mint_mouth_to_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Mouth>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) {
        mint_mouth_kiosk(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun mint_mouth_to_new_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Mouth>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg5, arg6);
        let v2 = v0;
        let v3 = &mut v2;
        mint_mouth_kiosk(arg0, arg1, arg2, arg3, arg4, v3, arg6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    fun mint_neck(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Neck>, arg5: &mut 0x2::tx_context::TxContext) : Neck {
        let v0 = Neck{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            rarity      : 0x1::string::utf8(arg3),
            type        : 0x1::string::utf8(b"Neck"),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Neck>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Neck, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Neck>(arg4), &v0);
        v0
    }

    public(friend) fun mint_neck_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Neck>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_neck(arg0, arg1, arg2, arg3, arg4, arg6);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Neck>(arg5, v0, arg6);
        0x2::object::id<Neck>(&v0)
    }

    public entry fun mint_neck_to_address(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Neck>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Neck>(mint_neck(arg0, arg1, arg2, arg3, arg4, arg6), arg5);
    }

    public entry fun mint_neck_to_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Neck>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) {
        mint_neck_kiosk(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun mint_neck_to_new_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Neck>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg5, arg6);
        let v2 = v0;
        let v3 = &mut v2;
        mint_neck_kiosk(arg0, arg1, arg2, arg3, arg4, v3, arg6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    fun mint_skin(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Skin>, arg5: &mut 0x2::tx_context::TxContext) : Skin {
        let v0 = Skin{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            rarity      : 0x1::string::utf8(arg3),
            type        : 0x1::string::utf8(b"Skin"),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Skin>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Skin, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Skin>(arg4), &v0);
        v0
    }

    public(friend) fun mint_skin_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Skin>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_skin(arg0, arg1, arg2, arg3, arg4, arg6);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Skin>(arg5, v0, arg6);
        0x2::object::id<Skin>(&v0)
    }

    public entry fun mint_skin_to_address(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Skin>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Skin>(mint_skin(arg0, arg1, arg2, arg3, arg4, arg6), arg5);
    }

    public entry fun mint_skin_to_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Skin>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) {
        mint_skin_kiosk(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun mint_skin_to_new_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Skin>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg5, arg6);
        let v2 = v0;
        let v3 = &mut v2;
        mint_skin_kiosk(arg0, arg1, arg2, arg3, arg4, v3, arg6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    fun mint_top(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Top>, arg5: &mut 0x2::tx_context::TxContext) : Top {
        let v0 = Top{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            rarity      : 0x1::string::utf8(arg3),
            type        : 0x1::string::utf8(b"Top"),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Top>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Top, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Top>(arg4), &v0);
        v0
    }

    public(friend) fun mint_top_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Top>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_top(arg0, arg1, arg2, arg3, arg4, arg6);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Top>(arg5, v0, arg6);
        0x2::object::id<Top>(&v0)
    }

    public entry fun mint_top_to_address(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Top>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Top>(mint_top(arg0, arg1, arg2, arg3, arg4, arg6), arg5);
    }

    public entry fun mint_top_to_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Top>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) {
        mint_top_kiosk(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun mint_top_to_new_kiosk(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Top>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg5, arg6);
        let v2 = v0;
        let v3 = &mut v2;
        mint_top_kiosk(arg0, arg1, arg2, arg3, arg4, v3, arg6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    fun setup_collection<T0: store + key>(arg0: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<T0>, arg1: &0x2::package::Publisher, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<T0, Witness>(v0);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"type"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{type}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://cosmocadia.io"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::art());
        0x1::vector::push_back<0x1::string::String>(v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::game_asset());
        0x1::vector::push_back<0x1::string::String>(v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::collectible());
        let v8 = 0x2::display::new_with_fields<T0>(arg1, v2, v4, arg3);
        0x2::display::add<T0>(&mut v8, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v6));
        0x2::display::update_version<T0>(&mut v8);
        let (v9, v10) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<T0>(arg1, arg3);
        let v11 = v10;
        let v12 = v9;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<T0>(&mut v12, &v11);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<T0>(&mut v12, &v11);
        let (v13, v14) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::init_policy<T0>(arg1, arg3);
        let v15 = v14;
        let v16 = v13;
        let v17 = &mut v16;
        enforce_contract<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>(v17, &v15);
        let (v18, v19) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::init_policy<T0>(arg1, arg3);
        let (v20, v21) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<T0>(arg1, arg3);
        let v22 = v21;
        let v23 = v20;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::p2p_list::enforce<T0>(&mut v23, &v22);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::share<T0, 0x2::sui::SUI>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::new_with_protected_actions<T0, 0x2::sui::SUI>(v1, &v12, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true), arg3));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<T0>(v1, &mut arg0, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(arg2, vector[10000]), arg3), 500, arg3);
        0x2::transfer::public_transfer<0x2::display::Display<T0>>(v8, @0x8b65b5e40844345b64b761278ec578a34fa5290951bea4d96e8459be2e59771b);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<T0>>(v11, @0x8b65b5e40844345b64b761278ec578a34fa5290951bea4d96e8459be2e59771b);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<T0>>(v12);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v19, @0x8b65b5e40844345b64b761278ec578a34fa5290951bea4d96e8459be2e59771b);
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>>(v18);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v15, @0x8b65b5e40844345b64b761278ec578a34fa5290951bea4d96e8459be2e59771b);
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>>(v16);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<T0>>(v22, @0x8b65b5e40844345b64b761278ec578a34fa5290951bea4d96e8459be2e59771b);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<T0>>(v23);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<T0>>(arg0);
    }

    fun withdraw_equipment<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        let (v0, v1) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<T0>(arg0, arg1, arg3);
        let v2 = v1;
        let v3 = &mut v2;
        confirm_withdrawal<T0>(v3);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<T0>(v2, arg2);
        v0
    }

    // decompiled from Move bytecode v6
}

