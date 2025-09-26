module 0xbc7cc3adbef8aad82f92030fd90157fda53800984fa4563d2dedd68c675bedd1::vendetta_collectible {
    struct VendettaCollectible has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        number: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct CollectibleMetadata has store {
        max_supply: u64,
        current_supply: u64,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        price: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct CollectibleRegistry has key {
        id: 0x2::object::UID,
        count: u64,
        is_paused: bool,
        collections: 0x2::table::Table<0x1::string::String, CollectibleMetadata>,
    }

    struct VENDETTA_COLLECTIBLE has drop {
        dummy_field: bool,
    }

    struct Mint has copy, drop {
        name: 0x1::string::String,
        type_name: 0x1::type_name::TypeName,
        price: u64,
        number: u64,
    }

    entry fun add_attributes_to_collection(arg0: &0xbc7cc3adbef8aad82f92030fd90157fda53800984fa4563d2dedd68c675bedd1::collectible_authority::AdminCap, arg1: &mut CollectibleRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        assert!(0x2::table::contains<0x1::string::String, CollectibleMetadata>(&arg1.collections, arg2), 3);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut 0x2::table::borrow_mut<0x1::string::String, CollectibleMetadata>(&mut arg1.collections, arg2).attributes, arg3, arg4);
    }

    entry fun add_collectible_metadata(arg0: &0xbc7cc3adbef8aad82f92030fd90157fda53800984fa4563d2dedd68c675bedd1::collectible_authority::AdminCap, arg1: &mut CollectibleRegistry, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>) {
        assert!(0x1::vector::length<0x1::string::String>(&arg7) > 0, 0);
        assert!(0x1::vector::length<0x1::string::String>(&arg7) == 0x1::vector::length<0x1::string::String>(&arg8), 1);
        assert!(!0x2::table::contains<0x1::string::String, CollectibleMetadata>(&arg1.collections, arg2), 2);
        let v0 = CollectibleMetadata{
            max_supply     : arg3,
            current_supply : 0,
            image_url      : arg4,
            description    : arg5,
            price          : arg6,
            attributes     : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg7, arg8),
        };
        0x2::table::add<0x1::string::String, CollectibleMetadata>(&mut arg1.collections, arg2, v0);
    }

    fun init(arg0: VENDETTA_COLLECTIBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<VENDETTA_COLLECTIBLE>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<VendettaCollectible>(&v0, arg1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"number"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name} #{number}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{number}"));
        let v7 = 0x2::display::new_with_fields<VendettaCollectible>(&v0, v3, v5, arg1);
        0x2::display::update_version<VendettaCollectible>(&mut v7);
        let v8 = CollectibleRegistry{
            id          : 0x2::object::new(arg1),
            count       : 0,
            is_paused   : true,
            collections : 0x2::table::new<0x1::string::String, CollectibleMetadata>(arg1),
        };
        let v9 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::display::Display<VendettaCollectible>>(v7, v9);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v9);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<VendettaCollectible>>(v2, v9);
        0x2::transfer::share_object<CollectibleRegistry>(v8);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<VendettaCollectible>>(v1);
    }

    fun is_collectible_available(arg0: &CollectibleRegistry, arg1: 0x1::string::String) : bool {
        let v0 = 0x2::table::borrow<0x1::string::String, CollectibleMetadata>(&arg0.collections, arg1);
        v0.current_supply < v0.max_supply
    }

    public fun mint_collectible(arg0: &0xbc7cc3adbef8aad82f92030fd90157fda53800984fa4563d2dedd68c675bedd1::collectible_authority::CollectibleOperatorCap, arg1: &mut CollectibleRegistry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : VendettaCollectible {
        assert!(!arg1.is_paused, 5);
        assert!(0x2::table::contains<0x1::string::String, CollectibleMetadata>(&arg1.collections, arg2), 3);
        assert!(is_collectible_available(arg1, arg2), 4);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, CollectibleMetadata>(&mut arg1.collections, arg2);
        let v1 = VendettaCollectible{
            id          : 0x2::object::new(arg3),
            name        : arg2,
            image_url   : v0.image_url,
            description : v0.description,
            number      : v0.current_supply + 1,
            attributes  : v0.attributes,
        };
        arg1.count = arg1.count + 1;
        v0.current_supply = v0.current_supply + 1;
        let v2 = Mint{
            name      : arg2,
            type_name : 0x1::type_name::with_defining_ids<VendettaCollectible>(),
            price     : v0.price,
            number    : v1.number,
        };
        0x2::event::emit<Mint>(v2);
        v1
    }

    entry fun toggle_pause(arg0: &0xbc7cc3adbef8aad82f92030fd90157fda53800984fa4563d2dedd68c675bedd1::collectible_authority::AdminCap, arg1: &mut CollectibleRegistry) {
        arg1.is_paused = !arg1.is_paused;
    }

    entry fun update_attributes(arg0: &0xbc7cc3adbef8aad82f92030fd90157fda53800984fa4563d2dedd68c675bedd1::collectible_authority::AdminCap, arg1: &mut CollectibleRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        assert!(0x2::table::contains<0x1::string::String, CollectibleMetadata>(&arg1.collections, arg2), 3);
        *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut 0x2::table::borrow_mut<0x1::string::String, CollectibleMetadata>(&mut arg1.collections, arg2).attributes, &arg3) = arg4;
    }

    entry fun update_description(arg0: &0xbc7cc3adbef8aad82f92030fd90157fda53800984fa4563d2dedd68c675bedd1::collectible_authority::AdminCap, arg1: &mut CollectibleRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(0x2::table::contains<0x1::string::String, CollectibleMetadata>(&arg1.collections, arg2), 3);
        0x2::table::borrow_mut<0x1::string::String, CollectibleMetadata>(&mut arg1.collections, arg2).description = arg3;
    }

    entry fun update_image_url(arg0: &0xbc7cc3adbef8aad82f92030fd90157fda53800984fa4563d2dedd68c675bedd1::collectible_authority::AdminCap, arg1: &mut CollectibleRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(0x2::table::contains<0x1::string::String, CollectibleMetadata>(&arg1.collections, arg2), 3);
        0x2::table::borrow_mut<0x1::string::String, CollectibleMetadata>(&mut arg1.collections, arg2).image_url = arg3;
    }

    entry fun update_max_supply(arg0: &0xbc7cc3adbef8aad82f92030fd90157fda53800984fa4563d2dedd68c675bedd1::collectible_authority::AdminCap, arg1: &mut CollectibleRegistry, arg2: 0x1::string::String, arg3: u64) {
        assert!(0x2::table::contains<0x1::string::String, CollectibleMetadata>(&arg1.collections, arg2), 3);
        0x2::table::borrow_mut<0x1::string::String, CollectibleMetadata>(&mut arg1.collections, arg2).max_supply = arg3;
    }

    entry fun update_price(arg0: &0xbc7cc3adbef8aad82f92030fd90157fda53800984fa4563d2dedd68c675bedd1::collectible_authority::AdminCap, arg1: &mut CollectibleRegistry, arg2: 0x1::string::String, arg3: u64) {
        assert!(0x2::table::contains<0x1::string::String, CollectibleMetadata>(&arg1.collections, arg2), 3);
        0x2::table::borrow_mut<0x1::string::String, CollectibleMetadata>(&mut arg1.collections, arg2).price = arg3;
    }

    // decompiled from Move bytecode v6
}

