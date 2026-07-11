module 0xf7629467d448228021eb7dfe8d4830be4a7875d987478d3b4439e469967d65ff::shapes {
    struct SHAPES has drop {
        dummy_field: bool,
    }

    struct Shape has store, key {
        id: 0x2::object::UID,
        design_id: u64,
        name: 0x1::string::String,
        rarity: 0x1::string::String,
        image_uri: 0x1::string::String,
        number: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct ShapeDesign has copy, drop, store {
        design_id: u64,
        name: 0x1::string::String,
        rarity: 0x1::string::String,
        shape_kind: u8,
        weight: u64,
        max_supply: u64,
        minted: u64,
        active: bool,
    }

    struct ShapeCatalog has key {
        id: 0x2::object::UID,
        designs: vector<ShapeDesign>,
        next_design_id: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        price: u64,
        treasury: address,
        minted: u64,
        paused: bool,
    }

    struct ShapeDesignAdded has copy, drop {
        design_id: u64,
        name: 0x1::string::String,
        weight: u64,
        max_supply: u64,
    }

    struct ShapeMinted has copy, drop {
        shape_id: address,
        design_id: u64,
        number: u64,
        minter: address,
    }

    entry fun add_shape_design(arg0: &AdminCap, arg1: &mut ShapeCatalog, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: u64) {
        let v0 = arg1.next_design_id;
        arg1.next_design_id = v0 + 1;
        let v1 = ShapeDesign{
            design_id  : v0,
            name       : arg2,
            rarity     : arg3,
            shape_kind : arg4,
            weight     : arg5,
            max_supply : arg6,
            minted     : 0,
            active     : true,
        };
        0x1::vector::push_back<ShapeDesign>(&mut arg1.designs, v1);
        let v2 = ShapeDesignAdded{
            design_id  : v0,
            name       : arg2,
            weight     : arg5,
            max_supply : arg6,
        };
        0x2::event::emit<ShapeDesignAdded>(v2);
    }

    public fun attributes(arg0: &Shape) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    fun background_hex(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"#fdf6e9")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"#eaf7f0")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"#f5ecfb")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"#fff1e6")
        } else {
            0x1::string::utf8(b"#20180a")
        }
    }

    fun background_label(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Cream")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Mint")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Lavender")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Peach")
        } else {
            0x1::string::utf8(b"Charcoal")
        }
    }

    fun background_rect(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"<rect width=\"400\" height=\"400\" fill=\"");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\"/>"));
        v0
    }

    fun background_weights() : vector<u64> {
        vector[30, 25, 20, 15, 10]
    }

    fun base64_encode(arg0: vector<u8>) : 0x1::string::String {
        let v0 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        let v1 = 0x1::vector::length<u8>(&arg0);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 + 3 <= v1) {
            let v4 = *0x1::vector::borrow<u8>(&arg0, v3);
            let v5 = *0x1::vector::borrow<u8>(&arg0, v3 + 1);
            let v6 = *0x1::vector::borrow<u8>(&arg0, v3 + 2);
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, ((v4 >> 2) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, (((v4 & 3) << 4 | v5 >> 4) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, (((v5 & 15) << 2 | v6 >> 6) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, ((v6 & 63) as u64)));
            v3 = v3 + 3;
        };
        let v7 = v1 - v3;
        if (v7 == 1) {
            let v8 = *0x1::vector::borrow<u8>(&arg0, v3);
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, ((v8 >> 2) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, (((v8 & 3) << 4) as u64)));
            0x1::vector::push_back<u8>(&mut v2, 61);
            0x1::vector::push_back<u8>(&mut v2, 61);
        } else if (v7 == 2) {
            let v9 = *0x1::vector::borrow<u8>(&arg0, v3);
            let v10 = *0x1::vector::borrow<u8>(&arg0, v3 + 1);
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, ((v9 >> 2) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, (((v9 & 3) << 4 | v10 >> 4) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, (((v10 & 15) << 2) as u64)));
            0x1::vector::push_back<u8>(&mut v2, 61);
        };
        0x1::string::utf8(v2)
    }

    fun border_label(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Thin")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Medium")
        } else {
            0x1::string::utf8(b"Thick")
        }
    }

    fun border_value(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"4")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"8")
        } else {
            0x1::string::utf8(b"14")
        }
    }

    fun border_weights() : vector<u64> {
        vector[60, 30, 10]
    }

    fun build_image_uri(arg0: u8, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : 0x1::string::String {
        let v0 = svg_open();
        0x1::string::append(&mut v0, background_rect(arg1));
        let v1 = if (arg0 == 0) {
            square_shape(arg2, arg3)
        } else if (arg0 == 1) {
            circle_shape(arg2, arg3)
        } else if (arg0 == 2) {
            rectangle_shape(arg2, arg3)
        } else if (arg0 == 3) {
            triangle_shape(arg2, arg3)
        } else {
            cube_shape(arg2, arg3)
        };
        0x1::string::append(&mut v0, v1);
        0x1::string::append(&mut v0, svg_close());
        let v2 = 0x1::string::utf8(b"data:image/svg+xml;base64,");
        0x1::string::append(&mut v2, base64_encode(0x1::string::into_bytes(v0)));
        v2
    }

    fun circle_shape(arg0: 0x1::string::String, arg1: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"<circle cx=\"200\" cy=\"200\" r=\"115\" fill=\"");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" stroke=\""));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"#111111"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" stroke-width=\""));
        0x1::string::append(&mut v0, arg1);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\"/>"));
        v0
    }

    fun cube_shape(arg0: 0x1::string::String, arg1: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"<polygon points=\"200,60 320,125 320,265 200,330 80,265 80,125\" fill=\"none\" stroke=\"");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"#111111"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" stroke-width=\"2\"/>"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<polygon points=\"200,60 320,125 200,190 80,125\" fill=\""));
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" fill-opacity=\"1\" stroke=\""));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"#111111"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" stroke-width=\""));
        0x1::string::append(&mut v0, arg1);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" stroke-linejoin=\"round\"/>"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<polygon points=\"200,190 320,125 320,265 200,330\" fill=\""));
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" fill-opacity=\"0.75\" stroke=\""));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"#111111"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" stroke-width=\""));
        0x1::string::append(&mut v0, arg1);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" stroke-linejoin=\"round\"/>"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<polygon points=\"200,190 200,330 80,265 80,125\" fill=\""));
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" fill-opacity=\"0.55\" stroke=\""));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"#111111"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" stroke-width=\""));
        0x1::string::append(&mut v0, arg1);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" stroke-linejoin=\"round\"/>"));
        v0
    }

    public fun design_id(arg0: &Shape) : u64 {
        arg0.design_id
    }

    fun design_is_eligible(arg0: &ShapeDesign) : bool {
        arg0.active && (arg0.max_supply == 0 || arg0.minted < arg0.max_supply)
    }

    fun fill_hex(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"#f0763a")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"#2fb872")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"#e0a800")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"#5b3fd6")
        } else {
            0x1::string::utf8(b"#5b6b82")
        }
    }

    fun fill_label(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Coral")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Teal")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Amber")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Indigo")
        } else {
            0x1::string::utf8(b"Slate")
        }
    }

    fun fill_weights() : vector<u64> {
        vector[30, 25, 20, 15, 10]
    }

    fun find_design_mut(arg0: &mut ShapeCatalog, arg1: u64) : &mut ShapeDesign {
        let v0 = 0x1::vector::length<ShapeDesign>(&arg0.designs);
        let v1 = 0;
        while (v1 < v0) {
            if (v0 == v0) {
            };
            v1 = v1 + 1;
        };
        assert!(v0 < v0, 3);
        0x1::vector::borrow_mut<ShapeDesign>(&mut arg0.designs, v0)
    }

    public fun image_uri(arg0: &Shape) : 0x1::string::String {
        arg0.image_uri
    }

    fun init(arg0: SHAPES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SHAPES>(arg0, arg1);
        let v1 = 0x2::display::new<Shape>(&v0, arg1);
        0x2::display::add<Shape>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Shapes #{number} - {name}"));
        0x2::display::add<Shape>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"SuiBoy's Shapes test collection v2 - each Shape's image is generated on-chain from its own rolled Background/Fill Color/Border attributes, not a fixed per-design picture."));
        0x2::display::add<Shape>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_uri}"));
        0x2::display::add<Shape>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://suiboy.fun"));
        0x2::display::update_version<Shape>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<Shape>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Shape>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Shape>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Shape>>(v1, 0x2::tx_context::sender(arg1));
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
        let v5 = MintConfig{
            id       : 0x2::object::new(arg1),
            price    : 10000000,
            treasury : @0xe1089d77e25643ea64ea003106ee093f9d066ad1579027ac8f5f2e0779e190a8,
            minted   : 0,
            paused   : false,
        };
        0x2::transfer::share_object<MintConfig>(v5);
        let v6 = ShapeCatalog{
            id             : 0x2::object::new(arg1),
            designs        : 0x1::vector::empty<ShapeDesign>(),
            next_design_id : 0,
        };
        0x2::transfer::share_object<ShapeCatalog>(v6);
    }

    entry fun mint(arg0: &mut MintConfig, arg1: &mut ShapeCatalog, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<Shape>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == arg0.price, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg0.treasury);
        let v0 = 0x2::random::new_generator(arg6, arg7);
        let v1 = &mut v0;
        let (v2, v3, v4, v5) = roll_design(arg1, v1);
        let v6 = &mut v0;
        mint_internal(arg0, v2, v3, v4, v5, v6, arg2, arg3, arg4, arg7);
    }

    fun mint_internal(arg0: &mut MintConfig, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: &mut 0x2::random::RandomGenerator, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &0x2::transfer_policy::TransferPolicy<Shape>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = background_weights();
        let v1 = roll_weighted_index(arg5, &v0);
        let v2 = fill_weights();
        let v3 = roll_weighted_index(arg5, &v2);
        let v4 = border_weights();
        let v5 = roll_weighted_index(arg5, &v4);
        arg0.minted = arg0.minted + 1;
        let v6 = arg0.minted;
        let v7 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7, 0x1::string::utf8(b"Rarity"), arg3);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7, 0x1::string::utf8(b"Background"), background_label(v1));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7, 0x1::string::utf8(b"Fill Color"), fill_label(v3));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7, 0x1::string::utf8(b"Border"), border_label(v5));
        let v8 = Shape{
            id         : 0x2::object::new(arg9),
            design_id  : arg1,
            name       : arg2,
            rarity     : arg3,
            image_uri  : build_image_uri(arg4, background_hex(v1), fill_hex(v3), border_value(v5)),
            number     : v6,
            attributes : v7,
        };
        let v9 = ShapeMinted{
            shape_id  : 0x2::object::uid_to_address(&v8.id),
            design_id : arg1,
            number    : v6,
            minter    : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<ShapeMinted>(v9);
        0x2::kiosk::lock<Shape>(arg6, arg7, arg8, v8);
    }

    entry fun mint_with_new_kiosk(arg0: &mut MintConfig, arg1: &mut ShapeCatalog, arg2: &0x2::transfer_policy::TransferPolicy<Shape>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg0.price, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury);
        let v0 = 0x2::random::new_generator(arg4, arg5);
        let v1 = &mut v0;
        let (v2, v3, v4, v5) = roll_design(arg1, v1);
        let (v6, v7) = 0x2::kiosk::new(arg5);
        let v8 = v7;
        let v9 = v6;
        let v10 = &mut v0;
        let v11 = &mut v9;
        mint_internal(arg0, v2, v3, v4, v5, v10, v11, &v8, arg2, arg5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v9);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v8, 0x2::tx_context::sender(arg5));
    }

    public fun name(arg0: &Shape) : 0x1::string::String {
        arg0.name
    }

    public fun number(arg0: &Shape) : u64 {
        arg0.number
    }

    public fun rarity(arg0: &Shape) : 0x1::string::String {
        arg0.rarity
    }

    fun rectangle_shape(arg0: 0x1::string::String, arg1: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"<rect x=\"60\" y=\"120\" width=\"280\" height=\"160\" fill=\"");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" stroke=\""));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"#111111"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" stroke-width=\""));
        0x1::string::append(&mut v0, arg1);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\"/>"));
        v0
    }

    fun roll_design(arg0: &mut ShapeCatalog, arg1: &mut 0x2::random::RandomGenerator) : (u64, 0x1::string::String, 0x1::string::String, u8) {
        let v0 = total_eligible_weight(arg0);
        assert!(v0 > 0, 1);
        let v1 = 0x2::random::generate_u64_in_range(arg1, 0, v0 - 1);
        let v2 = 0x1::vector::length<ShapeDesign>(&arg0.designs);
        let v3 = 0;
        while (v3 < v2) {
            if (v2 == v2) {
                let v4 = 0x1::vector::borrow<ShapeDesign>(&arg0.designs, v3);
                if (design_is_eligible(v4)) {
                    if (v1 < v4.weight) {
                    } else {
                        v1 = v1 - v4.weight;
                    };
                };
            };
            v3 = v3 + 1;
        };
        assert!(v2 < v2, 1);
        let v5 = 0x1::vector::borrow_mut<ShapeDesign>(&mut arg0.designs, v2);
        v5.minted = v5.minted + 1;
        (v5.design_id, v5.name, v5.rarity, v5.shape_kind)
    }

    fun roll_weighted_index(arg0: &mut 0x2::random::RandomGenerator, arg1: &vector<u64>) : u64 {
        let v0 = 0x1::vector::length<u64>(arg1);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(arg1, v2);
            v2 = v2 + 1;
        };
        let v3 = 0x2::random::generate_u64_in_range(arg0, 0, v1 - 1);
        let v4 = 0;
        while (v4 < v0) {
            if (v0 == v0) {
                let v5 = *0x1::vector::borrow<u64>(arg1, v4);
                if (v3 < v5) {
                } else {
                    v3 = v3 - v5;
                };
            };
            v4 = v4 + 1;
        };
        v0
    }

    entry fun set_design_active(arg0: &AdminCap, arg1: &mut ShapeCatalog, arg2: u64, arg3: bool) {
        find_design_mut(arg1, arg2).active = arg3;
    }

    entry fun set_paused(arg0: &AdminCap, arg1: &mut MintConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    entry fun set_price(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64) {
        arg1.price = arg2;
    }

    entry fun set_treasury(arg0: &AdminCap, arg1: &mut MintConfig, arg2: address) {
        arg1.treasury = arg2;
    }

    fun square_shape(arg0: 0x1::string::String, arg1: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"<rect x=\"90\" y=\"90\" width=\"220\" height=\"220\" fill=\"");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" stroke=\""));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"#111111"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" stroke-width=\""));
        0x1::string::append(&mut v0, arg1);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\"/>"));
        v0
    }

    fun svg_close() : 0x1::string::String {
        0x1::string::utf8(b"</svg>")
    }

    fun svg_open() : 0x1::string::String {
        0x1::string::utf8(b"<svg viewBox=\"0 0 400 400\" xmlns=\"http://www.w3.org/2000/svg\">")
    }

    fun total_eligible_weight(arg0: &ShapeCatalog) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<ShapeDesign>(&arg0.designs)) {
            let v2 = 0x1::vector::borrow<ShapeDesign>(&arg0.designs, v0);
            if (design_is_eligible(v2)) {
                v1 = v1 + v2.weight;
            };
            v0 = v0 + 1;
        };
        v1
    }

    fun triangle_shape(arg0: 0x1::string::String, arg1: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"<polygon points=\"200,75 320,305 80,305\" fill=\"");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" stroke=\""));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"#111111"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" stroke-width=\""));
        0x1::string::append(&mut v0, arg1);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"\" stroke-linejoin=\"round\"/>"));
        v0
    }

    // decompiled from Move bytecode v7
}

