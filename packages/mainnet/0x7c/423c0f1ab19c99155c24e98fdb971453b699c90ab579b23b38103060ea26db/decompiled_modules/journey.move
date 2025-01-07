module 0x7c423c0f1ab19c99155c24e98fdb971453b699c90ab579b23b38103060ea26db::journey {
    struct Quest has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        data: 0x1::string::String,
        epoch_time: u64,
    }

    struct EventSaveQuest has copy, drop {
        profile_id: 0x2::object::ID,
        quest_name: 0x1::string::String,
        data: 0x1::string::String,
    }

    struct JOURNEY has drop {
        dummy_field: bool,
    }

    public entry fun delete_quest(arg0: &mut 0x57138e18b82cc8ea6e92c3d5737d6078b1304b655f59cf5ae9668cc44aad4ead::profile::Profile, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let Quest {
            id          : v0,
            name        : _,
            image_url   : _,
            description : _,
            data        : _,
            epoch_time  : _,
        } = 0x57138e18b82cc8ea6e92c3d5737d6078b1304b655f59cf5ae9668cc44aad4ead::profile::remove_dynamic_object_field<0x1::string::String, Quest>(arg0, 0x1::string::utf8(arg1));
        0x2::object::delete(v0);
    }

    fun init(arg0: JOURNEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<JOURNEY>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://mountsogol.com"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://mountsogol.com"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://polymedia.app"));
        let v5 = 0x2::display::new_with_fields<Quest>(&v0, v1, v3, arg1);
        0x2::display::update_version<Quest>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Quest>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun save_quest(arg0: &mut 0x57138e18b82cc8ea6e92c3d5737d6078b1304b655f59cf5ae9668cc44aad4ead::profile::Profile, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        let v1 = Quest{
            id          : 0x2::object::new(arg5),
            name        : v0,
            image_url   : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(arg3),
            data        : 0x1::string::utf8(arg4),
            epoch_time  : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x57138e18b82cc8ea6e92c3d5737d6078b1304b655f59cf5ae9668cc44aad4ead::profile::add_dynamic_object_field<0x1::string::String, Quest>(arg0, v0, v1);
        let v2 = EventSaveQuest{
            profile_id : 0x2::object::id<0x57138e18b82cc8ea6e92c3d5737d6078b1304b655f59cf5ae9668cc44aad4ead::profile::Profile>(arg0),
            quest_name : v0,
            data       : 0x1::string::utf8(arg4),
        };
        0x2::event::emit<EventSaveQuest>(v2);
    }

    // decompiled from Move bytecode v6
}

