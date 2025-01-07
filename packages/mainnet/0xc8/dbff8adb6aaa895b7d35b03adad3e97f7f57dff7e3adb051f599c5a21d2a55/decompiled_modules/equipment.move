module 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::equipment {
    struct EQUIPMENT has drop {
        dummy_field: bool,
    }

    struct Equipment has store, key {
        id: 0x2::object::UID,
        game_id: 0x1::string::String,
        name: 0x1::string::String,
        type: 0x1::string::String,
        clan: 0x1::string::String,
        rarity: 0x1::string::String,
        rank: u64,
        level: u64,
    }

    struct EquipmentKey has copy, drop, store {
        type: 0x1::string::String,
    }

    struct MintCapEquipment has store, key {
        id: 0x2::object::UID,
        minting_limit: u64,
        minting_counter: u64,
    }

    struct EquipmentMinted has copy, drop {
        id: 0x2::object::ID,
        mint_cap_id: 0x2::object::ID,
        clan: 0x1::string::String,
        created_by: address,
    }

    struct MintCapEquipmentCreated has copy, drop {
        id: 0x2::object::ID,
        authorizer: address,
        minting_limit: u64,
    }

    public fun authorize_address(arg0: &0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCapEquipment{
            id              : 0x2::object::new(arg3),
            minting_limit   : arg1,
            minting_counter : 0,
        };
        let v1 = MintCapEquipmentCreated{
            id            : 0x2::object::id<MintCapEquipment>(&v0),
            authorizer    : 0x2::tx_context::sender(arg3),
            minting_limit : arg1,
        };
        0x2::event::emit<MintCapEquipmentCreated>(v1);
        0x2::transfer::transfer<MintCapEquipment>(v0, arg2);
    }

    public fun create_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"game_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{game_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{type}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Equipment for your Panzerdog"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.panzerdogs.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Lucky Kat Studios"));
        let v4 = 0x2::display::new_with_fields<Equipment>(arg0, v0, v2, arg1);
        let v5 = 0x1::string::utf8(b"ipfs://Qme6MVWVshHtQWY3tJS9QmKJwkeZHJxTAjDzTLntUiwipe/");
        0x1::string::append(&mut v5, 0x1::string::utf8(b"{type}"));
        0x1::string::append(&mut v5, 0x1::string::utf8(b"/{game_id}.gif"));
        0x2::display::add<Equipment>(&mut v4, 0x1::string::utf8(b"image_url"), v5);
        0x2::display::update_version<Equipment>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<Equipment>>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun equip(arg0: &mut 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::Panzerdog, arg1: Equipment) {
        assert!(!0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::is_locked(0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::uid(arg0)), 4);
        let v0 = 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::uid_mut(arg0);
        let v1 = EquipmentKey{type: arg1.type};
        assert!(!0x2::dynamic_object_field::exists_<EquipmentKey>(v0, v1), 0);
        let v2 = EquipmentKey{type: arg1.type};
        0x2::dynamic_object_field::add<EquipmentKey, Equipment>(v0, v2, arg1);
    }

    fun init(arg0: EQUIPMENT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<EQUIPMENT>(arg0, arg1);
    }

    public fun mint(arg0: &mut MintCapEquipment, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minting_counter < arg0.minting_limit, 2);
        let v0 = Equipment{
            id      : 0x2::object::new(arg8),
            game_id : arg1,
            name    : arg2,
            type    : arg3,
            clan    : arg4,
            rarity  : arg5,
            rank    : arg6,
            level   : 0,
        };
        arg0.minting_counter = arg0.minting_counter + 1;
        let v1 = EquipmentMinted{
            id          : 0x2::object::id<Equipment>(&v0),
            mint_cap_id : 0x2::object::id<MintCapEquipment>(arg0),
            clan        : arg4,
            created_by  : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<EquipmentMinted>(v1);
        0x2::transfer::public_transfer<Equipment>(v0, arg7);
    }

    public fun mint_ptb(arg0: &mut MintCapEquipment, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : Equipment {
        assert!(arg0.minting_counter < arg0.minting_limit, 2);
        let v0 = Equipment{
            id      : 0x2::object::new(arg7),
            game_id : arg1,
            name    : arg2,
            type    : arg3,
            clan    : arg4,
            rarity  : arg5,
            rank    : arg6,
            level   : 0,
        };
        arg0.minting_counter = arg0.minting_counter + 1;
        let v1 = EquipmentMinted{
            id          : 0x2::object::id<Equipment>(&v0),
            mint_cap_id : 0x2::object::id<MintCapEquipment>(arg0),
            clan        : arg4,
            created_by  : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<EquipmentMinted>(v1);
        v0
    }

    public(friend) fun uid_mut(arg0: &mut Equipment) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun unequip(arg0: &mut 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::Panzerdog, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::is_locked(0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::uid(arg0)), 4);
        let v0 = 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::uid_mut(arg0);
        let v1 = EquipmentKey{type: arg1};
        assert!(0x2::dynamic_object_field::exists_<EquipmentKey>(v0, v1), 1);
        let v2 = EquipmentKey{type: arg1};
        0x2::transfer::public_transfer<Equipment>(0x2::dynamic_object_field::remove<EquipmentKey, Equipment>(v0, v2), 0x2::tx_context::sender(arg2));
    }

    public entry fun update_display_image(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::display::Display<Equipment>) {
        assert!(0x2::display::is_authorized<Equipment>(arg0), 3);
        0x2::display::edit<Equipment>(arg2, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::update_version<Equipment>(arg2);
    }

    // decompiled from Move bytecode v6
}

