module 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop {
    struct Builder has key {
        id: 0x2::object::UID,
        equipment: vector<u8>,
        names: vector<vector<u8>>,
        colour_ways: vector<vector<u8>>,
        manufacturers: vector<vector<u8>>,
        rarities: vector<vector<u8>>,
        quantities: vector<vector<u64>>,
    }

    struct GenesisShop has key {
        id: 0x2::object::UID,
        items: 0x2::table::Table<0x1::string::String, 0x2::table_vec::TableVec<Item>>,
    }

    struct GenesisShopV2 has key {
        id: 0x2::object::UID,
        items: 0x2::table::Table<0x1::string::String, 0x2::table_vec::TableVec<Item>>,
    }

    struct Item has copy, drop, store {
        hash: vector<u8>,
        name: 0x1::string::String,
        equipment: 0x1::string::String,
        colour_way: 0x1::string::String,
        manufacturer: 0x1::string::String,
        rarity: 0x1::string::String,
        image_url: 0x1::string::String,
        model_url: 0x1::string::String,
        texture_url: 0x1::string::String,
    }

    public fun add_belt(arg0: &mut GenesisShop, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: &mut 0x2::tx_context::TxContext) : Builder {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        0x2::table::add<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::belt(), 0x2::table_vec::empty<Item>(arg3));
        new_builder(0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::belt_bytes(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::belt_names(), vector[b"Obsidian"], 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::belt_manufacturers(), vector[b"Ultra Rare"], 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::belt_chances(), 3333, arg3)
    }

    public fun add_boots(arg0: &mut GenesisShop, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: &mut 0x2::tx_context::TxContext) : Builder {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        0x2::table::add<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::boots(), 0x2::table_vec::empty<Item>(arg3));
        new_builder(0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::boots_bytes(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::boots_names(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::boots_colour_ways(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::boots_manufacturers(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::boots_rarities(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::boots_chances(), 3333, arg3)
    }

    public fun add_chestpiece(arg0: &mut GenesisShop, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: &mut 0x2::tx_context::TxContext) : Builder {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        0x2::table::add<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::chestpiece(), 0x2::table_vec::empty<Item>(arg3));
        new_builder(0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::chestpiece_bytes(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::chestpiece_names(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::cosmetic_colour_ways(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::chestpiece_manufacturers(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::cosmetic_rarities(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::chestpiece_chances(), 3333, arg3)
    }

    public fun add_helm(arg0: &mut GenesisShop, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: &mut 0x2::tx_context::TxContext) : Builder {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        0x2::table::add<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::helm(), 0x2::table_vec::empty<Item>(arg3));
        new_builder(0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::helm_bytes(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::helm_names(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::cosmetic_colour_ways(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::helm_manufacturers(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::cosmetic_rarities(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::helm_chances(), 3333, arg3)
    }

    public fun add_left_arm(arg0: &mut GenesisShop, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: &mut 0x2::tx_context::TxContext) : Builder {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        0x2::table::add<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::left_arm(), 0x2::table_vec::empty<Item>(arg3));
        new_builder(0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::left_arm_bytes(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::arm_names(), vector[b"Obsidian"], 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::arm_manufacturers(), vector[b"Ultra Rare"], 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::arm_chances(), 3333, arg3)
    }

    public fun add_left_bracer(arg0: &mut GenesisShop, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: &mut 0x2::tx_context::TxContext) : Builder {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        0x2::table::add<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::left_bracer(), 0x2::table_vec::empty<Item>(arg3));
        new_builder(0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::left_bracer_bytes(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::bracer_names(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::cosmetic_colour_ways(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::bracer_manufacturers(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::cosmetic_rarities(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::bracer_chances(), 3333, arg3)
    }

    public fun add_left_glove(arg0: &mut GenesisShop, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: &mut 0x2::tx_context::TxContext) : Builder {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        0x2::table::add<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::left_glove(), 0x2::table_vec::empty<Item>(arg3));
        new_builder(0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::left_glove_bytes(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::glove_names(), vector[b"Obsidian"], 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::glove_manufacturers(), vector[b"Ultra Rare"], 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::glove_chances(), 3333, arg3)
    }

    public fun add_left_pauldron(arg0: &mut GenesisShop, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: &mut 0x2::tx_context::TxContext) : Builder {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        0x2::table::add<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::left_pauldron(), 0x2::table_vec::empty<Item>(arg3));
        new_builder(0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::left_pauldron_bytes(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::pauldrons_names(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::cosmetic_colour_ways(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::pauldrons_manufacturers(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::cosmetic_rarities(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::pauldrons_chances(), 3333, arg3)
    }

    public fun add_legs(arg0: &mut GenesisShop, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: &mut 0x2::tx_context::TxContext) : Builder {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        0x2::table::add<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::legs(), 0x2::table_vec::empty<Item>(arg3));
        new_builder(0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::legs_bytes(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::legs_names(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::legs_colour_ways(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::legs_manufacturers(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::leg_rarities(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::legs_chances(), 3333, arg3)
    }

    public fun add_primary(arg0: &mut GenesisShop, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: &mut 0x2::tx_context::TxContext) : Builder {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        0x2::table::add<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::primary(), 0x2::table_vec::empty<Item>(arg3));
        new_builder(0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::primary_bytes(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::primary_names(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::primary_colour_ways(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::primary_manufacturers(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::primary_rarities(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::primary_chances(), 3333, arg3)
    }

    public fun add_right_arm(arg0: &mut GenesisShop, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: &mut 0x2::tx_context::TxContext) : Builder {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        0x2::table::add<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::right_arm(), 0x2::table_vec::empty<Item>(arg3));
        new_builder(0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::right_arm_bytes(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::arm_names(), vector[b"Obsidian"], 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::arm_manufacturers(), vector[b"Ultra Rare"], 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::arm_chances(), 3333, arg3)
    }

    public fun add_right_bracer(arg0: &mut GenesisShop, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: &mut 0x2::tx_context::TxContext) : Builder {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        0x2::table::add<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::right_bracer(), 0x2::table_vec::empty<Item>(arg3));
        new_builder(0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::right_bracer_bytes(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::bracer_names(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::cosmetic_colour_ways(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::bracer_manufacturers(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::cosmetic_rarities(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::bracer_chances(), 3333, arg3)
    }

    public fun add_right_glove(arg0: &mut GenesisShop, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: &mut 0x2::tx_context::TxContext) : Builder {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        0x2::table::add<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::right_glove(), 0x2::table_vec::empty<Item>(arg3));
        new_builder(0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::right_glove_bytes(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::glove_names(), vector[b"Obsidian"], 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::glove_manufacturers(), vector[b"Ultra Rare"], 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::glove_chances(), 3333, arg3)
    }

    public fun add_right_pauldron(arg0: &mut GenesisShop, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: &mut 0x2::tx_context::TxContext) : Builder {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        0x2::table::add<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::right_pauldron(), 0x2::table_vec::empty<Item>(arg3));
        new_builder(0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::right_pauldron_bytes(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::pauldrons_names(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::cosmetic_colour_ways(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::pauldrons_manufacturers(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::cosmetic_rarities(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::pauldrons_chances(), 3333, arg3)
    }

    public fun add_secondary(arg0: &mut GenesisShop, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: &mut 0x2::tx_context::TxContext) : Builder {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        0x2::table::add<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::secondary(), 0x2::table_vec::empty<Item>(arg3));
        new_builder(0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::secondary_bytes(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::secondary_names(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::secondary_colour_ways(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::secondary_manufacturers(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::secondary_rarities(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::secondary_chances(), 3333, arg3)
    }

    public fun add_shins(arg0: &mut GenesisShop, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: &mut 0x2::tx_context::TxContext) : Builder {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        0x2::table::add<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::shins(), 0x2::table_vec::empty<Item>(arg3));
        new_builder(0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::shins_bytes(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::shins_names(), vector[b"Obsidian"], 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::shins_manufacturers(), vector[b"Ultra Rare"], 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::shins_chances(), 3333, arg3)
    }

    public fun add_tertiary(arg0: &mut GenesisShop, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: &mut 0x2::tx_context::TxContext) : Builder {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        0x2::table::add<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::tertiary(), 0x2::table_vec::empty<Item>(arg3));
        new_builder(0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::tertiary_bytes(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::tertiary_names(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::tertiary_colour_ways(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::tertiary_manufacturers(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::tertiary_rarities(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::tertiary_chances(), 3333, arg3)
    }

    public fun add_upper_torso(arg0: &mut GenesisShop, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: &mut 0x2::tx_context::TxContext) : Builder {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        0x2::table::add<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::upper_torso(), 0x2::table_vec::empty<Item>(arg3));
        new_builder(0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::upper_torso_bytes(), 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::upper_torso_names(), vector[b"Obsidian"], 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::upper_torso_manufacturers(), vector[b"Ultra Rare"], 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::assets::upper_torso_chances(), 3333, arg3)
    }

    public(friend) fun borrow_item_mut(arg0: &mut GenesisShop, arg1: 0x1::string::String) : &mut 0x2::table_vec::TableVec<Item> {
        0x2::table::borrow_mut<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, arg1)
    }

    public(friend) fun borrow_item_mut_v2(arg0: &mut GenesisShopV2, arg1: 0x1::string::String) : &mut 0x2::table_vec::TableVec<Item> {
        0x2::table::borrow_mut<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, arg1)
    }

    public(friend) fun colour_way(arg0: &Item) : 0x1::string::String {
        arg0.colour_way
    }

    public fun destroy_builder(arg0: Builder) {
        let Builder {
            id            : v0,
            equipment     : _,
            names         : v2,
            colour_ways   : _,
            manufacturers : _,
            rarities      : _,
            quantities    : _,
        } = arg0;
        let v7 = v2;
        0x2::object::delete(v0);
        assert!(0x1::vector::is_empty<vector<u8>>(&v7), 1);
    }

    public(friend) fun equipment(arg0: &Item) : 0x1::string::String {
        arg0.equipment
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GenesisShop{
            id    : 0x2::object::new(arg0),
            items : 0x2::table::new<0x1::string::String, 0x2::table_vec::TableVec<Item>>(arg0),
        };
        0x2::transfer::share_object<GenesisShop>(v0);
    }

    public(friend) fun is_set(arg0: &GenesisShop) : bool {
        0x2::table::length<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&arg0.items) == 18
    }

    public(friend) fun is_set_v2(arg0: &GenesisShopV2) : bool {
        0x2::table::length<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&arg0.items) == 18
    }

    public fun keep(arg0: Builder, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Builder>(arg0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun manufacturer(arg0: &Item) : 0x1::string::String {
        arg0.manufacturer
    }

    public fun migrate_shop(arg0: GenesisShop, arg1: &mut 0x2::tx_context::TxContext) {
        let GenesisShop {
            id    : v0,
            items : v1,
        } = arg0;
        0x2::object::delete(v0);
        let v2 = GenesisShopV2{
            id    : 0x2::object::new(arg1),
            items : v1,
        };
        0x2::transfer::share_object<GenesisShopV2>(v2);
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u64)
    }

    public(friend) fun name(arg0: &Item) : 0x1::string::String {
        arg0.name
    }

    fun new_builder(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: vector<vector<u64>>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : Builder {
        let v0 = vector[];
        0x1::vector::reverse<vector<u64>>(&mut arg5);
        while (!0x1::vector::is_empty<vector<u64>>(&arg5)) {
            let v1 = vector[];
            let v2 = 0x1::vector::pop_back<vector<u64>>(&mut arg5);
            0x1::vector::reverse<u64>(&mut v2);
            while (!0x1::vector::is_empty<u64>(&v2)) {
                0x1::vector::push_back<u64>(&mut v1, mul_div(0x1::vector::pop_back<u64>(&mut v2) * 10000 * 10000, arg6, 10000 * 10000 * 10000));
            };
            0x1::vector::destroy_empty<u64>(v2);
            0x1::vector::push_back<vector<u64>>(&mut v0, v1);
        };
        0x1::vector::destroy_empty<vector<u64>>(arg5);
        let v3 = 0;
        0x1::vector::reverse<vector<u64>>(&mut v0);
        while (!0x1::vector::is_empty<vector<u64>>(&v0)) {
            let v4 = 0;
            let v5 = 0x1::vector::pop_back<vector<u64>>(&mut v0);
            0x1::vector::reverse<u64>(&mut v5);
            while (!0x1::vector::is_empty<u64>(&v5)) {
                v4 = v4 + 0x1::vector::pop_back<u64>(&mut v5);
            };
            0x1::vector::destroy_empty<u64>(v5);
            v3 = v3 + v4;
        };
        0x1::vector::destroy_empty<vector<u64>>(v0);
        assert!(v3 == 3333, 2);
        Builder{
            id            : 0x2::object::new(arg7),
            equipment     : arg0,
            names         : arg1,
            colour_ways   : arg2,
            manufacturers : arg3,
            rarities      : arg4,
            quantities    : v0,
        }
    }

    public fun new_item(arg0: &mut GenesisShop, arg1: &mut Builder) {
        let v0 = 0x1::vector::length<vector<u64>>(&arg1.quantities);
        if (v0 == 0) {
            return
        };
        let v1 = 0x1::vector::borrow_mut<vector<u64>>(&mut arg1.quantities, v0 - 1);
        let v2 = *0x1::vector::borrow<vector<u8>>(&arg1.names, v0 - 1);
        let v3 = 0x1::vector::length<u64>(v1) - 1;
        let v4 = 0x1::vector::borrow_mut<u64>(v1, v3);
        if (*v4 == 0) {
            0x1::vector::pop_back<u64>(v1);
            if (0x1::vector::length<u64>(v1) == 0) {
                0x1::vector::pop_back<vector<u64>>(&mut arg1.quantities);
                0x1::vector::pop_back<vector<u8>>(&mut arg1.manufacturers);
                0x1::vector::pop_back<vector<u8>>(&mut arg1.names);
            };
            return
        };
        *v4 = *v4 - 1;
        let (v5, v6) = if (arg1.equipment == 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::tertiary_bytes()) {
            let v7 = 0x1::vector::length<vector<u8>>(&arg1.rarities) - 1;
            (*0x1::vector::borrow<vector<u8>>(&arg1.rarities, v7), *0x1::vector::borrow<vector<u8>>(&arg1.colour_ways, v7))
        } else {
            (*0x1::vector::borrow<vector<u8>>(&arg1.rarities, v3), *0x1::vector::borrow<vector<u8>>(&arg1.colour_ways, v3))
        };
        let v8 = if (arg1.equipment == 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::primary_bytes()) {
            true
        } else if (arg1.equipment == 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::secondary_bytes()) {
            true
        } else {
            arg1.equipment == 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::tertiary_bytes()
        };
        let (v9, v10, v11) = if (v8) {
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::uris::get_weapon(v2)
        } else if (arg1.equipment == 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::helm_bytes()) {
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::uris::get_helm(v2, v6)
        } else if (arg1.equipment == 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::chestpiece_bytes()) {
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::uris::get_chestpiece(v2, v6)
        } else if (arg1.equipment == 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::left_pauldron_bytes()) {
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::uris::get_left_pauldron(v2, v6)
        } else if (arg1.equipment == 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::right_pauldron_bytes()) {
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::uris::get_right_pauldron(v2, v6)
        } else if (arg1.equipment == 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::left_bracer_bytes()) {
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::uris::get_left_bracer(v2, v6)
        } else if (arg1.equipment == 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::right_bracer_bytes()) {
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::uris::get_right_bracer(v2, v6)
        } else {
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::uris::get_other(v2, arg1.equipment, v6)
        };
        let v12 = b"";
        0x1::vector::append<u8>(&mut v12, v2);
        0x1::vector::append<u8>(&mut v12, arg1.equipment);
        0x1::vector::append<u8>(&mut v12, v6);
        let v13 = Item{
            hash         : 0x2::hash::blake2b256(&v12),
            name         : 0x1::string::utf8(v2),
            equipment    : 0x1::string::utf8(arg1.equipment),
            colour_way   : 0x1::string::utf8(v6),
            manufacturer : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg1.manufacturers, v0 - 1)),
            rarity       : 0x1::string::utf8(v5),
            image_url    : 0x1::string::utf8(v9),
            model_url    : 0x1::string::utf8(v10),
            texture_url  : 0x1::string::utf8(v11),
        };
        0x2::table_vec::push_back<Item>(0x2::table::borrow_mut<0x1::string::String, 0x2::table_vec::TableVec<Item>>(&mut arg0.items, 0x1::string::utf8(arg1.equipment)), v13);
        if (*v4 == 0) {
            0x1::vector::pop_back<u64>(v1);
            if (0x1::vector::length<u64>(v1) == 0) {
                0x1::vector::pop_back<vector<u64>>(&mut arg1.quantities);
                0x1::vector::pop_back<vector<u8>>(&mut arg1.manufacturers);
                0x1::vector::pop_back<vector<u8>>(&mut arg1.names);
                if (arg1.equipment == 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::tertiary_bytes()) {
                    0x1::vector::pop_back<vector<u8>>(&mut arg1.rarities);
                    0x1::vector::pop_back<vector<u8>>(&mut arg1.colour_ways);
                };
            };
        };
    }

    public(friend) fun rarity(arg0: &Item) : 0x1::string::String {
        arg0.rarity
    }

    public(friend) fun unpack(arg0: Item) : (vector<u8>, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        let Item {
            hash         : v0,
            name         : v1,
            equipment    : v2,
            colour_way   : v3,
            manufacturer : v4,
            rarity       : v5,
            image_url    : v6,
            model_url    : v7,
            texture_url  : v8,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8)
    }

    // decompiled from Move bytecode v6
}

