module 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core {
    struct MasterAdminCap has key {
        id: 0x2::object::UID,
    }

    struct CharacterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TemplateRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        ssr_templates: 0x2::table::Table<u64, CharacterTemplate>,
        sr_templates: 0x2::table::Table<u64, CharacterTemplate>,
        r_templates: 0x2::table::Table<u64, CharacterTemplate>,
        template_versions: 0x2::table::Table<u64, u64>,
        active_ssr_pool: vector<u64>,
        active_sr_pool: vector<u64>,
        active_r_pool: vector<u64>,
    }

    struct GlobalGameState has key {
        id: 0x2::object::UID,
        version: u64,
        next_character_id: u64,
        next_crown_id: u64,
        total_characters_by_rarity: vector<u64>,
    }

    struct CharacterTemplate has copy, drop, store {
        game_id: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct ItemMinted has copy, drop {
        item_type: 0x1::string::String,
        item_id: u64,
        rarity: u8,
        name: 0x1::string::String,
        owner: address,
        mint_timestamp: u64,
    }

    public fun add_character_template(arg0: &CharacterAdminCap, arg1: &mut TemplateRegistry, arg2: u64, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg4 >= 1 && arg4 <= 3, 2);
        let v0 = CharacterTemplate{
            game_id   : arg2,
            name      : 0x1::string::utf8(arg3),
            image_url : 0x1::string::utf8(arg5),
        };
        add_template_to_registry(arg1, v0, arg4, arg6)
    }

    public(friend) fun add_template_to_registry(arg0: &mut TemplateRegistry, arg1: CharacterTemplate, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg1.game_id;
        let v1 = if (arg2 == 1) {
            true
        } else if (arg2 == 2) {
            true
        } else {
            arg2 == 3
        };
        assert!(v1, 2);
        if (arg2 == 3) {
            0x2::table::add<u64, CharacterTemplate>(&mut arg0.ssr_templates, v0, arg1);
            0x1::vector::push_back<u64>(&mut arg0.active_ssr_pool, v0);
        } else if (arg2 == 2) {
            0x2::table::add<u64, CharacterTemplate>(&mut arg0.sr_templates, v0, arg1);
            0x1::vector::push_back<u64>(&mut arg0.active_sr_pool, v0);
        } else {
            0x2::table::add<u64, CharacterTemplate>(&mut arg0.r_templates, v0, arg1);
            0x1::vector::push_back<u64>(&mut arg0.active_r_pool, v0);
        };
        0x2::table::add<u64, u64>(&mut arg0.template_versions, v0, 1);
        v0
    }

    public fun batch_add_templates(arg0: &CharacterAdminCap, arg1: &mut TemplateRegistry, arg2: vector<CharacterTemplate>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : vector<u64> {
        assert!(0x1::vector::length<CharacterTemplate>(&arg2) == 0x1::vector::length<u8>(&arg3), 3);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<CharacterTemplate>(&arg2)) {
            0x1::vector::push_back<u64>(&mut v0, add_template_to_registry(arg1, *0x1::vector::borrow<CharacterTemplate>(&arg2, v1), *0x1::vector::borrow<u8>(&arg3, v1), arg4));
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_and_share_template_registry(arg0: &MasterAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<TemplateRegistry>(create_template_registry(arg1));
    }

    public fun create_character_admin(arg0: &MasterAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CharacterAdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<CharacterAdminCap>(v0, arg1);
    }

    public fun create_character_template(arg0: &CharacterAdminCap, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String) : CharacterTemplate {
        CharacterTemplate{
            game_id   : arg1,
            name      : arg2,
            image_url : arg3,
        }
    }

    public(friend) fun create_template_registry(arg0: &mut 0x2::tx_context::TxContext) : TemplateRegistry {
        let v0 = TemplateRegistry{
            id                : 0x2::object::new(arg0),
            version           : 1,
            ssr_templates     : 0x2::table::new<u64, CharacterTemplate>(arg0),
            sr_templates      : 0x2::table::new<u64, CharacterTemplate>(arg0),
            r_templates       : 0x2::table::new<u64, CharacterTemplate>(arg0),
            template_versions : 0x2::table::new<u64, u64>(arg0),
            active_ssr_pool   : 0x1::vector::empty<u64>(),
            active_sr_pool    : 0x1::vector::empty<u64>(),
            active_r_pool     : 0x1::vector::empty<u64>(),
        };
        let v1 = &mut v0;
        initialize_registry_with_defaults(v1, arg0);
        v0
    }

    public fun deactivate_template(arg0: &CharacterAdminCap, arg1: &mut TemplateRegistry, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(template_exists(arg1, arg2, arg3), 0);
        let v0 = if (arg3 == 3) {
            &mut arg1.active_ssr_pool
        } else if (arg3 == 2) {
            &mut arg1.active_sr_pool
        } else {
            &mut arg1.active_r_pool
        };
        let (v1, v2) = 0x1::vector::index_of<u64>(v0, &arg2);
        if (v1) {
            0x1::vector::remove<u64>(v0, v2);
        };
    }

    public(friend) fun emit_item_minted(arg0: 0x1::string::String, arg1: u64, arg2: u8, arg3: 0x1::string::String, arg4: address, arg5: u64) {
        let v0 = ItemMinted{
            item_type      : arg0,
            item_id        : arg1,
            rarity         : arg2,
            name           : arg3,
            owner          : arg4,
            mint_timestamp : arg5,
        };
        0x2::event::emit<ItemMinted>(v0);
    }

    public fun get_active_game_ids(arg0: &TemplateRegistry, arg1: u8) : vector<u64> {
        if (arg1 == 3) {
            arg0.active_ssr_pool
        } else if (arg1 == 2) {
            arg0.active_sr_pool
        } else {
            arg0.active_r_pool
        }
    }

    public fun get_all_templates_by_rarity(arg0: &TemplateRegistry, arg1: u8) : vector<CharacterTemplate> {
        let v0 = get_active_game_ids(arg0, arg1);
        let v1 = 0x1::vector::empty<CharacterTemplate>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v0)) {
            let v3 = if (arg1 == 3) {
                *0x2::table::borrow<u64, CharacterTemplate>(&arg0.ssr_templates, *0x1::vector::borrow<u64>(&v0, v2))
            } else if (arg1 == 2) {
                *0x2::table::borrow<u64, CharacterTemplate>(&arg0.sr_templates, *0x1::vector::borrow<u64>(&v0, v2))
            } else {
                *0x2::table::borrow<u64, CharacterTemplate>(&arg0.r_templates, *0x1::vector::borrow<u64>(&v0, v2))
            };
            0x1::vector::push_back<CharacterTemplate>(&mut v1, v3);
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_default_r_templates() : vector<CharacterTemplate> {
        let v0 = CharacterTemplate{
            game_id   : 10401,
            name      : 0x1::string::utf8(b"Elly"),
            image_url : 0x1::string::utf8(b"https://img.albuspaths.com/10401.png"),
        };
        let v1 = 0x1::vector::empty<CharacterTemplate>();
        0x1::vector::push_back<CharacterTemplate>(&mut v1, v0);
        v1
    }

    public fun get_default_sr_templates() : vector<CharacterTemplate> {
        let v0 = CharacterTemplate{
            game_id   : 10007,
            name      : 0x1::string::utf8(b"Connie"),
            image_url : 0x1::string::utf8(b"https://img.albuspaths.com/10007.png"),
        };
        let v1 = CharacterTemplate{
            game_id   : 10405,
            name      : 0x1::string::utf8(b"Chiyomiya Sumire"),
            image_url : 0x1::string::utf8(b"https://img.albuspaths.com/10405.png"),
        };
        let v2 = 0x1::vector::empty<CharacterTemplate>();
        let v3 = &mut v2;
        0x1::vector::push_back<CharacterTemplate>(v3, v0);
        0x1::vector::push_back<CharacterTemplate>(v3, v1);
        v2
    }

    public fun get_default_ssr_templates() : vector<CharacterTemplate> {
        let v0 = CharacterTemplate{
            game_id   : 10301,
            name      : 0x1::string::utf8(b"Viona"),
            image_url : 0x1::string::utf8(b"https://img.albuspaths.com/10301.png"),
        };
        let v1 = CharacterTemplate{
            game_id   : 10304,
            name      : 0x1::string::utf8(b"Utagawa Asuka"),
            image_url : 0x1::string::utf8(b"https://img.albuspaths.com/10304.png"),
        };
        let v2 = 0x1::vector::empty<CharacterTemplate>();
        let v3 = &mut v2;
        0x1::vector::push_back<CharacterTemplate>(v3, v0);
        0x1::vector::push_back<CharacterTemplate>(v3, v1);
        v2
    }

    public fun get_global_stats(arg0: &GlobalGameState) : (u64, vector<u64>) {
        (arg0.next_character_id - 1, arg0.total_characters_by_rarity)
    }

    public(friend) fun get_next_character_id(arg0: &mut GlobalGameState) : u64 {
        let v0 = arg0.next_character_id;
        arg0.next_character_id = v0 + 1;
        v0
    }

    public(friend) fun get_next_crown_id(arg0: &mut GlobalGameState) : u64 {
        let v0 = arg0.next_crown_id;
        arg0.next_crown_id = v0 + 1;
        v0
    }

    public fun get_template_by_id(arg0: &TemplateRegistry, arg1: u64) : CharacterTemplate {
        if (0x2::table::contains<u64, CharacterTemplate>(&arg0.ssr_templates, arg1)) {
            *0x2::table::borrow<u64, CharacterTemplate>(&arg0.ssr_templates, arg1)
        } else if (0x2::table::contains<u64, CharacterTemplate>(&arg0.sr_templates, arg1)) {
            *0x2::table::borrow<u64, CharacterTemplate>(&arg0.sr_templates, arg1)
        } else {
            assert!(0x2::table::contains<u64, CharacterTemplate>(&arg0.r_templates, arg1), 0);
            *0x2::table::borrow<u64, CharacterTemplate>(&arg0.r_templates, arg1)
        }
    }

    public fun get_template_data(arg0: &CharacterTemplate) : (u64, 0x1::string::String, 0x1::string::String) {
        (arg0.game_id, arg0.name, arg0.image_url)
    }

    public fun get_template_info(arg0: &TemplateRegistry, arg1: u64, arg2: u8) : 0x1::option::Option<CharacterTemplate> {
        if (arg2 == 3 && 0x2::table::contains<u64, CharacterTemplate>(&arg0.ssr_templates, arg1)) {
            0x1::option::some<CharacterTemplate>(*0x2::table::borrow<u64, CharacterTemplate>(&arg0.ssr_templates, arg1))
        } else if (arg2 == 2 && 0x2::table::contains<u64, CharacterTemplate>(&arg0.sr_templates, arg1)) {
            0x1::option::some<CharacterTemplate>(*0x2::table::borrow<u64, CharacterTemplate>(&arg0.sr_templates, arg1))
        } else if (arg2 == 1 && 0x2::table::contains<u64, CharacterTemplate>(&arg0.r_templates, arg1)) {
            0x1::option::some<CharacterTemplate>(*0x2::table::borrow<u64, CharacterTemplate>(&arg0.r_templates, arg1))
        } else {
            0x1::option::none<CharacterTemplate>()
        }
    }

    public fun get_template_registry_stats(arg0: &TemplateRegistry) : (u64, u64, u64) {
        (0x1::vector::length<u64>(&arg0.active_ssr_pool), 0x1::vector::length<u64>(&arg0.active_sr_pool), 0x1::vector::length<u64>(&arg0.active_r_pool))
    }

    public fun get_template_version(arg0: &TemplateRegistry, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.template_versions, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.template_versions, arg1)
        } else {
            0
        }
    }

    public fun global_game_state_version(arg0: &GlobalGameState) : u64 {
        arg0.version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MasterAdminCap{id: 0x2::object::new(arg0)};
        let v1 = CharacterAdminCap{id: 0x2::object::new(arg0)};
        let v2 = GlobalGameState{
            id                         : 0x2::object::new(arg0),
            version                    : 1,
            next_character_id          : 1,
            next_crown_id              : 1,
            total_characters_by_rarity : vector[0, 0, 0],
        };
        let v3 = create_template_registry(arg0);
        0x2::transfer::transfer<MasterAdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<CharacterAdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalGameState>(v2);
        0x2::transfer::share_object<TemplateRegistry>(v3);
    }

    fun initialize_registry_with_defaults(arg0: &mut TemplateRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = get_default_ssr_templates();
        let v1 = get_default_sr_templates();
        let v2 = get_default_r_templates();
        let v3 = 0;
        while (v3 < 0x1::vector::length<CharacterTemplate>(&v0)) {
            add_template_to_registry(arg0, *0x1::vector::borrow<CharacterTemplate>(&v0, v3), 3, arg1);
            v3 = v3 + 1;
        };
        v3 = 0;
        while (v3 < 0x1::vector::length<CharacterTemplate>(&v1)) {
            add_template_to_registry(arg0, *0x1::vector::borrow<CharacterTemplate>(&v1, v3), 2, arg1);
            v3 = v3 + 1;
        };
        v3 = 0;
        while (v3 < 0x1::vector::length<CharacterTemplate>(&v2)) {
            add_template_to_registry(arg0, *0x1::vector::borrow<CharacterTemplate>(&v2, v3), 1, arg1);
            v3 = v3 + 1;
        };
    }

    public fun is_template_active(arg0: &TemplateRegistry, arg1: u64, arg2: u8) : bool {
        let v0 = get_active_game_ids(arg0, arg2);
        let (v1, _) = 0x1::vector::index_of<u64>(&v0, &arg1);
        v1
    }

    public fun migrate_global_game_state(arg0: &CharacterAdminCap, arg1: &mut GlobalGameState) {
        assert!(arg1.version < 1, 6);
        arg1.version = 1;
    }

    public fun migrate_template_registry(arg0: &CharacterAdminCap, arg1: &mut TemplateRegistry) {
        assert!(arg1.version < 1, 6);
        arg1.version = 1;
    }

    public fun rarity_r() : u8 {
        1
    }

    public fun rarity_sr() : u8 {
        2
    }

    public fun rarity_ssr() : u8 {
        3
    }

    public fun reactivate_template(arg0: &CharacterAdminCap, arg1: &mut TemplateRegistry, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(template_exists(arg1, arg2, arg3), 0);
        let v0 = if (arg3 == 3) {
            &mut arg1.active_ssr_pool
        } else if (arg3 == 2) {
            &mut arg1.active_sr_pool
        } else {
            &mut arg1.active_r_pool
        };
        let (v1, _) = 0x1::vector::index_of<u64>(v0, &arg2);
        if (!v1) {
            0x1::vector::push_back<u64>(v0, arg2);
        };
    }

    public fun remove_template(arg0: &CharacterAdminCap, arg1: &mut TemplateRegistry, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        deactivate_template(arg0, arg1, arg2, arg3, arg4);
        if (arg3 == 3) {
            0x2::table::remove<u64, CharacterTemplate>(&mut arg1.ssr_templates, arg2);
        } else if (arg3 == 2) {
            0x2::table::remove<u64, CharacterTemplate>(&mut arg1.sr_templates, arg2);
        } else {
            0x2::table::remove<u64, CharacterTemplate>(&mut arg1.r_templates, arg2);
        };
        0x2::table::remove<u64, u64>(&mut arg1.template_versions, arg2);
    }

    public(friend) fun select_character_template_from_registry(arg0: &TemplateRegistry, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) : CharacterTemplate {
        let v0 = if (arg1 == 3) {
            &arg0.active_ssr_pool
        } else if (arg1 == 2) {
            &arg0.active_sr_pool
        } else {
            &arg0.active_r_pool
        };
        assert!(!0x1::vector::is_empty<u64>(v0), 1);
        let v1 = 0x2::random::new_generator(arg2, arg3);
        if (arg1 == 3) {
            *0x2::table::borrow<u64, CharacterTemplate>(&arg0.ssr_templates, *0x1::vector::borrow<u64>(v0, 0x2::random::generate_u64_in_range(&mut v1, 0, 0x1::vector::length<u64>(v0) - 1)))
        } else if (arg1 == 2) {
            *0x2::table::borrow<u64, CharacterTemplate>(&arg0.sr_templates, *0x1::vector::borrow<u64>(v0, 0x2::random::generate_u64_in_range(&mut v1, 0, 0x1::vector::length<u64>(v0) - 1)))
        } else {
            *0x2::table::borrow<u64, CharacterTemplate>(&arg0.r_templates, *0x1::vector::borrow<u64>(v0, 0x2::random::generate_u64_in_range(&mut v1, 0, 0x1::vector::length<u64>(v0) - 1)))
        }
    }

    public fun template_exists(arg0: &TemplateRegistry, arg1: u64, arg2: u8) : bool {
        arg2 == 3 && 0x2::table::contains<u64, CharacterTemplate>(&arg0.ssr_templates, arg1) || arg2 == 2 && 0x2::table::contains<u64, CharacterTemplate>(&arg0.sr_templates, arg1) || 0x2::table::contains<u64, CharacterTemplate>(&arg0.r_templates, arg1)
    }

    public fun template_registry_version(arg0: &TemplateRegistry) : u64 {
        arg0.version
    }

    public fun transfer_master_admin(arg0: MasterAdminCap, arg1: address) {
        0x2::transfer::transfer<MasterAdminCap>(arg0, arg1);
    }

    public(friend) fun update_character_stats(arg0: &mut GlobalGameState, arg1: u8) {
        assert!(arg1 >= 1 && arg1 <= 3, 2);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.total_characters_by_rarity, (arg1 as u64) - 1);
        *v0 = *v0 + 1;
    }

    public fun update_template(arg0: &CharacterAdminCap, arg1: &mut TemplateRegistry, arg2: u64, arg3: u8, arg4: CharacterTemplate, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(template_exists(arg1, arg2, arg3), 0);
        if (arg3 == 3) {
            *0x2::table::borrow_mut<u64, CharacterTemplate>(&mut arg1.ssr_templates, arg2) = arg4;
        } else if (arg3 == 2) {
            *0x2::table::borrow_mut<u64, CharacterTemplate>(&mut arg1.sr_templates, arg2) = arg4;
        } else {
            *0x2::table::borrow_mut<u64, CharacterTemplate>(&mut arg1.r_templates, arg2) = arg4;
        };
        let v0 = 0x2::table::borrow_mut<u64, u64>(&mut arg1.template_versions, arg2);
        *v0 = *v0 + 1;
    }

    public(friend) fun validate_url_bytes(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) >= 9, 4);
        let v0 = b"https://";
        let v1 = 0;
        while (v1 < 8) {
            assert!(*0x1::vector::borrow<u8>(arg0, v1) == *0x1::vector::borrow<u8>(&v0, v1), 4);
            v1 = v1 + 1;
        };
    }

    public(friend) fun verify_ed25519_signature(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg1) != 64) {
            return false
        };
        if (0x1::vector::length<u8>(arg2) != 32) {
            return false
        };
        0x2::ed25519::ed25519_verify(arg1, arg2, arg0)
    }

    // decompiled from Move bytecode v6
}

