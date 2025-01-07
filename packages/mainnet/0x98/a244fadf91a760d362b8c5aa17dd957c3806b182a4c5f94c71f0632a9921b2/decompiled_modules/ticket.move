module 0x98a244fadf91a760d362b8c5aa17dd957c3806b182a4c5f94c71f0632a9921b2::ticket {
    struct Ticket<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        video_url: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: 0x1::string::String,
        date: u64,
        state: 0x1::string::String,
        exported: bool,
    }

    struct TICKET has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct QTConfiguration has store, key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
    }

    public fun admin_mint<T0: store>(arg0: &AdminCap, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: 0x1::string::String, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = Ticket<T0>{
            id          : 0x2::object::new(arg11),
            name        : arg2,
            description : arg3,
            image_url   : arg4,
            video_url   : arg5,
            project_url : arg6,
            creator     : arg7,
            date        : arg8,
            state       : arg9,
            exported    : arg10,
        };
        0x2::transfer::transfer<Ticket<T0>>(v0, arg1);
    }

    public fun burn<T0>(arg0: Ticket<T0>) {
        let Ticket {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            video_url   : _,
            project_url : _,
            creator     : _,
            date        : _,
            state       : _,
            exported    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun date<T0>(arg0: &Ticket<T0>) : u64 {
        arg0.date
    }

    public fun description<T0>(arg0: &Ticket<T0>) : 0x1::string::String {
        arg0.description
    }

    public fun exported<T0>(arg0: &Ticket<T0>) : bool {
        arg0.exported
    }

    public fun id<T0>(arg0: &Ticket<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun image<T0>(arg0: &Ticket<T0>) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: TICKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = QTConfiguration{
            id         : 0x2::object::new(arg1),
            public_key : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<QTConfiguration>(v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<TICKET>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun name<T0>(arg0: &Ticket<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun set_public_key(arg0: &AdminCap, arg1: &mut QTConfiguration, arg2: vector<u8>) {
        arg1.public_key = arg2;
    }

    public fun setup_display<T0: store>(arg0: &AdminCap, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"video_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{video_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        let v4 = 0x2::display::new_with_fields<Ticket<T0>>(arg1, v0, v2, arg2);
        0x2::display::update_version<Ticket<T0>>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<Ticket<T0>>>(v4, 0x2::tx_context::sender(arg2));
    }

    public fun state<T0>(arg0: &Ticket<T0>) : 0x1::string::String {
        arg0.state
    }

    public fun update_state<T0>(arg0: &mut Ticket<T0>, arg1: 0x1::string::String, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &QTConfiguration) {
        assert!(verify_admin_signature(0x2::object::uid_to_inner(&arg0.id), arg1, arg4, arg2, arg3, arg5), 1);
        arg0.state = arg1;
    }

    public fun verify_admin_signature(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: u64, arg4: vector<u8>, arg5: &QTConfiguration) : bool {
        verify_timestamp(arg2, arg3);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x2::ed25519::ed25519_verify(&arg4, &arg5.public_key, &v0)
    }

    fun verify_timestamp(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 0);
    }

    public fun video<T0>(arg0: &Ticket<T0>) : 0x1::string::String {
        arg0.video_url
    }

    // decompiled from Move bytecode v6
}

