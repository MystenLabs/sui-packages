module 0xbcd4cf52418847642228a0075384fb2c2f04277b4ac868cdc1dc8e311c889058::shapes {
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
        image_uri: 0x1::string::String,
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

    entry fun add_shape_design(arg0: &AdminCap, arg1: &mut ShapeCatalog, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64) {
        let v0 = arg1.next_design_id;
        arg1.next_design_id = v0 + 1;
        let v1 = ShapeDesign{
            design_id  : v0,
            name       : arg2,
            rarity     : arg3,
            image_uri  : arg4,
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

    entry fun admin_mint_cover(arg0: &AdminCap, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Kind"), 0x1::string::utf8(b"Collection Cover"));
        let v1 = Shape{
            id         : 0x2::object::new(arg2),
            design_id  : 999,
            name       : 0x1::string::utf8(b"Collection Cover"),
            rarity     : 0x1::string::utf8(b"n/a"),
            image_uri  : arg1,
            number     : 0,
            attributes : v0,
        };
        0x2::transfer::public_transfer<Shape>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun attributes(arg0: &Shape) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    fun background_labels() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Cream"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Mint"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Lavender"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Peach"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Charcoal"));
        v0
    }

    fun background_weights() : vector<u64> {
        vector[30, 25, 20, 15, 10]
    }

    fun border_labels() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Thin"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Medium"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Thick"));
        v0
    }

    fun border_weights() : vector<u64> {
        vector[60, 30, 10]
    }

    public fun design_id(arg0: &Shape) : u64 {
        arg0.design_id
    }

    fun design_is_eligible(arg0: &ShapeDesign) : bool {
        arg0.active && (arg0.max_supply == 0 || arg0.minted < arg0.max_supply)
    }

    fun fill_labels() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Coral"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Teal"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Amber"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Indigo"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Slate"));
        v0
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
        0x2::display::add<Shape>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"SuiBoy's Shapes test collection - a small, capped-supply set used to verify real Sui marketplace conventions (collection identity, filterable attributes, kiosk trading) before they're carried back into the main SuiBoy contracts."));
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
        let v0 = total_eligible_weight(arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::random::new_generator(arg6, arg7);
        let v2 = 0x2::random::generate_u64_in_range(&mut v1, 0, v0 - 1);
        let v3 = 0x1::vector::length<ShapeDesign>(&arg1.designs);
        let v4 = 0;
        while (v4 < v3) {
            if (v3 == v3) {
                let v5 = 0x1::vector::borrow<ShapeDesign>(&arg1.designs, v4);
                if (design_is_eligible(v5)) {
                    if (v2 < v5.weight) {
                    } else {
                        v2 = v2 - v5.weight;
                    };
                };
            };
            v4 = v4 + 1;
        };
        assert!(v3 < v3, 1);
        let v6 = 0x1::vector::borrow_mut<ShapeDesign>(&mut arg1.designs, v3);
        v6.minted = v6.minted + 1;
        let v7 = &mut v1;
        let v8 = background_labels();
        let v9 = background_weights();
        let v10 = &mut v1;
        let v11 = fill_labels();
        let v12 = fill_weights();
        let v13 = &mut v1;
        let v14 = border_labels();
        let v15 = border_weights();
        arg0.minted = arg0.minted + 1;
        let v16 = arg0.minted;
        let v17 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v17, 0x1::string::utf8(b"Rarity"), v6.rarity);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v17, 0x1::string::utf8(b"Background"), roll_weighted_label(v7, &v8, &v9));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v17, 0x1::string::utf8(b"Fill Color"), roll_weighted_label(v10, &v11, &v12));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v17, 0x1::string::utf8(b"Border"), roll_weighted_label(v13, &v14, &v15));
        let v18 = Shape{
            id         : 0x2::object::new(arg7),
            design_id  : v6.design_id,
            name       : v6.name,
            rarity     : v6.rarity,
            image_uri  : v6.image_uri,
            number     : v16,
            attributes : v17,
        };
        let v19 = ShapeMinted{
            shape_id  : 0x2::object::uid_to_address(&v18.id),
            design_id : v6.design_id,
            number    : v16,
            minter    : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<ShapeMinted>(v19);
        0x2::kiosk::lock<Shape>(arg2, arg3, arg4, v18);
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

    fun roll_weighted_label(arg0: &mut 0x2::random::RandomGenerator, arg1: &vector<0x1::string::String>, arg2: &vector<u64>) : 0x1::string::String {
        let v0 = 0x1::vector::length<u64>(arg2);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            v2 = v2 + *0x1::vector::borrow<u64>(arg2, v1);
            v1 = v1 + 1;
        };
        let v3 = 0x2::random::generate_u64_in_range(arg0, 0, v2 - 1);
        let v4 = 0;
        while (v4 < v0) {
            if (v0 == v0) {
                let v5 = *0x1::vector::borrow<u64>(arg2, v4);
                if (v3 < v5) {
                } else {
                    v3 = v3 - v5;
                };
            };
            v4 = v4 + 1;
        };
        *0x1::vector::borrow<0x1::string::String>(arg1, v0)
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

    // decompiled from Move bytecode v7
}

