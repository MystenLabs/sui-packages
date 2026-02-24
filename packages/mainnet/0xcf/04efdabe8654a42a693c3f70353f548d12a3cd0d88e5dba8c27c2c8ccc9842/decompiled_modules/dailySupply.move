module 0xcf04efdabe8654a42a693c3f70353f548d12a3cd0d88e5dba8c27c2c8ccc9842::dailySupply {
    struct DAILYSUPPLY has drop {
        dummy_field: bool,
    }

    struct Entertain has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct Template has copy, drop, store {
        url: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        templates: vector<Template>,
        year: u64,
    }

    struct DailySpecial has key {
        id: 0x2::object::UID,
        current: Template,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    entry fun burn(arg0: Entertain) {
        let Entertain {
            id        : v0,
            image_url : _,
            name      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun create_new_registry(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id        : 0x2::object::new(arg2),
            templates : 0x1::vector::empty<Template>(),
            year      : arg1,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    fun init(arg0: DAILYSUPPLY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DAILYSUPPLY>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"{image_url}"));
        let v3 = 0x2::display::new_with_fields<Entertain>(&v0, v1, v2, arg1);
        0x2::display::update_version<Entertain>(&mut v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Entertain>>(v3, 0x2::tx_context::sender(arg1));
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
        let v5 = Registry{
            id        : 0x2::object::new(arg1),
            templates : 0x1::vector::empty<Template>(),
            year      : 2026,
        };
        0x2::transfer::share_object<Registry>(v5);
        let v6 = Template{
            url  : 0x1::string::utf8(b"https://arweave.net/b20d095OIoutw3_9d48lu03Ce_JC3YaHcbQw0lxe8O8"),
            name : 0x1::string::utf8(b"Excalibur"),
        };
        let v7 = DailySpecial{
            id      : 0x2::object::new(arg1),
            current : v6,
        };
        0x2::transfer::share_object<DailySpecial>(v7);
    }

    entry fun mint_random(arg0: &Registry, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<Template>(&arg0.templates);
        assert!(v0 > 0, 1);
        let v1 = 0x2::random::new_generator(arg1, arg2);
        let v2 = 0x1::vector::borrow<Template>(&arg0.templates, 0x2::random::generate_u64_in_range(&mut v1, 0, v0 - 1));
        let v3 = Entertain{
            id        : 0x2::object::new(arg2),
            image_url : v2.url,
            name      : v2.name,
        };
        0x2::transfer::public_transfer<Entertain>(v3, 0x2::tx_context::sender(arg2));
    }

    entry fun mint_special(arg0: &DailySpecial, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Entertain{
            id        : 0x2::object::new(arg1),
            image_url : arg0.current.url,
            name      : arg0.current.name,
        };
        0x2::transfer::public_transfer<Entertain>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun remove_option(arg0: &AdminCap, arg1: &mut Registry, arg2: u64) {
        assert!(arg2 < 0x1::vector::length<Template>(&arg1.templates), 0);
        0x1::vector::swap_remove<Template>(&mut arg1.templates, arg2);
    }

    entry fun update_special(arg0: &AdminCap, arg1: &mut DailySpecial, arg2: &mut Registry, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        0x1::vector::push_back<Template>(&mut arg2.templates, arg1.current);
        let v0 = Template{
            url  : arg4,
            name : arg3,
        };
        arg1.current = v0;
    }

    // decompiled from Move bytecode v6
}

