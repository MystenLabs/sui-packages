module 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item {
    struct ItemHub has key {
        id: 0x2::object::UID,
    }

    struct Item has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        xp: u64,
        type: 0x1::string::String,
    }

    struct ItemType has drop, store {
        description: 0x1::string::String,
        url: 0x2::url::Url,
        xp: u64,
        type: 0x1::string::String,
    }

    struct ITEM has drop {
        dummy_field: bool,
    }

    public fun accessory_type_key() : 0x1::string::String {
        0x1::string::utf8(b"accessory")
    }

    public entry fun add_item_type(arg0: &0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::AdminCap, arg1: &mut ItemHub, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        check_type(arg5);
        let v0 = borrow_item_types_mut(arg1, arg2);
        let v1 = ItemType{
            description : arg3,
            url         : 0x2::url::new_unsafe(0x1::string::to_ascii(arg4)),
            xp          : arg6,
            type        : arg5,
        };
        0x2::table::add<u64, ItemType>(v0, 0x2::table::length<u64, ItemType>(v0), v1);
    }

    public fun armor_type_key() : 0x1::string::String {
        0x1::string::utf8(b"armor")
    }

    public fun boots_type_key() : 0x1::string::String {
        0x1::string::utf8(b"boots")
    }

    public fun borrow_item_types(arg0: &ItemHub, arg1: 0x1::string::String) : &0x2::table::Table<u64, ItemType> {
        0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::check_rarity(arg1);
        0x2::dynamic_object_field::borrow<0x1::string::String, 0x2::table::Table<u64, ItemType>>(&arg0.id, arg1)
    }

    fun borrow_item_types_mut(arg0: &mut ItemHub, arg1: 0x1::string::String) : &mut 0x2::table::Table<u64, ItemType> {
        0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::check_rarity(arg1);
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2::table::Table<u64, ItemType>>(&mut arg0.id, arg1)
    }

    public fun check_type(arg0: 0x1::string::String) {
        assert!(arg0 == weapon_type_key() || arg0 == armor_type_key() || arg0 == accessory_type_key() || arg0 == boots_type_key() || arg0 == hat_type_key() || arg0 == mystery_type_key(), 0);
    }

    public(friend) fun create(arg0: &ItemHub, arg1: &mut 0x2::tx_context::TxContext) : Item {
        let v0 = borrow_item_types(arg0, 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::calclulate_rarity(arg1));
        let v1 = 0x2::table::borrow<u64, ItemType>(v0, 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::rand_u64_from_zero_to(0x2::table::length<u64, ItemType>(v0), arg1));
        Item{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"SuiMo Item"),
            description : v1.description,
            url         : v1.url,
            xp          : v1.xp,
            type        : v1.type,
        }
    }

    public fun hat_type_key() : 0x1::string::String {
        0x1::string::utf8(b"hat")
    }

    fun init(arg0: ITEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ITEM>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://www.suimo.com"));
        let v5 = 0x2::display::new_with_fields<Item>(&v0, v1, v3, arg1);
        0x2::display::update_version<Item>(&mut v5);
        let v6 = ItemHub{id: 0x2::object::new(arg1)};
        let v7 = initialize_common_item_types(arg1);
        0x2::dynamic_object_field::add<0x1::string::String, 0x2::table::Table<u64, ItemType>>(&mut v6.id, 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::common_rarity_key(), v7);
        let v8 = initialize_rare_item_types(arg1);
        0x2::dynamic_object_field::add<0x1::string::String, 0x2::table::Table<u64, ItemType>>(&mut v6.id, 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::rare_rarity_key(), v8);
        let v9 = initialize_epic_item_types(arg1);
        0x2::dynamic_object_field::add<0x1::string::String, 0x2::table::Table<u64, ItemType>>(&mut v6.id, 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::epic_rarity_key(), v9);
        let v10 = initialize_legendary_item_types(arg1);
        0x2::dynamic_object_field::add<0x1::string::String, 0x2::table::Table<u64, ItemType>>(&mut v6.id, 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::legendary_rarity_key(), v10);
        0x2::transfer::share_object<ItemHub>(v6);
        0x2::transfer::public_transfer<0x2::display::Display<Item>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    fun initialize_common_item_types(arg0: &mut 0x2::tx_context::TxContext) : 0x2::table::Table<u64, ItemType> {
        let v0 = 0x2::table::new<u64, ItemType>(arg0);
        let v1 = ItemType{
            description : 0x1::string::utf8(b"White cap"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/hat/white_cap.png"),
            xp          : 1,
            type        : hat_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 0, v1);
        let v2 = ItemType{
            description : 0x1::string::utf8(b"Rags"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/pants/pandas_pants.png"),
            xp          : 1,
            type        : armor_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 1, v2);
        let v3 = ItemType{
            description : 0x1::string::utf8(b"Umbrella"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/weapons/umbrella.png"),
            xp          : 1,
            type        : weapon_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 2, v3);
        let v4 = ItemType{
            description : 0x1::string::utf8(b"Brown boots"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/boots/brown_boots.png"),
            xp          : 1,
            type        : boots_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 3, v4);
        let v5 = ItemType{
            description : 0x1::string::utf8(b"Light earring"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/accessory/light_earring.png"),
            xp          : 1,
            type        : accessory_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 4, v5);
        let v6 = ItemType{
            description : 0x1::string::utf8(b"Milk Cat"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/pets/cat.png"),
            xp          : 1,
            type        : mystery_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 5, v6);
        v0
    }

    fun initialize_epic_item_types(arg0: &mut 0x2::tx_context::TxContext) : 0x2::table::Table<u64, ItemType> {
        let v0 = 0x2::table::new<u64, ItemType>(arg0);
        let v1 = ItemType{
            description : 0x1::string::utf8(b"Cowboy hat"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/hat/cowboy_hat.png"),
            xp          : 3,
            type        : hat_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 0, v1);
        let v2 = ItemType{
            description : 0x1::string::utf8(b"American panties"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/pants/american_panties.png"),
            xp          : 3,
            type        : armor_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 1, v2);
        let v3 = ItemType{
            description : 0x1::string::utf8(b"Sword"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/weapons/sword.png"),
            xp          : 3,
            type        : weapon_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 2, v3);
        let v4 = ItemType{
            description : 0x1::string::utf8(b"Converse"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/boots/converse.png"),
            xp          : 3,
            type        : boots_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 3, v4);
        let v5 = ItemType{
            description : 0x1::string::utf8(b"Star knife"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/accessory/star_knife.png"),
            xp          : 3,
            type        : accessory_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 4, v5);
        let v6 = ItemType{
            description : 0x1::string::utf8(b"Monkey Chuy"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/pets/monkey.png"),
            xp          : 3,
            type        : mystery_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 5, v6);
        v0
    }

    fun initialize_legendary_item_types(arg0: &mut 0x2::tx_context::TxContext) : 0x2::table::Table<u64, ItemType> {
        let v0 = 0x2::table::new<u64, ItemType>(arg0);
        let v1 = ItemType{
            description : 0x1::string::utf8(b"Macdonalds cap"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/hat/mcdonalds_cap.png"),
            xp          : 5,
            type        : hat_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 0, v1);
        let v2 = ItemType{
            description : 0x1::string::utf8(b"Duck"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/pants/duck.png"),
            xp          : 5,
            type        : armor_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 1, v2);
        let v3 = ItemType{
            description : 0x1::string::utf8(b"Glock"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/weapons/Guns.png"),
            xp          : 5,
            type        : weapon_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 2, v3);
        let v4 = ItemType{
            description : 0x1::string::utf8(b"Hermes sandals"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/boots/hermes_sandals.png"),
            xp          : 5,
            type        : boots_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 3, v4);
        let v5 = ItemType{
            description : 0x1::string::utf8(b"Yinyang amulet"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/accessory/yin_yang_necklace.png"),
            xp          : 5,
            type        : accessory_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 4, v5);
        let v6 = ItemType{
            description : 0x1::string::utf8(b"Blue Whale"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/pets/whale.png"),
            xp          : 5,
            type        : mystery_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 5, v6);
        v0
    }

    fun initialize_rare_item_types(arg0: &mut 0x2::tx_context::TxContext) : 0x2::table::Table<u64, ItemType> {
        let v0 = 0x2::table::new<u64, ItemType>(arg0);
        let v1 = ItemType{
            description : 0x1::string::utf8(b"Samurai hat"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/hat/samurai_hat.png"),
            xp          : 2,
            type        : hat_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 0, v1);
        let v2 = ItemType{
            description : 0x1::string::utf8(b"Cave mans skirt"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/pants/cave_man_skirt.png"),
            xp          : 2,
            type        : armor_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 1, v2);
        let v3 = ItemType{
            description : 0x1::string::utf8(b"Guitar"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/weapons/guitar.png"),
            xp          : 2,
            type        : weapon_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 2, v3);
        let v4 = ItemType{
            description : 0x1::string::utf8(b"Dr martens"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/boots/dr_martens.png"),
            xp          : 2,
            type        : boots_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 3, v4);
        let v5 = ItemType{
            description : 0x1::string::utf8(b"Leaves"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/accessory/leaves.png"),
            xp          : 2,
            type        : accessory_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 4, v5);
        let v6 = ItemType{
            description : 0x1::string::utf8(b"Alpine Husky"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmVYMGnoRg6KPnQ3m5tugdgFG1ydvbJWL7XpP1DVf9Unvg/pets/dog.png"),
            xp          : 2,
            type        : mystery_type_key(),
        };
        0x2::table::add<u64, ItemType>(&mut v0, 5, v6);
        v0
    }

    public fun mystery_type_key() : 0x1::string::String {
        0x1::string::utf8(b"mystery")
    }

    public entry fun remove_item_type(arg0: &0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::AdminCap, arg1: &mut ItemHub, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_item_types_mut(arg1, arg2);
        0x2::table::remove<u64, ItemType>(v0, 0x2::table::length<u64, ItemType>(v0) - 1);
    }

    public fun type(arg0: &Item) : 0x1::string::String {
        arg0.type
    }

    public fun weapon_type_key() : 0x1::string::String {
        0x1::string::utf8(b"weapon")
    }

    public fun xp(arg0: &Item) : u64 {
        arg0.xp
    }

    // decompiled from Move bytecode v6
}

