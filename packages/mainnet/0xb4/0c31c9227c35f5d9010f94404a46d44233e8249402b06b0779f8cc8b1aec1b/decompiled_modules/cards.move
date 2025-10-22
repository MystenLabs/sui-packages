module 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::cards {
    struct CardEntry has copy, drop, store {
        kind: u8,
        count: u8,
    }

    struct Card has copy, drop, store {
        kind: u8,
        name: vector<u8>,
        description: vector<u8>,
        target_type: u8,
        value: u64,
        rarity: u8,
    }

    struct CardRegistry has store, key {
        id: 0x2::object::UID,
        cards: vector<Card>,
    }

    struct DropConfig has store, key {
        id: 0x2::object::UID,
        tile_drops: 0x2::table::Table<u8, DropRule>,
        pass_drop_rate: u64,
        stop_drop_rate: u64,
        default_pool: vector<u8>,
        default_weights: vector<u64>,
    }

    struct DropRule has drop, store {
        card_pool: vector<u8>,
        weights: vector<u64>,
        quantity: u64,
    }

    public(friend) fun create_and_share_card_registry(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<CardRegistry>(create_card_registry_internal(arg0));
    }

    public(friend) fun create_and_share_drop_config(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<DropConfig>(create_drop_config_internal(arg0));
    }

    public(friend) fun create_card_registry_internal(arg0: &mut 0x2::tx_context::TxContext) : CardRegistry {
        let v0 = CardRegistry{
            id    : 0x2::object::new(arg0),
            cards : 0x1::vector::empty<Card>(),
        };
        let v1 = &mut v0;
        init_basic_cards(v1);
        v0
    }

    public(friend) fun create_drop_config_internal(arg0: &mut 0x2::tx_context::TxContext) : DropConfig {
        let v0 = DropConfig{
            id              : 0x2::object::new(arg0),
            tile_drops      : 0x2::table::new<u8, DropRule>(arg0),
            pass_drop_rate  : 1000,
            stop_drop_rate  : 5000,
            default_pool    : b"",
            default_weights : vector[],
        };
        let v1 = &mut v0;
        init_default_drop_rules(v1);
        v0
    }

    fun determine_card_draw(arg0: u8) : u8 {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_MOVE_CTRL());
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_BARRIER());
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_BOMB());
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_RENT_FREE());
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_FREEZE());
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_DOG());
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_CLEANSE());
        *0x1::vector::borrow<u8>(&v0, (arg0 as u64) % 0x1::vector::length<u8>(&v0))
    }

    public(friend) fun draw_card_on_pass(arg0: u8) : (u8, u8) {
        (determine_card_draw(arg0), 1)
    }

    public(friend) fun draw_card_on_stop(arg0: u8) : (u8, u8) {
        (determine_card_draw(arg0), 2)
    }

    public(friend) fun get_player_card_count(arg0: &vector<CardEntry>, arg1: u8) : u8 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<CardEntry>(arg0)) {
            let v1 = 0x1::vector::borrow<CardEntry>(arg0, v0);
            if (v1.kind == arg1) {
                return v1.count
            };
            v0 = v0 + 1;
        };
        0
    }

    public(friend) fun give_card_to_player(arg0: &mut vector<CardEntry>, arg1: u8, arg2: u8) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<CardEntry>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<CardEntry>(arg0, v0);
            if (v1.kind == arg1) {
                let v2 = (v1.count as u64) + (arg2 as u64);
                let v3 = if (v2 > 255) {
                    255
                } else {
                    (v2 as u8)
                };
                v1.count = v3;
                return
            };
            v0 = v0 + 1;
        };
        let v4 = CardEntry{
            kind  : arg1,
            count : arg2,
        };
        0x1::vector::push_back<CardEntry>(arg0, v4);
    }

    fun init_basic_cards(arg0: &mut CardRegistry) {
        register_card_internal(arg0, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_MOVE_CTRL(), b"Move Control", b"Control your next dice roll", target_none(), 3, 0);
        register_card_internal(arg0, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_BARRIER(), b"Barrier", b"Place a barrier on a tile", target_tile(), 0, 0);
        register_card_internal(arg0, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_BOMB(), b"Bomb", b"Place a bomb on a tile", target_tile(), 0, 1);
        register_card_internal(arg0, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_RENT_FREE(), b"Rent Free", b"Avoid paying rent this turn", target_none(), 1, 1);
        register_card_internal(arg0, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_FREEZE(), b"Freeze", b"Freeze a player for one turn", target_player(), 1, 2);
        register_card_internal(arg0, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_DOG(), b"Dog", b"Place a dog NPC on a tile", target_tile(), 0, 1);
        register_card_internal(arg0, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_CLEANSE(), b"Cleanse", b"Remove an NPC from a tile", target_tile(), 0, 0);
        register_card_internal(arg0, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_TURN(), b"Turn Card", b"Reverse your movement direction", target_none(), 0, 0);
    }

    fun init_default_drop_rules(arg0: &mut DropConfig) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_MOVE_CTRL());
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_BARRIER());
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_BOMB());
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_RENT_FREE());
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_FREEZE());
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_DOG());
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_CLEANSE());
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::CARD_TURN());
        arg0.default_pool = v0;
        arg0.default_weights = vector[40, 40, 30, 30, 10, 30, 40, 40];
        let v2 = DropRule{
            card_pool : arg0.default_pool,
            weights   : arg0.default_weights,
            quantity  : 2,
        };
        0x2::table::add<u8, DropRule>(&mut arg0.tile_drops, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::TILE_CARD(), v2);
        let v3 = DropRule{
            card_pool : arg0.default_pool,
            weights   : vector[20, 20, 40, 40, 30, 40, 20, 20],
            quantity  : 3,
        };
        0x2::table::add<u8, DropRule>(&mut arg0.tile_drops, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::TILE_BONUS(), v3);
    }

    public(friend) fun new_card_entry(arg0: u8, arg1: u8) : CardEntry {
        CardEntry{
            kind  : arg0,
            count : arg1,
        }
    }

    public(friend) fun player_has_card(arg0: &vector<CardEntry>, arg1: u8) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<CardEntry>(arg0)) {
            let v1 = 0x1::vector::borrow<CardEntry>(arg0, v0);
            if (v1.kind == arg1 && v1.count > 0) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun register_card_for_admin(arg0: &mut CardRegistry, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u8) {
        register_card_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun register_card_internal(arg0: &mut CardRegistry, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u8) {
        let v0 = Card{
            kind        : arg1,
            name        : arg2,
            description : arg3,
            target_type : arg4,
            value       : arg5,
            rarity      : arg6,
        };
        assert!((arg1 as u64) == 0x1::vector::length<Card>(&arg0.cards), 0);
        0x1::vector::push_back<Card>(&mut arg0.cards, v0);
    }

    fun target_none() : u8 {
        0
    }

    fun target_player() : u8 {
        1
    }

    fun target_tile() : u8 {
        2
    }

    public(friend) fun use_player_card(arg0: &mut vector<CardEntry>, arg1: u8) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<CardEntry>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<CardEntry>(arg0, v0);
            if (v1.kind == arg1 && v1.count > 0) {
                v1.count = v1.count - 1;
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

