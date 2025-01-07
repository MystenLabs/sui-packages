module 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::project {
    struct ProjectInfo has copy, drop, store {
        project_id: 0x2::object::ID,
        name: 0x1::string::String,
        twitter: 0x1::string::String,
        discord: 0x1::string::String,
        telegram: 0x1::string::String,
        medium: 0x1::string::String,
        website: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        link_url: 0x1::string::String,
    }

    struct Project has store, key {
        id: 0x2::object::UID,
        info: ProjectInfo,
    }

    struct PROJECT has drop {
        dummy_field: bool,
    }

    struct NewProject has copy, drop {
        project_id: 0x2::object::ID,
        project_name: 0x1::string::String,
        sender: address,
    }

    fun display<T0: key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"YouSUI x {info.name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{info.link_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{info.image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{info.description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{info.website}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"YouSUI Creator"));
        let v4 = 0x2::display::new_with_fields<T0>(arg0, v0, v2, arg1);
        0x2::display::update_version<T0>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<T0>>(v4, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun add_dynamic_object_field<T0: store + key>(arg0: &mut Project, arg1: 0x1::string::String, arg2: T0) {
        0x2::dynamic_object_field::add<0x1::string::String, T0>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun borrow_mut_dynamic_object_field<T0: store + key>(arg0: &mut Project, arg1: 0x1::string::String) : &mut T0 {
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, T0>(&mut arg0.id, arg1)
    }

    public(friend) fun create_project(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : Project {
        let v0 = 0x2::object::new(arg9);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = NewProject{
            project_id   : v1,
            project_name : arg0,
            sender       : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<NewProject>(v2);
        let v3 = ProjectInfo{
            project_id  : v1,
            name        : arg0,
            twitter     : arg1,
            discord     : arg2,
            telegram    : arg3,
            medium      : arg4,
            website     : arg5,
            image_url   : arg6,
            description : arg7,
            link_url    : arg8,
        };
        Project{
            id   : v0,
            info : v3,
        }
    }

    public fun get_project_info(arg0: &Project) : ProjectInfo {
        arg0.info
    }

    public fun get_project_name(arg0: &ProjectInfo) : 0x1::string::String {
        arg0.name
    }

    fun init(arg0: PROJECT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PROJECT>(arg0, arg1);
        display<Project>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

