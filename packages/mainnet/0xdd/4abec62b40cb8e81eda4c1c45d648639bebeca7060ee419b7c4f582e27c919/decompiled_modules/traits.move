module 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::traits {
    struct TraitOption has store {
        name: 0x1::string::String,
        rarity_weight: u64,
        svg_layer: 0x1::string::String,
    }

    struct TraitCategory has store {
        name: 0x1::string::String,
        options: vector<TraitOption>,
    }

    struct TraitCollection has key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
        categories: vector<TraitCategory>,
        total_combinations: u64,
        finalized: bool,
    }

    public fun add_category(arg0: &mut TraitCollection, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: vector<u64>, arg4: vector<vector<u8>>) {
        assert!(!arg0.finalized, 1);
        let v0 = 0x1::vector::length<vector<u8>>(&arg2);
        assert!(0x1::vector::length<u64>(&arg3) == v0, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == v0, 3);
        let v1 = 0x1::vector::empty<TraitOption>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = TraitOption{
                name          : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg2, v2)),
                rarity_weight : *0x1::vector::borrow<u64>(&arg3, v2),
                svg_layer     : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg4, v2)),
            };
            0x1::vector::push_back<TraitOption>(&mut v1, v3);
            v2 = v2 + 1;
        };
        let v4 = TraitCategory{
            name    : 0x1::string::utf8(arg1),
            options : v1,
        };
        0x1::vector::push_back<TraitCategory>(&mut arg0.categories, v4);
    }

    public fun category_options(arg0: &TraitCategory) : &vector<TraitOption> {
        &arg0.options
    }

    public fun create_collection(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : TraitCollection {
        TraitCollection{
            id                 : 0x2::object::new(arg1),
            launch_id          : arg0,
            categories         : 0x1::vector::empty<TraitCategory>(),
            total_combinations : 0,
            finalized          : false,
        }
    }

    public fun finalize_and_share(arg0: TraitCollection) {
        assert!(!arg0.finalized, 1);
        let v0 = 1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<TraitCategory>(&arg0.categories)) {
            let v2 = 0x1::vector::length<TraitOption>(&0x1::vector::borrow<TraitCategory>(&arg0.categories, v1).options);
            if (v2 > 0) {
                v0 = v0 * (v2 as u64);
            };
            v1 = v1 + 1;
        };
        arg0.total_combinations = v0;
        arg0.finalized = true;
        0x2::transfer::share_object<TraitCollection>(arg0);
    }

    public fun get_category(arg0: &TraitCollection, arg1: u64) : &TraitCategory {
        0x1::vector::borrow<TraitCategory>(&arg0.categories, arg1)
    }

    public fun get_rarity_weight(arg0: &TraitCollection, arg1: u64, arg2: u64) : u64 {
        assert!(arg0.finalized, 2);
        0x1::vector::borrow<TraitOption>(&0x1::vector::borrow<TraitCategory>(&arg0.categories, arg1).options, arg2).rarity_weight
    }

    public fun get_svg_layer(arg0: &TraitCollection, arg1: u64, arg2: u64) : 0x1::string::String {
        0x1::vector::borrow<TraitOption>(&0x1::vector::borrow<TraitCategory>(&arg0.categories, arg1).options, arg2).svg_layer
    }

    public fun is_finalized(arg0: &TraitCollection) : bool {
        arg0.finalized
    }

    public fun launch_id(arg0: &TraitCollection) : 0x2::object::ID {
        arg0.launch_id
    }

    public fun num_categories(arg0: &TraitCollection) : u64 {
        0x1::vector::length<TraitCategory>(&arg0.categories)
    }

    public fun num_options_in_category(arg0: &TraitCollection, arg1: u64) : u64 {
        0x1::vector::length<TraitOption>(&0x1::vector::borrow<TraitCategory>(&arg0.categories, arg1).options)
    }

    public fun option_rarity_weight(arg0: &TraitOption) : u64 {
        arg0.rarity_weight
    }

    public fun option_svg_layer(arg0: &TraitOption) : &0x1::string::String {
        &arg0.svg_layer
    }

    public fun total_combinations(arg0: &TraitCollection) : u64 {
        arg0.total_combinations
    }

    // decompiled from Move bytecode v7
}

