module 0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::collectible {
    struct Meta_borrow {
        collectible_id: 0x2::object::ID,
    }

    struct Config has copy, store {
        max_supply: 0x1::option::Option<u32>,
        minted: u32,
        burned: u32,
        owned: bool,
        burnable: bool,
        dynamic: bool,
        meta_borrowable: bool,
    }

    struct Collection<T0: store> has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::borrow::Referent<0x2::package::Publisher>,
        display_collectible: 0x2::borrow::Referent<0x2::display::Display<Collectible<T0>>>,
        display_attribute: 0x2::borrow::Referent<0x2::display::Display<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>>,
        policy_cap_collectible: 0x2::borrow::Referent<0x2::transfer_policy::TransferPolicyCap<Collectible<T0>>>,
        policy_cap_attribute: 0x2::borrow::Referent<0x2::transfer_policy::TransferPolicyCap<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>>,
        attribute_fields: vector<0x1::string::String>,
        banner_url: 0x1::string::String,
        creator: 0x1::option::Option<0x1::string::String>,
        config: Config,
    }

    struct CollectionCap<phantom T0: store> has store, key {
        id: 0x2::object::UID,
        collection: 0x2::object::ID,
    }

    struct CollectionTicket<phantom T0: store> has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        max_supply: 0x1::option::Option<u32>,
    }

    struct Collectible<T0: store> has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        equipped: 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        meta: 0x1::option::Option<T0>,
    }

    struct TicketClaimed has copy, drop {
        ticket_id: 0x2::object::ID,
        creator: address,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        collection_cap_id: 0x2::object::ID,
        max_supply: 0x1::option::Option<u32>,
        creator: address,
        attributes_fields: vector<0x1::string::String>,
        banner_url: 0x1::string::String,
        dynamic: bool,
        burnable: bool,
    }

    struct CollectibleMinted has copy, drop {
        collection_id: 0x2::object::ID,
        collectible_id: 0x2::object::ID,
        image_url: 0x1::string::String,
        name: 0x1::option::Option<0x1::string::String>,
        description: 0x1::option::Option<0x1::string::String>,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        equipped: 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>,
    }

    struct RevokeOwnership has copy, drop {
        collection_id: 0x2::object::ID,
        collection_cap_id: 0x2::object::ID,
    }

    struct DestroyCollectible has copy, drop {
        collection_id: 0x2::object::ID,
        collectible_id: 0x2::object::ID,
    }

    struct EditMade has copy, drop {
        item_id: 0x2::object::ID,
        edit_name: 0x1::string::String,
        edit_value: 0x1::string::String,
    }

    fun assert_attribute_check<T0: store>(arg0: &Collection<T0>, arg1: &0x1::string::String) {
        assert!(0x1::vector::contains<0x1::string::String>(&arg0.attribute_fields, arg1), 7);
    }

    fun assert_correct_collection<T0: store>(arg0: &CollectionCap<T0>, arg1: 0x2::object::ID) {
        assert!(arg0.collection == arg1, 4);
    }

    fun assert_dynamic<T0: store>(arg0: &Collection<T0>) {
        assert!(arg0.config.dynamic, 5);
    }

    public fun borrow_meta<T0: store>(arg0: &Collectible<T0>) : &0x1::option::Option<T0> {
        &arg0.meta
    }

    public fun borrow_mut_display_attribute<T0: store>(arg0: &mut Collection<T0>, arg1: &CollectionCap<T0>) : (0x2::display::Display<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>, 0x2::borrow::Borrow) {
        0x2::borrow::borrow<0x2::display::Display<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>>(&mut arg0.display_attribute)
    }

    public fun borrow_mut_display_collectible<T0: store>(arg0: &mut Collection<T0>, arg1: &CollectionCap<T0>) : (0x2::display::Display<Collectible<T0>>, 0x2::borrow::Borrow) {
        0x2::borrow::borrow<0x2::display::Display<Collectible<T0>>>(&mut arg0.display_collectible)
    }

    public fun borrow_mut_meta<T0: store>(arg0: &mut Collectible<T0>, arg1: &Collection<T0>) : (T0, Meta_borrow) {
        assert!(is_meta_borrowable<T0>(arg1), 11);
        let v0 = Meta_borrow{collectible_id: 0x2::object::id<Collectible<T0>>(arg0)};
        (0x1::option::extract<T0>(&mut arg0.meta), v0)
    }

    public fun borrow_mut_policy_cap_attribute<T0: store>(arg0: &mut Collection<T0>, arg1: &CollectionCap<T0>) : (0x2::transfer_policy::TransferPolicyCap<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>, 0x2::borrow::Borrow) {
        0x2::borrow::borrow<0x2::transfer_policy::TransferPolicyCap<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>>(&mut arg0.policy_cap_attribute)
    }

    public fun borrow_mut_policy_cap_collectible<T0: store>(arg0: &mut Collection<T0>, arg1: &CollectionCap<T0>) : (0x2::transfer_policy::TransferPolicyCap<Collectible<T0>>, 0x2::borrow::Borrow) {
        0x2::borrow::borrow<0x2::transfer_policy::TransferPolicyCap<Collectible<T0>>>(&mut arg0.policy_cap_collectible)
    }

    public fun borrow_mut_publisher<T0: store>(arg0: &mut Collection<T0>, arg1: &CollectionCap<T0>) : (0x2::package::Publisher, 0x2::borrow::Borrow) {
        0x2::borrow::borrow<0x2::package::Publisher>(&mut arg0.publisher)
    }

    public fun claim_ticket<T0: drop, T1: store>(arg0: T0, arg1: 0x1::option::Option<u32>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 10);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::package::claim<T0>(arg0, arg2);
        assert!(0x2::package::from_module<T1>(&v1), 1);
        let v2 = CollectionTicket<T1>{
            id         : 0x2::object::new(arg2),
            publisher  : v1,
            max_supply : arg1,
        };
        let v3 = TicketClaimed{
            ticket_id : 0x2::object::id<CollectionTicket<T1>>(&v2),
            creator   : v0,
        };
        0x2::event::emit<TicketClaimed>(v3);
        0x2::transfer::transfer<CollectionTicket<T1>>(v2, v0);
    }

    public fun create_attribute_hash<T0: store>(arg0: &Collection<T0>, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>) : vector<u8> {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        let v1 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(&v0 == &v1, 9);
        assert!(0x1::vector::length<0x1::string::String>(&arg0.attribute_fields) != 0, 6);
        let v2 = arg0.attribute_fields;
        let v3 = b"";
        0x1::vector::reverse<0x1::string::String>(&mut arg2);
        assert!(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<0x1::string::String>(&arg2), 13906835630337294335);
        0x1::vector::reverse<0x1::string::String>(&mut arg1);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v5 = 0x1::vector::pop_back<0x1::string::String>(&mut arg1);
            assert!(0x1::vector::contains<0x1::string::String>(&v2, &v5), 7);
            0x1::vector::append<u8>(&mut v3, 0x1::string::into_bytes(0x1::vector::pop_back<0x1::string::String>(&mut arg2)));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(arg1);
        0x1::vector::destroy_empty<0x1::string::String>(arg2);
        0x1::hash::sha2_256(v3)
    }

    public fun create_collection<T0: store>(arg0: CollectionTicket<T0>, arg1: &0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::registry::Registry, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: bool, arg6: bool, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : (Collection<T0>, CollectionCap<T0>) {
        let CollectionTicket {
            id         : v0,
            publisher  : v1,
            max_supply : v2,
        } = arg0;
        0x2::object::delete(v0);
        let v3 = 0x2::display::new<Collectible<T0>>(0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::registry::borrow_publisher(arg1), arg8);
        let (v4, v5) = 0x2::transfer_policy::new<Collectible<T0>>(0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::registry::borrow_publisher(arg1), arg8);
        let (v6, v7) = 0x2::transfer_policy::new<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>(0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::registry::borrow_publisher(arg1), arg8);
        0x2::display::add<Collectible<T0>>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Collectible<T0>>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"image_url"));
        0x2::display::add<Collectible<T0>>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Collectible<T0>>(&mut v3, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<Collectible<T0>>(&mut v3, 0x1::string::utf8(b"equipped"), 0x1::string::utf8(b"{equipped}"));
        0x2::display::update_version<Collectible<T0>>(&mut v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Collectible<T0>>>(v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>>(v6);
        let v8 = Config{
            max_supply      : v2,
            minted          : 0,
            burned          : 0,
            owned           : true,
            burnable        : arg6,
            dynamic         : arg5,
            meta_borrowable : arg7,
        };
        let v9 = Collection<T0>{
            id                     : 0x2::object::new(arg8),
            publisher              : 0x2::borrow::new<0x2::package::Publisher>(v1, arg8),
            display_collectible    : 0x2::borrow::new<0x2::display::Display<Collectible<T0>>>(v3, arg8),
            display_attribute      : 0x2::borrow::new<0x2::display::Display<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>>(0x2::display::new<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>(0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::registry::borrow_publisher(arg1), arg8), arg8),
            policy_cap_collectible : 0x2::borrow::new<0x2::transfer_policy::TransferPolicyCap<Collectible<T0>>>(v5, arg8),
            policy_cap_attribute   : 0x2::borrow::new<0x2::transfer_policy::TransferPolicyCap<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>>(v7, arg8),
            attribute_fields       : arg3,
            banner_url             : arg2,
            creator                : arg4,
            config                 : v8,
        };
        let v10 = CollectionCap<T0>{
            id         : 0x2::object::new(arg8),
            collection : 0x2::object::id<Collection<T0>>(&v9),
        };
        let v11 = CollectionCreated{
            collection_id     : 0x2::object::id<Collection<T0>>(&v9),
            collection_cap_id : 0x2::object::id<CollectionCap<T0>>(&v10),
            max_supply        : v2,
            creator           : 0x2::tx_context::sender(arg8),
            attributes_fields : arg3,
            banner_url        : arg2,
            dynamic           : arg5,
            burnable          : arg6,
        };
        0x2::event::emit<CollectionCreated>(v11);
        (v9, v10)
    }

    public fun destroy_collectible<T0: store>(arg0: &mut Collection<T0>, arg1: &CollectionCap<T0>, arg2: Collectible<T0>) : 0x1::option::Option<T0> {
        let Collectible {
            id          : v0,
            image_url   : _,
            name        : _,
            description : _,
            equipped    : _,
            attributes  : _,
            meta        : v6,
        } = arg2;
        let v7 = v0;
        let v8 = DestroyCollectible{
            collection_id  : 0x2::object::id<Collection<T0>>(arg0),
            collectible_id : 0x2::object::uid_to_inner(&v7),
        };
        0x2::event::emit<DestroyCollectible>(v8);
        0x2::object::delete(v7);
        arg0.config.burned = arg0.config.burned + 1;
        v6
    }

    public fun edit_banner<T0: store>(arg0: &mut Collection<T0>, arg1: &CollectionCap<T0>, arg2: 0x1::string::String) {
        assert_correct_collection<T0>(arg1, 0x2::object::uid_to_inner(&arg0.id));
        arg0.banner_url = arg2;
        let v0 = EditMade{
            item_id    : 0x2::object::id<Collection<T0>>(arg0),
            edit_name  : 0x1::string::utf8(b"banner_url"),
            edit_value : arg2,
        };
        0x2::event::emit<EditMade>(v0);
    }

    public fun get_attribute_fields<T0: store>(arg0: &Collection<T0>) : vector<0x1::string::String> {
        arg0.attribute_fields
    }

    public fun get_attribute_map<T0: store>(arg0: &Collectible<T0>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun get_banner_url<T0: store>(arg0: &Collection<T0>) : 0x1::string::String {
        arg0.banner_url
    }

    public fun get_burned<T0: store>(arg0: &Collection<T0>) : (bool, u32) {
        (arg0.config.burnable, arg0.config.burned)
    }

    public fun get_collection_id_by_cap<T0: store>(arg0: &CollectionCap<T0>) : 0x2::object::ID {
        arg0.collection
    }

    public fun get_creator<T0: store>(arg0: &Collection<T0>) : 0x1::string::String {
        if (0x1::option::is_some<0x1::string::String>(&arg0.creator)) {
            *0x1::option::borrow<0x1::string::String>(&arg0.creator)
        } else {
            0x1::string::utf8(b"")
        }
    }

    public fun get_description<T0: store>(arg0: &Collectible<T0>) : 0x1::string::String {
        arg0.description
    }

    public fun get_equipped_map<T0: store>(arg0: &Collectible<T0>) : 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID> {
        arg0.equipped
    }

    public fun get_image_url<T0: store>(arg0: &Collectible<T0>) : 0x1::string::String {
        arg0.image_url
    }

    public fun get_max_supply<T0: store>(arg0: &Collection<T0>) : 0x1::option::Option<u32> {
        arg0.config.max_supply
    }

    public fun get_minted<T0: store>(arg0: &Collection<T0>) : u32 {
        arg0.config.minted
    }

    public fun get_name<T0: store>(arg0: &Collectible<T0>) : 0x1::string::String {
        arg0.name
    }

    fun internal_join_attribute<T0: store>(arg0: &mut Collectible<T0>, arg1: &Collection<T0>, arg2: 0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>) {
        let v0 = 0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::into_key<T0>(&arg2);
        assert!(0x1::vector::contains<0x1::string::String>(&arg1.attribute_fields, &v0), 7);
        assert!(!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, 0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::into_key<T0>(&arg2)), 8);
        0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::emit_joined<T0>(&arg2, 0x2::object::id<Collectible<T0>>(arg0));
        0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(&mut arg0.equipped, 0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::into_key<T0>(&arg2), 0x2::object::id<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>(&arg2));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, 0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::into_key<T0>(&arg2), 0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::into_value<T0>(&arg2));
        0x2::dynamic_object_field::add<0x1::string::String, 0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>(&mut arg0.id, 0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::into_key<T0>(&arg2), arg2);
    }

    fun internal_split_attribute<T0: store>(arg0: &mut Collectible<T0>, arg1: &Collection<T0>, arg2: 0x1::string::String) : 0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0> {
        assert!(0x1::vector::contains<0x1::string::String>(&arg1.attribute_fields, &arg2), 7);
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, arg2), 8);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &arg2);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x2::object::ID>(&mut arg0.equipped, &arg2);
        let v4 = 0x2::dynamic_object_field::remove<0x1::string::String, 0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>(&mut arg0.id, arg2);
        0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::emit_split<T0>(&v4, 0x2::object::id<Collectible<T0>>(arg0));
        v4
    }

    public fun is_dynamic<T0: store>(arg0: &Collection<T0>) : bool {
        arg0.config.dynamic
    }

    public fun is_meta_borrowable<T0: store>(arg0: &Collection<T0>) : bool {
        arg0.config.meta_borrowable
    }

    public fun join_attribute<T0: store>(arg0: &mut Collectible<T0>, arg1: &mut Collection<T0>, arg2: 0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_dynamic<T0>(arg1);
        internal_join_attribute<T0>(arg0, arg1, arg2);
    }

    public fun mint<T0: store>(arg0: &mut Collection<T0>, arg1: &CollectionCap<T0>, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<vector<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>>, arg6: 0x1::option::Option<T0>, arg7: &mut 0x2::tx_context::TxContext) : Collectible<T0> {
        assert_correct_collection<T0>(arg1, 0x2::object::uid_to_inner(&arg0.id));
        assert!(0x1::option::is_none<u32>(&arg0.config.max_supply) || *0x1::option::borrow<u32>(&arg0.config.max_supply) > arg0.config.minted, 2);
        arg0.config.minted = arg0.config.minted + 1;
        let v0 = 0x1::string::utf8(b"");
        let v1 = Collectible<T0>{
            id          : 0x2::object::new(arg7),
            image_url   : arg3,
            name        : 0x1::option::destroy_with_default<0x1::string::String>(arg2, v0),
            description : 0x1::option::destroy_with_default<0x1::string::String>(arg4, v0),
            equipped    : 0x2::vec_map::empty<0x1::string::String, 0x2::object::ID>(),
            attributes  : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            meta        : arg6,
        };
        if (0x1::option::is_some<vector<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>>(&arg5)) {
            let v2 = 0x1::option::destroy_some<vector<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>>(arg5);
            0x1::vector::reverse<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>(&mut v2);
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>(&v2)) {
                let v4 = &mut v1;
                internal_join_attribute<T0>(v4, arg0, 0x1::vector::pop_back<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>(&mut v2));
                v3 = v3 + 1;
            };
            0x1::vector::destroy_empty<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>(v2);
        } else {
            0x1::option::destroy_none<vector<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>>(arg5);
        };
        let v5 = CollectibleMinted{
            collection_id  : 0x2::object::id<Collection<T0>>(arg0),
            collectible_id : 0x2::object::id<Collectible<T0>>(&v1),
            image_url      : arg3,
            name           : arg2,
            description    : arg4,
            attributes     : v1.attributes,
            equipped       : v1.equipped,
        };
        0x2::event::emit<CollectibleMinted>(v5);
        v1
    }

    public fun mint_attribute<T0: store>(arg0: &mut Collection<T0>, arg1: &CollectionCap<T0>, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::option::Option<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0> {
        assert_correct_collection<T0>(arg1, 0x2::object::uid_to_inner(&arg0.id));
        assert_attribute_check<T0>(arg0, &arg3);
        0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::new<T0>(arg2, arg3, arg4, 0x2::object::uid_to_inner(&arg0.id), arg5, arg0.config.meta_borrowable, arg6)
    }

    public fun return_display_attribute<T0: store>(arg0: &mut Collection<T0>, arg1: 0x2::display::Display<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x2::display::Display<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>>(&mut arg0.display_attribute, arg1, arg2);
    }

    public fun return_display_collectible<T0: store>(arg0: &mut Collection<T0>, arg1: 0x2::display::Display<Collectible<T0>>, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x2::display::Display<Collectible<T0>>>(&mut arg0.display_collectible, arg1, arg2);
    }

    public fun return_meta<T0: store>(arg0: &mut Collectible<T0>, arg1: T0, arg2: Meta_borrow) {
        let Meta_borrow { collectible_id: v0 } = arg2;
        assert!(v0 == 0x2::object::id<Collectible<T0>>(arg0), 12);
        0x1::option::fill<T0>(&mut arg0.meta, arg1);
    }

    public fun return_policy_cap_attribute<T0: store>(arg0: &mut Collection<T0>, arg1: 0x2::transfer_policy::TransferPolicyCap<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x2::transfer_policy::TransferPolicyCap<0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>>(&mut arg0.policy_cap_attribute, arg1, arg2);
    }

    public fun return_policy_cap_collectible<T0: store>(arg0: &mut Collection<T0>, arg1: 0x2::transfer_policy::TransferPolicyCap<Collectible<T0>>, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x2::transfer_policy::TransferPolicyCap<Collectible<T0>>>(&mut arg0.policy_cap_collectible, arg1, arg2);
    }

    public fun return_publisher<T0: store>(arg0: &mut Collection<T0>, arg1: 0x2::package::Publisher, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x2::package::Publisher>(&mut arg0.publisher, arg1, arg2);
    }

    public fun revoke_ownership<T0: store>(arg0: CollectionCap<T0>, arg1: &mut Collection<T0>) {
        let v0 = 0x2::object::id<Collection<T0>>(arg1);
        assert_correct_collection<T0>(&arg0, v0);
        arg1.config.owned = false;
        let CollectionCap {
            id         : v1,
            collection : _,
        } = arg0;
        let v3 = v1;
        let v4 = RevokeOwnership{
            collection_id     : v0,
            collection_cap_id : 0x2::object::uid_to_inner(&v3),
        };
        0x2::event::emit<RevokeOwnership>(v4);
        0x2::object::delete(v3);
    }

    public fun split_attribute<T0: store>(arg0: &mut Collectible<T0>, arg1: &mut Collection<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0> {
        assert_dynamic<T0>(arg1);
        internal_split_attribute<T0>(arg0, arg1, arg2)
    }

    public fun validate_attribute<T0: store + key>(arg0: &Collectible<T0>, arg1: vector<u8>, arg2: vector<0x1::string::String>) : bool {
        let v0 = b"";
        0x1::vector::reverse<0x1::string::String>(&mut arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::into_value<T0>(0x2::dynamic_object_field::borrow<0x1::string::String, 0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::attributes::Attribute<T0>>(&arg0.id, 0x1::vector::pop_back<0x1::string::String>(&mut arg2)))));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(arg2);
        0x1::hash::sha2_256(v0) == arg1
    }

    // decompiled from Move bytecode v6
}

