module 0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::item {
    struct Item has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        type: 0x1::string::String,
        variant: 0x1::string::String,
        slug: 0x1::string::String,
        attack: u64,
        trait_1: ItemTrait,
        trait_2: ItemTrait,
        trait_3: ItemTrait,
    }

    struct ItemParams has drop, store {
        id: u64,
        type: 0x1::string::String,
        variant: 0x1::string::String,
        slug: 0x1::string::String,
        trait_1: ItemTrait,
        trait_2: ItemTrait,
        trait_3: ItemTrait,
    }

    struct ItemTrait has copy, drop, store {
        id: 0x1::string::String,
        action: 0x1::string::String,
        value: u64,
    }

    struct ItemKey has copy, drop, store {
        type: 0x1::string::String,
    }

    struct AppCap has drop, store {
        base_image_url: 0x1::string::String,
        minting_counter: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AppKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ITEM has drop {
        dummy_field: bool,
    }

    struct ItemMinted has copy, drop {
        id: 0x2::object::ID,
        token_id: u64,
        type: 0x1::string::String,
        variant: 0x1::string::String,
    }

    struct ItemEquipped has copy, drop {
        degen_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        item_type: 0x1::string::String,
    }

    struct ItemUnequipped has copy, drop {
        degen_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        item_type: 0x1::string::String,
    }

    struct Blacksmith has copy, drop {
        new_id: 0x2::object::ID,
        new_token_id: u64,
        new_type: 0x1::string::String,
        new_variant: 0x1::string::String,
        burned_item_ids: vector<0x2::object::ID>,
    }

    struct DegenReequipped has copy, drop {
        degen_id: 0x2::object::ID,
        unequipped_item_ids: vector<0x2::object::ID>,
        equipped_item_ids: vector<0x2::object::ID>,
    }

    struct DegenEquipped has copy, drop {
        degen_id: 0x2::object::ID,
        equipped_item_ids: vector<0x2::object::ID>,
    }

    public fun add_item_to_degen<T0>(arg0: &mut 0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::Degen<T0>, arg1: Item) {
        let v0 = ItemKey{type: arg1.type};
        assert!(!0x2::dynamic_object_field::exists_<ItemKey>(0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::uid_mut<T0>(arg0), v0), 3);
        0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::add_item_type<T0>(arg0, arg1.type, arg1.attack);
        if (arg1.type == 0x1::string::utf8(b"head")) {
            0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::update_head<T0>(arg0, arg1.slug);
        };
        if (arg1.type == 0x1::string::utf8(b"body")) {
            0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::update_body<T0>(arg0, arg1.slug);
        };
        if (arg1.type == 0x1::string::utf8(b"weapon")) {
            0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::update_weapon<T0>(arg0, arg1.slug);
        };
        let v1 = ItemKey{type: arg1.type};
        0x2::dynamic_object_field::add<ItemKey, Item>(0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::uid_mut<T0>(arg0), v1, arg1);
    }

    public fun authorize_app<T0>(arg0: &mut 0x2::object::UID, arg1: 0x1::string::String, arg2: &AdminCap) {
        let v0 = AppKey<T0>{dummy_field: false};
        let v1 = AppCap{
            base_image_url  : arg1,
            minting_counter : 0,
        };
        0x2::dynamic_field::add<AppKey<T0>, AppCap>(arg0, v0, v1);
    }

    public fun burn(arg0: Item) : 0x2::object::UID {
        let Item {
            id       : v0,
            token_id : _,
            type     : _,
            variant  : _,
            slug     : _,
            attack   : _,
            trait_1  : _,
            trait_2  : _,
            trait_3  : _,
        } = arg0;
        v0
    }

    public fun change_loadout<T0>(arg0: &mut 0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::Degen<T0>, arg1: vector<0x1::string::String>, arg2: vector<Item>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg1, v0);
            let v3 = ItemKey{type: v2};
            if (0x2::dynamic_object_field::exists_<ItemKey>(0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::uid_mut<T0>(arg0), v3)) {
                let v4 = remove_item_from_degen<T0>(arg0, v2);
                0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<Item>(&v4));
                0x2::transfer::public_transfer<Item>(v4, 0x2::tx_context::sender(arg3));
            };
            v0 = v0 + 1;
        };
        let v5 = 0;
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        let v7 = 0x1::string::utf8(b"_");
        let v8 = 0x1::string::utf8(b"blank");
        let v9 = 0x1::string::utf8(b"blank");
        let v10 = 0x1::string::utf8(b"blank");
        let v11 = 0x1::vector::empty<u8>();
        while (v5 < 0x1::vector::length<Item>(&arg2)) {
            let v12 = 0x1::vector::pop_back<Item>(&mut arg2);
            if (v12.type == 0x1::string::utf8(b"head")) {
                v8 = v12.slug;
            };
            if (v12.type == 0x1::string::utf8(b"body")) {
                v9 = v12.slug;
            };
            if (v12.type == 0x1::string::utf8(b"weapon")) {
                v10 = v12.slug;
            };
            0x1::vector::push_back<0x2::object::ID>(&mut v6, 0x2::object::id<Item>(&v12));
            add_item_to_degen<T0>(arg0, v12);
            v5 = v5 + 1;
        };
        0x1::vector::append<u8>(&mut v11, *0x1::string::bytes(&v8));
        0x1::vector::append<u8>(&mut v11, *0x1::string::bytes(&v7));
        0x1::vector::append<u8>(&mut v11, *0x1::string::bytes(&v9));
        0x1::vector::append<u8>(&mut v11, *0x1::string::bytes(&v7));
        0x1::vector::append<u8>(&mut v11, *0x1::string::bytes(&v10));
        0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::update_image_url<T0>(arg0, 0x1::string::utf8(v11));
        0x1::vector::destroy_empty<Item>(arg2);
        let v13 = DegenReequipped{
            degen_id            : 0x2::object::id<0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::Degen<T0>>(arg0),
            unequipped_item_ids : v1,
            equipped_item_ids   : v6,
        };
        0x2::event::emit<DegenReequipped>(v13);
    }

    public fun deserialize_degen_params(arg0: vector<u8>) : (vector<ItemParams>, u64) {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x1::vector::empty<ItemParams>();
        0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0));
        0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0));
        0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0));
        0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0));
        0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0));
        0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0));
        0x2::bcs::peel_bool(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0));
        0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0));
        let v2 = 0x2::bcs::peel_vec_length(&mut v0);
        while (v2 > 0) {
            let v3 = &mut v0;
            0x1::vector::push_back<ItemParams>(&mut v1, deserialize_item_params(v3));
            v2 = v2 - 1;
        };
        (v1, 0x2::bcs::peel_u64(&mut v0))
    }

    public fun deserialize_item_params(arg0: &mut 0x2::bcs::BCS) : ItemParams {
        let v0 = 0x2::bcs::peel_u64(arg0);
        let v1 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(arg0));
        let _ = 0x1::string::utf8(0x2::bcs::peel_vec_u8(arg0));
        let _ = 0x1::string::utf8(0x2::bcs::peel_vec_u8(arg0));
        let _ = 0x2::bcs::peel_u64(arg0);
        let _ = 0x1::string::utf8(0x2::bcs::peel_vec_u8(arg0));
        let v6 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(arg0));
        let v7 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(arg0));
        let v8 = deserialize_item_trait(arg0);
        let v9 = deserialize_item_trait(arg0);
        ItemParams{
            id      : v0,
            type    : v1,
            variant : v6,
            slug    : v7,
            trait_1 : v8,
            trait_2 : v9,
            trait_3 : deserialize_item_trait(arg0),
        }
    }

    public fun deserialize_item_trait(arg0: &mut 0x2::bcs::BCS) : ItemTrait {
        ItemTrait{
            id     : 0x1::string::utf8(0x2::bcs::peel_vec_u8(arg0)),
            action : 0x1::string::utf8(0x2::bcs::peel_vec_u8(arg0)),
            value  : 0x2::bcs::peel_u64(arg0),
        }
    }

    public fun deserialize_items(arg0: vector<u8>) : vector<ItemParams> {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x1::vector::empty<ItemParams>();
        let v2 = 0x2::bcs::peel_vec_length(&mut v0);
        while (v2 > 0) {
            let v3 = &mut v0;
            0x1::vector::push_back<ItemParams>(&mut v1, deserialize_item_params(v3));
            v2 = v2 - 1;
        };
        v1
    }

    public fun deserialize_single_item_params(arg0: vector<u8>) : ItemParams {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = &mut v0;
        deserialize_item_params(v1)
    }

    public fun equip<T0>(arg0: &mut 0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::Degen<T0>, arg1: Item) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<Item>(&arg1));
        add_item_to_degen<T0>(arg0, arg1);
        let v1 = DegenReequipped{
            degen_id            : 0x2::object::id<0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::Degen<T0>>(arg0),
            unequipped_item_ids : 0x1::vector::empty<0x2::object::ID>(),
            equipped_item_ids   : v0,
        };
        0x2::event::emit<DegenReequipped>(v1);
    }

    public fun equip_all<T0>(arg0: &mut 0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::Degen<T0>, arg1: vector<Item>) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        while (v0 < 0x1::vector::length<Item>(&arg1)) {
            let v2 = 0x1::vector::pop_back<Item>(&mut arg1);
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<Item>(&v2));
            add_item_to_degen<T0>(arg0, v2);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<Item>(arg1);
        let v3 = DegenEquipped{
            degen_id          : 0x2::object::id<0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::Degen<T0>>(arg0),
            equipped_item_ids : v1,
        };
        0x2::event::emit<DegenEquipped>(v3);
    }

    public fun get_token_id(arg0: &Item) : u64 {
        arg0.token_id
    }

    fun init(arg0: ITEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Degen Item - {variant}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://degensdragonsgame.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cdn.orangecomet.io/degens/items/{type}/{variant}.gif"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Good luck!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Comet Labs"));
        let v4 = 0x2::package::claim<ITEM>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Item>(&v4, v0, v2, arg1);
        0x2::display::update_version<Item>(&mut v5);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Item>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun is_authorized<T0>(arg0: &0x2::object::UID) : bool {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<AppKey<T0>>(arg0, v0)
    }

    public fun mint(arg0: &ItemParams, arg1: &mut 0x2::tx_context::TxContext) : Item {
        let v0 = 0x2::object::new(arg1);
        let v1 = ItemMinted{
            id       : 0x2::object::uid_to_inner(&v0),
            token_id : arg0.id,
            type     : arg0.type,
            variant  : arg0.variant,
        };
        0x2::event::emit<ItemMinted>(v1);
        Item{
            id       : v0,
            token_id : arg0.id,
            type     : arg0.type,
            variant  : arg0.variant,
            slug     : arg0.slug,
            attack   : arg0.trait_1.value + arg0.trait_2.value + arg0.trait_3.value,
            trait_1  : arg0.trait_1,
            trait_2  : arg0.trait_2,
            trait_3  : arg0.trait_3,
        }
    }

    public fun reequip<T0>(arg0: &mut 0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::Degen<T0>, arg1: vector<0x1::string::String>, arg2: vector<Item>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg1, v0);
            let v3 = ItemKey{type: v2};
            if (0x2::dynamic_object_field::exists_<ItemKey>(0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::uid_mut<T0>(arg0), v3)) {
                let v4 = remove_item_from_degen<T0>(arg0, v2);
                0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<Item>(&v4));
                0x2::transfer::public_transfer<Item>(v4, 0x2::tx_context::sender(arg3));
            };
            v0 = v0 + 1;
        };
        let v5 = 0;
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        while (v5 < 0x1::vector::length<Item>(&arg2)) {
            let v7 = 0x1::vector::pop_back<Item>(&mut arg2);
            0x1::vector::push_back<0x2::object::ID>(&mut v6, 0x2::object::id<Item>(&v7));
            add_item_to_degen<T0>(arg0, v7);
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<Item>(arg2);
        let v8 = DegenReequipped{
            degen_id            : 0x2::object::id<0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::Degen<T0>>(arg0),
            unequipped_item_ids : v1,
            equipped_item_ids   : v6,
        };
        0x2::event::emit<DegenReequipped>(v8);
    }

    public fun remove_item_from_degen<T0>(arg0: &mut 0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::Degen<T0>, arg1: 0x1::string::String) : Item {
        let v0 = ItemKey{type: arg1};
        assert!(0x2::dynamic_object_field::exists_<ItemKey>(0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::uid_mut<T0>(arg0), v0), 3);
        let v1 = ItemKey{type: arg1};
        let v2 = 0x2::dynamic_object_field::remove<ItemKey, Item>(0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::uid_mut<T0>(arg0), v1);
        0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::remove_item_type<T0>(arg0, arg1, v2.attack);
        let v3 = 0x1::string::utf8(b"BLANK");
        if (v2.type == 0x1::string::utf8(b"head")) {
            0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::update_head<T0>(arg0, v3);
        };
        if (v2.type == 0x1::string::utf8(b"body")) {
            0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::update_body<T0>(arg0, v3);
        };
        if (v2.type == 0x1::string::utf8(b"weapon")) {
            0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::update_weapon<T0>(arg0, v3);
        };
        v2
    }

    public fun revoke_auth<T0>(arg0: &mut 0x2::object::UID, arg1: &AdminCap) {
        let v0 = AppKey<T0>{dummy_field: false};
        let AppCap {
            base_image_url  : _,
            minting_counter : _,
        } = 0x2::dynamic_field::remove<AppKey<T0>, AppCap>(arg0, v0);
    }

    public fun strip_degen<T0>(arg0: &mut 0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::Degen<T0>, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg1, v0);
            let v3 = ItemKey{type: v2};
            if (0x2::dynamic_object_field::exists_<ItemKey>(0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::uid_mut<T0>(arg0), v3)) {
                let v4 = remove_item_from_degen<T0>(arg0, v2);
                0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<Item>(&v4));
                0x2::transfer::public_transfer<Item>(v4, 0x2::tx_context::sender(arg2));
            };
            v0 = v0 + 1;
        };
    }

    public fun trade(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<Item>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : Item {
        let v0 = 0x2::bcs::new(arg1);
        let v1 = &mut v0;
        let v2 = deserialize_item_params(v1);
        let v3 = 0x2::object::new(arg4);
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        let v5 = 0x1::vector::length<Item>(&arg2);
        let v6 = 0;
        assert!(v5 == 3, 1);
        while (v6 < v5) {
            let v7 = 0x1::vector::pop_back<Item>(&mut arg2);
            assert!(v7.type == arg3, 4);
            let v8 = burn(v7);
            0x1::vector::push_back<0x2::object::ID>(&mut v4, 0x2::object::uid_to_inner(&v8));
            0x2::object::delete(v8);
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<Item>(arg2);
        let v9 = Blacksmith{
            new_id          : 0x2::object::uid_to_inner(&v3),
            new_token_id    : v2.id,
            new_type        : v2.type,
            new_variant     : v2.variant,
            burned_item_ids : v4,
        };
        0x2::event::emit<Blacksmith>(v9);
        Item{
            id       : v3,
            token_id : v2.id,
            type     : v2.type,
            variant  : v2.variant,
            slug     : v2.slug,
            attack   : v2.trait_1.value + v2.trait_2.value + v2.trait_3.value,
            trait_1  : v2.trait_1,
            trait_2  : v2.trait_2,
            trait_3  : v2.trait_3,
        }
    }

    public fun unequip<T0>(arg0: &mut 0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::Degen<T0>, arg1: 0x1::string::String) : Item {
        let v0 = remove_item_from_degen<T0>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<Item>(&v0));
        let v2 = DegenReequipped{
            degen_id            : 0x2::object::id<0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::Degen<T0>>(arg0),
            unequipped_item_ids : v1,
            equipped_item_ids   : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::event::emit<DegenReequipped>(v2);
        v0
    }

    public fun unequip_all<T0>(arg0: &mut 0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::Degen<T0>, arg1: vector<0x1::string::String>) : vector<Item> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<Item>();
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg1, v0);
            let v3 = ItemKey{type: v2};
            if (0x2::dynamic_object_field::exists_<ItemKey>(0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::degen::uid_mut<T0>(arg0), v3)) {
                0x1::vector::push_back<Item>(&mut v1, remove_item_from_degen<T0>(arg0, v2));
            };
            v0 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

