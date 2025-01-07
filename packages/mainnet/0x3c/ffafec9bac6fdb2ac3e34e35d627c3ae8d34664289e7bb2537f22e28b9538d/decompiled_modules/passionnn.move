module 0x3cffafec9bac6fdb2ac3e34e35d627c3ae8d34664289e7bb2537f22e28b9538d::passionnn {
    struct PASSIONNN has drop {
        dummy_field: bool,
    }

    struct Passionnn has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: vector<Attribute>,
        birthdate: u64,
    }

    struct AppCap has key {
        id: 0x2::object::UID,
        app_name: 0x1::string::String,
        time_limit: u64,
        minting_limit: u64,
        minting_counter: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Attribute has copy, drop, store {
        name: vector<0x1::string::String>,
        value: vector<0x1::string::String>,
    }

    struct PasMinted has copy, drop {
        id: 0x2::object::ID,
        app_name: 0x1::string::String,
        attributes: vector<Attribute>,
        created_by: address,
    }

    public fun attributes<T0>(arg0: &Passionnn) : &vector<Attribute> {
        &arg0.attributes
    }

    public fun birthdate(arg0: &Passionnn) : u64 {
        arg0.birthdate
    }

    public fun burn(arg0: Passionnn) {
        let Passionnn {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            attributes  : _,
            birthdate   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun burn_for_testing<T0>(arg0: Passionnn) {
        let Passionnn {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            attributes  : _,
            birthdate   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: PASSIONNN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<PASSIONNN>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Passionnn>(&v4, v0, v2, arg1);
        0x2::display::update_version<Passionnn>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Passionnn>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AppCap{
            id              : 0x2::object::new(arg1),
            app_name        : 0x1::string::utf8(b"Passionnn"),
            time_limit      : 1747210328000,
            minting_limit   : 5,
            minting_counter : 0,
        };
        0x2::transfer::share_object<AppCap>(v6);
    }

    public entry fun mint(arg0: &mut AppCap, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) <= arg0.time_limit, 1);
        assert!(arg0.minting_counter < arg0.minting_limit, 2);
        arg0.minting_counter = arg0.minting_counter + 1;
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"Country"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"USA"));
        let v3 = Attribute{
            name  : v1,
            value : v2,
        };
        let v4 = 0x1::vector::empty<Attribute>();
        0x1::vector::push_back<Attribute>(&mut v4, v3);
        let v5 = Passionnn{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(b"Passionnn"),
            description : 0x1::string::utf8(b"Test"),
            image_url   : arg1,
            attributes  : v4,
            birthdate   : 0x2::clock::timestamp_ms(arg2),
        };
        let v6 = PasMinted{
            id         : 0x2::object::id<Passionnn>(&v5),
            app_name   : arg0.app_name,
            attributes : v4,
            created_by : v0,
        };
        0x2::event::emit<PasMinted>(v6);
        0x2::transfer::public_transfer<Passionnn>(v5, v0);
    }

    public fun mint_for_testing<T0>(arg0: &mut 0x2::tx_context::TxContext) : Passionnn {
        let v0 = 0x2::object::new(arg0);
        0x1::hash::sha3_256(0x2::bcs::to_bytes<0x2::object::UID>(&v0));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"Country"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"USA"));
        let v3 = Attribute{
            name  : v1,
            value : v2,
        };
        let v4 = 0x1::vector::empty<Attribute>();
        0x1::vector::push_back<Attribute>(&mut v4, v3);
        Passionnn{
            id          : v0,
            name        : 0x1::string::utf8(b"test"),
            description : 0x1::string::utf8(b"test"),
            image_url   : 0x1::string::utf8(b"http://test.com"),
            attributes  : v4,
            birthdate   : 0,
        }
    }

    public fun test_destroy_admin_cap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun test_new_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    public fun uid(arg0: &Passionnn) : &0x2::object::UID {
        &arg0.id
    }

    public entry fun update_image_url(arg0: &mut Passionnn, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.image_url = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

