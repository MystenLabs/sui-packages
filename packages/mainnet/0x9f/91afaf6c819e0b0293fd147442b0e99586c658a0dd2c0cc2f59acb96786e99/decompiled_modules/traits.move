module 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits {
    struct TraitOption has store {
        name: 0x1::string::String,
        rarity_weight: u64,
        svg_layers: vector<0x1::string::String>,
    }

    struct TraitCategory has store {
        name: 0x1::string::String,
        options: vector<TraitOption>,
    }

    struct TraitCollection has key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
        creator: address,
        categories: vector<TraitCategory>,
        total_combinations: u64,
        finalized: bool,
    }

    entry fun add_category_empty(arg0: &mut TraitCollection, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert_creator(arg0, arg2);
        assert!(!arg0.finalized, 1);
        let v0 = TraitCategory{
            name    : 0x1::string::utf8(arg1),
            options : 0x1::vector::empty<TraitOption>(),
        };
        0x1::vector::push_back<TraitCategory>(&mut arg0.categories, v0);
    }

    entry fun add_options(arg0: &mut TraitCollection, arg1: u64, arg2: vector<vector<u8>>, arg3: vector<u64>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: &0x2::tx_context::TxContext) {
        assert_creator(arg0, arg8);
        assert!(!arg0.finalized, 1);
        let v0 = 0x1::vector::length<vector<u8>>(&arg2);
        assert!(v0 > 0, 6);
        assert!(v0 <= 255, 8);
        assert!(0x1::vector::length<u64>(&arg3) == v0, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == v0, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg5) == v0, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg6) == v0, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg7) == v0, 3);
        let v1 = 0x1::vector::borrow_mut<TraitCategory>(&mut arg0.categories, arg1);
        let v2 = 0;
        while (v2 < v0) {
            assert!(*0x1::vector::borrow<u64>(&arg3, v2) > 0, 7);
            let v3 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg4, v2)));
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg5, v2)));
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg6, v2)));
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg7, v2)));
            let v4 = TraitOption{
                name          : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg2, v2)),
                rarity_weight : *0x1::vector::borrow<u64>(&arg3, v2),
                svg_layers    : v3,
            };
            0x1::vector::push_back<TraitOption>(&mut v1.options, v4);
            v2 = v2 + 1;
        };
    }

    fun assert_creator(arg0: &TraitCollection, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 4);
    }

    public fun category_options(arg0: &TraitCategory) : &vector<TraitOption> {
        &arg0.options
    }

    public(friend) fun create_collection(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : TraitCollection {
        TraitCollection{
            id                 : 0x2::object::new(arg1),
            launch_id          : arg0,
            creator            : 0x2::tx_context::sender(arg1),
            categories         : 0x1::vector::empty<TraitCategory>(),
            total_combinations : 0,
            finalized          : false,
        }
    }

    public(friend) fun finalize_internal(arg0: &mut TraitCollection) {
        assert!(!arg0.finalized, 1);
        let v0 = 0x1::vector::length<TraitCategory>(&arg0.categories);
        assert!(v0 > 0, 5);
        let v1 = 1;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::length<TraitOption>(&0x1::vector::borrow<TraitCategory>(&arg0.categories, v2).options);
            assert!(v3 > 0, 6);
            assert!(v3 <= 255, 8);
            v1 = v1 * (v3 as u64);
            v2 = v2 + 1;
        };
        arg0.total_combinations = v1;
        arg0.finalized = true;
    }

    public fun get_category(arg0: &TraitCollection, arg1: u64) : &TraitCategory {
        0x1::vector::borrow<TraitCategory>(&arg0.categories, arg1)
    }

    public fun get_rarity_weight(arg0: &TraitCollection, arg1: u64, arg2: u64) : u64 {
        assert!(arg0.finalized, 2);
        0x1::vector::borrow<TraitOption>(&0x1::vector::borrow<TraitCategory>(&arg0.categories, arg1).options, arg2).rarity_weight
    }

    public fun get_svg_layer(arg0: &TraitCollection, arg1: u64, arg2: u64, arg3: u8) : 0x1::string::String {
        let v0 = 0x1::vector::borrow<TraitOption>(&0x1::vector::borrow<TraitCategory>(&arg0.categories, arg1).options, arg2);
        let v1 = (arg3 as u64);
        let v2 = 0x1::vector::length<0x1::string::String>(&v0.svg_layers);
        if (v2 == 0) {
            0x1::string::utf8(b"")
        } else if (v1 < v2) {
            let v4 = *0x1::vector::borrow<0x1::string::String>(&v0.svg_layers, v1);
            if (0x1::string::is_empty(&v4)) {
                *0x1::vector::borrow<0x1::string::String>(&v0.svg_layers, 0)
            } else {
                v4
            }
        } else {
            *0x1::vector::borrow<0x1::string::String>(&v0.svg_layers, 0)
        }
    }

    public fun id(arg0: &TraitCollection) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
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
        0x1::vector::borrow<0x1::string::String>(&arg0.svg_layers, 0)
    }

    public(friend) fun share_collection(arg0: TraitCollection) {
        0x2::transfer::share_object<TraitCollection>(arg0);
    }

    public fun total_combinations(arg0: &TraitCollection) : u64 {
        arg0.total_combinations
    }

    // decompiled from Move bytecode v7
}

