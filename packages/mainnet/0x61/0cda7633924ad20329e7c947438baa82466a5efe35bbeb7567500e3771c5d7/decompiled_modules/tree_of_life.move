module 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::tree_of_life {
    struct Tree_of_life has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        level: u16,
        exp: u16,
    }

    struct TreeGlobal has key {
        id: 0x2::object::UID,
        balance_SHUI: 0x2::balance::Balance<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>,
        total_water_amount: u64,
        creator: address,
        water_down_last_time_records: 0x2::table::Table<u64, u64>,
        water_down_person_exp_records: 0x2::table::Table<u64, u64>,
        version: u64,
    }

    struct GetFruit has copy, drop {
        meta_id: u64,
        element_reward: 0x1::string::String,
    }

    struct GetElement has copy, drop {
        meta_id: u64,
        element_reward: 0x1::string::String,
    }

    struct FruitOpened has copy, drop {
        meta_id: u64,
        name: 0x1::string::String,
        element_reward: 0x1::string::String,
    }

    struct WaterElement has drop, store {
        class: 0x1::string::String,
        name: 0x1::string::String,
        desc: 0x1::string::String,
    }

    struct Fragment has drop, store {
        class: 0x1::string::String,
        name: 0x1::string::String,
        desc: 0x1::string::String,
    }

    struct Fruit has drop, store {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Tree_of_life{
            id    : 0x2::object::new(arg0),
            name  : 0x1::string::utf8(b"LifeTree1"),
            level : 1,
            exp   : 0,
        };
        0x2::transfer::public_transfer<Tree_of_life>(v0, 0x2::tx_context::sender(arg0));
    }

    fun bytes_to_u64(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(&arg0, v1) as u64) << ((8 * (7 - v1)) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    public fun change_owner(arg0: &mut TreeGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 6);
        arg0.creator = arg1;
    }

    fun check_class(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"Life"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"Holy"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"Memory"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"Resurrect"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"Blood"));
        0x1::vector::contains<0x1::string::String>(&v0, arg0)
    }

    fun clear_vec<T0: drop + store>(arg0: vector<T0>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<T0>(&arg0)) {
            0x1::vector::pop_back<T0>(&mut arg0);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg0);
    }

    fun create_fragments_by_class(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : vector<Fragment> {
        assert!(check_class(&arg1), 5);
        let v0 = 0x1::vector::empty<Fragment>();
        let v1 = 0;
        while (v1 < arg0) {
            let v2 = Fragment{
                class : arg1,
                name  : arg2,
                desc  : arg3,
            };
            0x1::vector::push_back<Fragment>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun create_fruits(arg0: u64) : vector<Fruit> {
        let v0 = 0x1::vector::empty<Fruit>();
        let v1 = 0;
        while (v1 < arg0) {
            let v2 = Fruit{dummy_field: false};
            0x1::vector::push_back<Fruit>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun create_water_elements_by_class(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : vector<WaterElement> {
        assert!(check_class(&arg1), 5);
        let v0 = 0x1::vector::empty<WaterElement>();
        let v1 = 0;
        while (v1 < arg0) {
            let v2 = WaterElement{
                class : arg1,
                name  : arg2,
                desc  : arg3,
            };
            0x1::vector::push_back<WaterElement>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun extract_drop_items(arg0: &mut 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::MetaIdentity, arg1: 0x1::string::String, arg2: u64) {
        get_element_type_by_name(arg1);
        let v0 = get_item_type_by_name(arg1);
        let v1 = 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_items(arg0);
        if (v0 == 0x1::string::utf8(b"Fragment")) {
            clear_vec<Fragment>(0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::extract_items<Fragment>(v1, arg1, arg2));
        } else if (v0 == 0x1::string::utf8(b"Water Element")) {
            clear_vec<WaterElement>(0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::extract_items<WaterElement>(v1, arg1, arg2));
        } else {
            assert!(v0 == 0x1::string::utf8(b"LuckyBox"), 4);
            clear_vec<Fruit>(0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::extract_items<Fruit>(v1, arg1, arg2));
        };
    }

    public(friend) fun fill_items(arg0: &mut 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::MetaIdentity, arg1: 0x1::string::String, arg2: u64) {
        let v0 = get_element_type_by_name(arg1);
        let v1 = get_item_type_by_name(arg1);
        if (v1 == 0x1::string::utf8(b"Fragment")) {
            let v2 = get_desc_by_type(v0, true);
            0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::store_items<Fragment>(0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_items(arg0), arg1, create_fragments_by_class(arg2, v0, arg1, v2));
        } else if (v1 == 0x1::string::utf8(b"Water Element")) {
            let v3 = get_desc_by_type(v0, false);
            0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::store_items<WaterElement>(0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_items(arg0), arg1, create_water_elements_by_class(arg2, v0, arg1, v3));
        } else {
            assert!(v1 == 0x1::string::utf8(b"LuckyBox"), 4);
            0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::store_items<Fruit>(0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_items(arg0), arg1, create_fruits(arg2));
        };
    }

    fun get_desc_by_type(arg0: 0x1::string::String, arg1: bool) : 0x1::string::String {
        if (arg1) {
            if (arg0 == 0x1::string::utf8(b"Holy")) {
                0x1::string::utf8(b"holy water element fragment desc")
            } else if (arg0 == 0x1::string::utf8(b"Memory")) {
                0x1::string::utf8(b"memory water element fragment desc")
            } else if (arg0 == 0x1::string::utf8(b"Blood")) {
                0x1::string::utf8(b"blood water element fragment desc")
            } else if (arg0 == 0x1::string::utf8(b"Resurrect")) {
                0x1::string::utf8(b"resurrect water element fragment desc")
            } else if (arg0 == 0x1::string::utf8(b"Memory")) {
                0x1::string::utf8(b"memory water element fragment desc")
            } else {
                0x1::string::utf8(b"None")
            }
        } else if (arg0 == 0x1::string::utf8(b"Holy")) {
            0x1::string::utf8(b"holy water element desc")
        } else if (arg0 == 0x1::string::utf8(b"Memory")) {
            0x1::string::utf8(b"memory water element fragment desc")
        } else if (arg0 == 0x1::string::utf8(b"Blood")) {
            0x1::string::utf8(b"blood water element fragment desc")
        } else if (arg0 == 0x1::string::utf8(b"Resurrect")) {
            0x1::string::utf8(b"resurrect water element fragment desc")
        } else if (arg0 == 0x1::string::utf8(b"Memory")) {
            0x1::string::utf8(b"memory water element fragment desc")
        } else {
            0x1::string::utf8(b"None")
        }
    }

    public fun get_element_type_by_name(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::length(&arg0);
        let v1 = 0x1::string::utf8(b"Fragment ");
        let v2 = 0x1::string::index_of(&arg0, &v1);
        if (v2 < v0) {
            return 0x1::string::sub_string(&arg0, v2 + 0x1::string::length(&v1), v0)
        };
        let v3 = 0x1::string::utf8(b"Water Element ");
        let v4 = 0x1::string::index_of(&arg0, &v3);
        if (v4 < v0) {
            return 0x1::string::sub_string(&arg0, v4 + 0x1::string::length(&v3), v0)
        };
        0x1::string::utf8(b"none")
    }

    public fun get_item_type_by_name(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Fragment ");
        if (0x1::string::index_of(&arg0, &v0) < 0x1::string::length(&arg0)) {
            return 0x1::string::utf8(b"Fragment")
        };
        let v1 = 0x1::string::utf8(b"Water Element ");
        if (0x1::string::index_of(&arg0, &v1) < 0x1::string::length(&arg0)) {
            return 0x1::string::utf8(b"Water Element")
        };
        let v2 = 0x1::string::utf8(b"LuckyBox");
        if (0x1::string::index_of(&arg0, &v2) < 0x1::string::length(&arg0)) {
            return 0x1::string::utf8(b"LuckyBox")
        };
        0x1::string::utf8(b"none")
    }

    fun get_name_by_type(arg0: 0x1::string::String, arg1: bool) : 0x1::string::String {
        let v0 = arg0;
        if (arg1) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b" Fragment"));
        } else {
            0x1::string::append(&mut v0, 0x1::string::utf8(b" Water Element"));
        };
        v0
    }

    public fun get_random_num(arg0: u64, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        (arg0 + bytes_to_u64(seed(arg3, arg2))) % (arg1 + 1)
    }

    public fun get_total_water_down_amount(arg0: &TreeGlobal) : u64 {
        arg0.total_water_amount
    }

    public fun get_water_down_left_time_mills(arg0: &TreeGlobal, arg1: &0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::MetaIdentity, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0;
        if (0x2::table::contains<u64, u64>(&arg0.water_down_last_time_records, 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_meta_id(arg1))) {
            v1 = *0x2::table::borrow<u64, u64>(&arg0.water_down_last_time_records, 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_meta_id(arg1));
        };
        let v2 = v1 + 8 * 3600000;
        if (v0 < v2) {
            v2 - v0
        } else {
            0
        }
    }

    public fun get_water_down_person_exp(arg0: &TreeGlobal, arg1: &0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::MetaIdentity) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.water_down_person_exp_records, 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_meta_id(arg1))) {
            *0x2::table::borrow<u64, u64>(&arg0.water_down_person_exp_records, 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_meta_id(arg1))
        } else {
            0
        }
    }

    public fun increment(arg0: &mut TreeGlobal, arg1: u64) {
        assert!(arg0.version == 0, 7);
        arg0.version = arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TreeGlobal{
            id                            : 0x2::object::new(arg0),
            balance_SHUI                  : 0x2::balance::zero<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(),
            total_water_amount            : 0,
            creator                       : 0x2::tx_context::sender(arg0),
            water_down_last_time_records  : 0x2::table::new<u64, u64>(arg0),
            water_down_person_exp_records : 0x2::table::new<u64, u64>(arg0),
            version                       : 0,
        };
        0x2::transfer::share_object<TreeGlobal>(v0);
    }

    public entry fun open_fruit(arg0: &TreeGlobal, arg1: &mut 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::MetaIdentity, arg2: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        assert!(arg0.version == 0, 7);
        let Fruit {  } = 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::extract_item<Fruit>(0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_items(arg1), 0x1::string::utf8(b"LuckyBox"));
        let v0 = get_random_num(0, 30610, 0, arg2);
        let v1 = receive_random_element(v0, arg1);
        let v2 = get_random_num(0, 10, ((v0 % 255) as u8), arg2);
        if (v2 < 5) {
            let v3 = receive_random_element(v2, arg1);
            0x1::string::append(&mut v1, 0x1::string::utf8(b";"));
            0x1::string::append(&mut v1, v3);
        };
        0x1::string::append(&mut v1, 0x1::string::utf8(b";"));
        0x1::string::append(&mut v1, random_ticket(arg2));
        let v4 = FruitOpened{
            meta_id        : 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_meta_id(arg1),
            name           : 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_meta_name(arg1),
            element_reward : v1,
        };
        0x2::event::emit<FruitOpened>(v4);
        v1
    }

    fun random_ticket(arg0: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        let v0 = get_random_num(0, 10000, 0, arg0);
        if (v0 == 0) {
            0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui_ticket::mint(5000, arg0);
            0x1::string::utf8(b"SHUI5000")
        } else if (v0 <= 49) {
            0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui_ticket::mint(1000, arg0);
            0x1::string::utf8(b"SHUI1000")
        } else if (v0 <= 250) {
            0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui_ticket::mint(100, arg0);
            0x1::string::utf8(b"SHUI100")
        } else if (v0 <= 1700) {
            0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui_ticket::mint(10, arg0);
            0x1::string::utf8(b"SHUI10")
        } else {
            0x1::string::utf8(b"")
        }
    }

    fun receive_random_element(arg0: u64, arg1: &mut 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::MetaIdentity) : 0x1::string::String {
        let v0 = true;
        let v1 = if (arg0 == 0) {
            let v1 = 0x1::string::utf8(b"Life");
            v0 = false;
            v1
        } else if (arg0 <= 11) {
            let v1 = 0x1::string::utf8(b"Memory");
            v0 = false;
            v1
        } else if (arg0 <= 111) {
            let v1 = 0x1::string::utf8(b"Blood");
            v0 = false;
            v1
        } else if (arg0 <= 611) {
            0x1::string::utf8(b"Holy")
        } else if (arg0 <= 1611) {
            let v1 = 0x1::string::utf8(b"Resurrect");
            v0 = false;
            v1
        } else if (arg0 <= 4111) {
            let v1 = 0x1::string::utf8(b"Memory");
            v0 = false;
            v1
        } else if (arg0 <= 9111) {
            0x1::string::utf8(b"Life")
        } else if (arg0 <= 14611) {
            0x1::string::utf8(b"Blood")
        } else if (arg0 <= 21611) {
            0x1::string::utf8(b"Resurrect")
        } else {
            0x1::string::utf8(b"Holy")
        };
        if (v0) {
            let v3 = 0x1::string::utf8(b"Fragment ");
            let v4 = 0x1::string::utf8(b"Fragment ");
            0x1::string::append(&mut v4, v1);
            0x1::string::append(&mut v4, 0x1::string::utf8(b":5"));
            0x1::string::append(&mut v3, v1);
            let v5 = get_name_by_type(v1, true);
            let v6 = get_desc_by_type(v1, true);
            0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::store_items<Fragment>(0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_items(arg1), v3, create_fragments_by_class(5, v1, v5, v6));
            v4
        } else {
            let v7 = 0x1::string::utf8(b"Water Element ");
            let v8 = 0x1::string::utf8(b"Fragment ");
            0x1::string::append(&mut v7, v1);
            0x1::string::append(&mut v8, v1);
            let v9 = WaterElement{
                class : v1,
                name  : get_name_by_type(v1, false),
                desc  : get_desc_by_type(v1, false),
            };
            0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::store_item<WaterElement>(0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_items(arg1), v7, v9);
            v8
        }
    }

    fun seed(arg0: &mut 0x2::tx_context::TxContext, arg1: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg1);
        let v1 = 0x2::object::new(arg0);
        0x2::object::delete(v1);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x2::tx_context::TxContext>(arg0));
        0x1::vector::append<u8>(&mut v2, v0);
        0x1::vector::append<u8>(&mut v2, 0x2::object::uid_to_bytes(&v1));
        let v3 = 0x2::tx_context::epoch_timestamp_ms(arg0);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&v3));
        0x2::hash::keccak256(&v2)
    }

    public entry fun swap_fragment<T0: drop + store>(arg0: &TreeGlobal, arg1: &mut 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::mission::MissionGlobal, arg2: &mut 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::MetaIdentity, arg3: 0x1::string::String) {
        assert!(arg0.version == 0, 7);
        assert!(check_class(&arg3), 5);
        let v0 = 0x1::string::utf8(b"Fragment ");
        0x1::string::append(&mut v0, arg3);
        let v1 = 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::extract_items<T0>(0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_items(arg2), v0, 10);
        let v2 = 0;
        while (v2 < 0x1::vector::length<T0>(&v1)) {
            0x1::vector::pop_back<T0>(&mut v1);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<T0>(v1);
        let v3 = 0x1::string::utf8(b"Water Element_");
        0x1::string::append(&mut v3, arg3);
        let v4 = WaterElement{
            class : arg3,
            name  : get_name_by_type(arg3, false),
            desc  : get_desc_by_type(arg3, false),
        };
        0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::store_item<WaterElement>(0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_items(arg2), v3, v4);
        let v5 = GetElement{
            meta_id        : 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_meta_id(arg2),
            element_reward : get_name_by_type(arg3, false),
        };
        0x2::event::emit<GetElement>(v5);
        0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::mission::add_process(arg1, 0x1::string::utf8(b"swap water element"), arg2);
    }

    public entry fun water_down(arg0: &mut 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::mission::MissionGlobal, arg1: &mut TreeGlobal, arg2: &mut 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::MetaIdentity, arg3: vector<0x2::coin::Coin<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 7);
        let v0 = 1;
        let v1 = 0x2::clock::timestamp_ms(arg4);
        arg1.total_water_amount = arg1.total_water_amount + v0;
        if (0x2::table::contains<u64, u64>(&arg1.water_down_last_time_records, 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_meta_id(arg2))) {
            let v2 = 0x2::table::borrow_mut<u64, u64>(&mut arg1.water_down_last_time_records, 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_meta_id(arg2));
            assert!(v1 - *v2 > 8 * 3600000, 1);
            *v2 = v1;
        } else {
            0x2::table::add<u64, u64>(&mut arg1.water_down_last_time_records, 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_meta_id(arg2), v1);
        };
        let v3 = 0x1::vector::pop_back<0x2::coin::Coin<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>>(&mut arg3);
        0x2::pay::join_vec<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&mut v3, arg3);
        assert!(0x2::coin::value<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&v3) >= v0 * 1000000000, 3);
        0x2::balance::join<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&mut arg1.balance_SHUI, 0x2::coin::into_balance<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(0x2::coin::split<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&mut v3, v0 * 1000000000, arg5)));
        if (0x2::coin::value<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>>(v3, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(v3);
        };
        0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::mission::add_process(arg0, 0x1::string::utf8(b"water down"), arg2);
        if (0x2::table::contains<u64, u64>(&arg1.water_down_person_exp_records, 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_meta_id(arg2))) {
            if (*0x2::table::borrow<u64, u64>(&arg1.water_down_person_exp_records, 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_meta_id(arg2)) == 2) {
                let v4 = Fruit{dummy_field: false};
                0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::store_item<Fruit>(0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_items(arg2), 0x1::string::utf8(b"LuckyBox"), v4);
                *0x2::table::borrow_mut<u64, u64>(&mut arg1.water_down_person_exp_records, 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_meta_id(arg2)) = 0;
                let v5 = GetFruit{
                    meta_id        : 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_meta_id(arg2),
                    element_reward : 0x1::string::utf8(b"Fruit;"),
                };
                0x2::event::emit<GetFruit>(v5);
            } else {
                let v6 = 0x2::table::borrow_mut<u64, u64>(&mut arg1.water_down_person_exp_records, 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_meta_id(arg2));
                *v6 = *v6 + 1;
            };
        } else {
            0x2::table::add<u64, u64>(&mut arg1.water_down_person_exp_records, 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::get_meta_id(arg2), 1);
        };
    }

    // decompiled from Move bytecode v6
}

