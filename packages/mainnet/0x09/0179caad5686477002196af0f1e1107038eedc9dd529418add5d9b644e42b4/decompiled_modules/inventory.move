module 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory {
    struct Inventory has store {
        max_capacity: u64,
        used_capacity: u64,
        items: 0x2::vec_map::VecMap<u64, ItemEntry>,
    }

    struct ItemEntry has copy, drop, store {
        tenant: 0x1::string::String,
        type_id: u64,
        item_id: u64,
        volume: u64,
        quantity: u32,
    }

    struct Item has store, key {
        id: 0x2::object::UID,
        parent_id: 0x2::object::ID,
        tenant: 0x1::string::String,
        type_id: u64,
        item_id: u64,
        volume: u64,
        quantity: u32,
        location: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::Location,
    }

    struct ItemMintedEvent has copy, drop {
        assembly_id: 0x2::object::ID,
        assembly_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        character_id: 0x2::object::ID,
        character_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        item_id: u64,
        type_id: u64,
        quantity: u32,
    }

    struct ItemBurnedEvent has copy, drop {
        assembly_id: 0x2::object::ID,
        assembly_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        character_id: 0x2::object::ID,
        character_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        item_id: u64,
        type_id: u64,
        quantity: u32,
    }

    struct ItemDepositedEvent has copy, drop {
        assembly_id: 0x2::object::ID,
        assembly_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        character_id: 0x2::object::ID,
        character_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        item_id: u64,
        type_id: u64,
        quantity: u32,
    }

    struct ItemWithdrawnEvent has copy, drop {
        assembly_id: 0x2::object::ID,
        assembly_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        character_id: 0x2::object::ID,
        character_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        item_id: u64,
        type_id: u64,
        quantity: u32,
    }

    struct ItemDestroyedEvent has copy, drop {
        assembly_id: 0x2::object::ID,
        assembly_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        item_id: u64,
        type_id: u64,
        quantity: u32,
    }

    public(friend) fun delete(arg0: Inventory, arg1: 0x2::object::ID, arg2: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId) {
        let Inventory {
            max_capacity  : _,
            used_capacity : _,
            items         : v2,
        } = arg0;
        let v3 = v2;
        while (!0x2::vec_map::is_empty<u64, ItemEntry>(&v3)) {
            let (_, v5) = 0x2::vec_map::pop<u64, ItemEntry>(&mut v3);
            let v6 = v5;
            let v7 = ItemDestroyedEvent{
                assembly_id  : arg1,
                assembly_key : arg2,
                item_id      : v6.item_id,
                type_id      : v6.type_id,
                quantity     : v6.quantity,
            };
            0x2::event::emit<ItemDestroyedEvent>(v7);
        };
        0x2::vec_map::destroy_empty<u64, ItemEntry>(v3);
    }

    public fun id(arg0: &Item) : 0x2::object::ID {
        0x2::object::id<Item>(arg0)
    }

    fun burn_items(arg0: &mut Inventory, arg1: 0x2::object::ID, arg2: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg4: u64, arg5: u32) {
        assert!(0x2::vec_map::contains<u64, ItemEntry>(&arg0.items, &arg4), 13835904352818429959);
        let v0 = 0x2::vec_map::get<u64, ItemEntry>(&arg0.items, &arg4);
        assert!(v0.quantity >= arg5, 13836185840680173577);
        arg0.used_capacity = arg0.used_capacity - calculate_volume(v0.volume, arg5);
        if (v0.quantity == arg5) {
            let (_, _) = 0x2::vec_map::remove<u64, ItemEntry>(&mut arg0.items, &arg4);
        } else {
            let v3 = 0x2::vec_map::get_mut<u64, ItemEntry>(&mut arg0.items, &arg4);
            v3.quantity = v3.quantity - arg5;
        };
        let v4 = ItemBurnedEvent{
            assembly_id   : arg1,
            assembly_key  : arg2,
            character_id  : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::id(arg3),
            character_key : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::key(arg3),
            item_id       : v0.item_id,
            type_id       : arg4,
            quantity      : arg5,
        };
        0x2::event::emit<ItemBurnedEvent>(v4);
    }

    public(friend) fun burn_items_with_proof(arg0: &mut Inventory, arg1: 0x2::object::ID, arg2: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg4: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::ServerAddressRegistry, arg5: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::Location, arg6: vector<u8>, arg7: u64, arg8: u32, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::verify_proximity_proof_from_bytes(arg4, arg5, arg6, arg9, arg10);
        burn_items(arg0, arg1, arg2, arg3, arg7, arg8);
    }

    fun calculate_volume(arg0: u64, arg1: u32) : u64 {
        arg0 * (arg1 as u64)
    }

    public fun contains_item(arg0: &Inventory, arg1: u64) : bool {
        0x2::vec_map::contains<u64, ItemEntry>(&arg0.items, &arg1)
    }

    public(friend) fun create(arg0: u64) : Inventory {
        assert!(arg0 != 0, 13835340402137366531);
        Inventory{
            max_capacity  : arg0,
            used_capacity : 0,
            items         : 0x2::vec_map::empty<u64, ItemEntry>(),
        }
    }

    public(friend) fun deposit_item(arg0: &mut Inventory, arg1: 0x2::object::ID, arg2: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg4: Item) {
        let Item {
            id        : v0,
            parent_id : _,
            tenant    : v2,
            type_id   : v3,
            item_id   : v4,
            volume    : v5,
            quantity  : v6,
            location  : v7,
        } = arg4;
        let v8 = v3;
        0x2::object::delete(v0);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::remove(v7);
        let v9 = if (0x2::vec_map::contains<u64, ItemEntry>(&arg0.items, &v8)) {
            0x2::vec_map::get<u64, ItemEntry>(&arg0.items, &v8).volume
        } else {
            v5
        };
        let v10 = calculate_volume(v9, v6);
        assert!(v10 <= arg0.max_capacity - arg0.used_capacity, 13835622349560610821);
        arg0.used_capacity = arg0.used_capacity + v10;
        let v11 = ItemEntry{
            tenant   : v2,
            type_id  : v8,
            item_id  : v4,
            volume   : v5,
            quantity : v6,
        };
        let v12 = if (0x2::vec_map::contains<u64, ItemEntry>(&arg0.items, &v8)) {
            let v13 = 0x2::vec_map::get_mut<u64, ItemEntry>(&mut arg0.items, &v8);
            let v14 = v13.item_id;
            join(v13, v11);
            v14
        } else {
            0x2::vec_map::insert<u64, ItemEntry>(&mut arg0.items, v8, v11);
            v4
        };
        let v15 = ItemDepositedEvent{
            assembly_id   : arg1,
            assembly_key  : arg2,
            character_id  : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::id(arg3),
            character_key : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::key(arg3),
            item_id       : v12,
            type_id       : v8,
            quantity      : v6,
        };
        0x2::event::emit<ItemDepositedEvent>(v15);
    }

    public fun get_item_location_hash(arg0: &Item) : vector<u8> {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::hash(&arg0.location)
    }

    public(friend) fun join(arg0: &mut ItemEntry, arg1: ItemEntry) {
        assert!(arg0.type_id == arg1.type_id, 13836747755546607627);
        arg0.quantity = arg0.quantity + arg1.quantity;
    }

    public fun max_capacity(arg0: &Inventory) : u64 {
        arg0.max_capacity
    }

    public(friend) fun mint_items(arg0: &mut Inventory, arg1: 0x2::object::ID, arg2: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u32) {
        assert!(arg6 != 0, 13835059034534707201);
        let v0 = if (0x2::vec_map::contains<u64, ItemEntry>(&arg0.items, &arg6)) {
            0x2::vec_map::get<u64, ItemEntry>(&arg0.items, &arg6).volume
        } else {
            arg7
        };
        let v1 = calculate_volume(v0, arg8);
        assert!(v1 <= arg0.max_capacity - arg0.used_capacity, 13835622031733030917);
        arg0.used_capacity = arg0.used_capacity + v1;
        let v2 = if (0x2::vec_map::contains<u64, ItemEntry>(&arg0.items, &arg6)) {
            let v3 = 0x2::vec_map::get_mut<u64, ItemEntry>(&mut arg0.items, &arg6);
            v3.quantity = v3.quantity + arg8;
            v3.item_id
        } else {
            let v4 = ItemEntry{
                tenant   : arg4,
                type_id  : arg6,
                item_id  : arg5,
                volume   : arg7,
                quantity : arg8,
            };
            0x2::vec_map::insert<u64, ItemEntry>(&mut arg0.items, arg6, v4);
            arg5
        };
        let v5 = ItemMintedEvent{
            assembly_id   : arg1,
            assembly_key  : arg2,
            character_id  : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::id(arg3),
            character_key : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::key(arg3),
            item_id       : v2,
            type_id       : arg6,
            quantity      : arg8,
        };
        0x2::event::emit<ItemMintedEvent>(v5);
    }

    public fun parent_id(arg0: &Item) : 0x2::object::ID {
        arg0.parent_id
    }

    public fun quantity(arg0: &Item) : u32 {
        arg0.quantity
    }

    public fun tenant(arg0: &Item) : 0x1::string::String {
        arg0.tenant
    }

    public fun type_id(arg0: &Item) : u64 {
        arg0.type_id
    }

    public(friend) fun withdraw_item(arg0: &mut Inventory, arg1: 0x2::object::ID, arg2: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg4: u64, arg5: u32, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : Item {
        assert!(0x2::vec_map::contains<u64, ItemEntry>(&arg0.items, &arg4), 13835904004926078983);
        assert!(arg5 > 0, 13837029909128282125);
        let v0 = 0x2::vec_map::get<u64, ItemEntry>(&arg0.items, &arg4);
        assert!(v0.quantity >= arg5, 13836185497082789897);
        let v1 = v0.volume;
        let v2 = v0.item_id;
        arg0.used_capacity = arg0.used_capacity - calculate_volume(v1, arg5);
        if (v0.quantity == arg5) {
            let (_, _) = 0x2::vec_map::remove<u64, ItemEntry>(&mut arg0.items, &arg4);
        } else {
            let v5 = 0x2::vec_map::get_mut<u64, ItemEntry>(&mut arg0.items, &arg4);
            v5.quantity = v5.quantity - arg5;
        };
        let v6 = ItemWithdrawnEvent{
            assembly_id   : arg1,
            assembly_key  : arg2,
            character_id  : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::id(arg3),
            character_key : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::key(arg3),
            item_id       : v2,
            type_id       : arg4,
            quantity      : arg5,
        };
        0x2::event::emit<ItemWithdrawnEvent>(v6);
        Item{
            id        : 0x2::object::new(arg7),
            parent_id : arg1,
            tenant    : v0.tenant,
            type_id   : arg4,
            item_id   : v2,
            volume    : v1,
            quantity  : arg5,
            location  : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::attach(arg6),
        }
    }

    // decompiled from Move bytecode v6
}

