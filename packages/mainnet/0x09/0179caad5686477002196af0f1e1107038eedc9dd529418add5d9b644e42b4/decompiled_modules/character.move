module 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character {
    struct Character has key {
        id: 0x2::object::UID,
        key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        tribe_id: u32,
        character_address: address,
        metadata: 0x1::option::Option<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>,
        owner_cap_id: 0x2::object::ID,
    }

    struct PlayerProfile has key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
    }

    struct CharacterCreatedEvent has copy, drop {
        character_id: 0x2::object::ID,
        key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        tribe_id: u32,
        character_address: address,
    }

    public fun id(arg0: &Character) : 0x2::object::ID {
        0x2::object::id<Character>(arg0)
    }

    public fun borrow_owner_cap<T0: key>(arg0: &mut Character, arg1: 0x2::transfer::Receiving<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<T0>>, arg2: &0x2::tx_context::TxContext) : (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<T0>, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::ReturnOwnerCapReceipt) {
        assert!(arg0.character_address == 0x2::tx_context::sender(arg2), 13836466271979962379);
        let v0 = 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::receive_owner_cap<T0>(&mut arg0.id, arg1);
        (v0, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::create_return_receipt(0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<T0>>(&v0), 0x2::object::id_address<Character>(arg0)))
    }

    public fun character_address(arg0: &Character) : address {
        arg0.character_address
    }

    public fun create_character(arg0: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::object_registry::ObjectRegistry, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: u32, arg3: 0x1::string::String, arg4: u32, arg5: address, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : Character {
        assert!(arg2 != 0, 13835058643692683265);
        assert!(arg4 != 0, 13835340122964492291);
        assert!(arg5 != @0x0, 13836184552189984777);
        assert!(0x1::string::length(&arg3) > 0, 13835903081508110343);
        let v0 = 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::create_key((arg2 as u64), arg3);
        assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::object_registry::object_exists(arg0, v0), 13835621632301072389);
        let v1 = 0x2::derived_object::claim<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId>(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::object_registry::borrow_registry_id(arg0), v0);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::create_owner_cap_by_id<Character>(v2, arg1, arg7);
        let v4 = Character{
            id                : v1,
            key               : v0,
            tribe_id          : arg4,
            character_address : arg5,
            metadata          : 0x1::option::some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::create_metadata(v2, v0, arg6, 0x1::string::utf8(b""), 0x1::string::utf8(b""))),
            owner_cap_id      : 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Character>>(&v3),
        };
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::transfer_owner_cap<Character>(v3, 0x2::object::id_address<Character>(&v4));
        let v5 = PlayerProfile{
            id           : 0x2::object::new(arg7),
            character_id : 0x2::object::id<Character>(&v4),
        };
        0x2::transfer::transfer<PlayerProfile>(v5, arg5);
        let v6 = CharacterCreatedEvent{
            character_id      : 0x2::object::id<Character>(&v4),
            key               : v0,
            tribe_id          : arg4,
            character_address : arg5,
        };
        0x2::event::emit<CharacterCreatedEvent>(v6);
        v4
    }

    public fun delete_character(arg0: Character, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg2);
        let Character {
            id                : v0,
            key               : _,
            tribe_id          : _,
            character_address : _,
            metadata          : v4,
            owner_cap_id      : _,
        } = arg0;
        let v6 = v4;
        if (0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&v6)) {
            0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::delete(0x1::option::destroy_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(v6));
        } else {
            0x1::option::destroy_none<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(v6);
        };
        0x2::object::delete(v0);
    }

    public fun key(arg0: &Character) : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId {
        arg0.key
    }

    public fun owner_cap_id(arg0: &Character) : 0x2::object::ID {
        arg0.owner_cap_id
    }

    public fun player_profile_id(arg0: &PlayerProfile) : 0x2::object::ID {
        0x2::object::id<PlayerProfile>(arg0)
    }

    public fun return_owner_cap<T0: key>(arg0: &Character, arg1: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<T0>, arg2: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::ReturnOwnerCapReceipt) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::return_owner_cap_to_object<T0>(arg1, arg2, 0x2::object::id_address<Character>(arg0));
    }

    public fun share_character(arg0: Character, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg2);
        0x2::transfer::share_object<Character>(arg0);
    }

    public fun tenant(arg0: &Character) : 0x1::string::String {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::tenant(&arg0.key)
    }

    public fun tribe(arg0: &Character) : u32 {
        arg0.tribe_id
    }

    public fun update_address(arg0: &mut Character, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg3);
        assert!(arg2 != @0x0, 13836184990276648969);
        arg0.character_address = arg2;
    }

    public fun update_metadata_description(arg0: &mut Character, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Character>, arg2: 0x1::string::String) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Character>(arg1, 0x2::object::id<Character>(arg0)), 13837028848271491087);
        assert!(0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&arg0.metadata), 13836747377589616653);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::update_description(0x1::option::borrow_mut<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&mut arg0.metadata), arg0.key, arg2);
    }

    public fun update_metadata_name(arg0: &mut Character, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Character>, arg2: 0x1::string::String) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Character>(arg1, 0x2::object::id<Character>(arg0)), 13837028801026850831);
        assert!(0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&arg0.metadata), 13836747330344976397);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::update_name(0x1::option::borrow_mut<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&mut arg0.metadata), arg0.key, arg2);
    }

    public fun update_metadata_url(arg0: &mut Character, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Character>, arg2: 0x1::string::String) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Character>(arg1, 0x2::object::id<Character>(arg0)), 13837028895516131343);
        assert!(0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&arg0.metadata), 13836747424834256909);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::update_url(0x1::option::borrow_mut<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&mut arg0.metadata), arg0.key, arg2);
    }

    public fun update_tenant_id(arg0: &mut Character, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg3);
        assert!(0x1::string::length(&arg2) > 0, 13835903566839414791);
        arg0.key = 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::create_key(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::item_id(&arg0.key), arg2);
    }

    public fun update_tribe(arg0: &mut Character, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg3);
        assert!(arg2 != 0, 13835340505216581635);
        arg0.tribe_id = arg2;
    }

    // decompiled from Move bytecode v6
}

