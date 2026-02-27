module 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::outrun {
    struct OUTR has store, key {
        id: 0x2::object::UID,
        fee: u16,
        treasury: address,
        live: bool,
        shaders: u64,
        tokens: u64,
        created_at: u64,
    }

    struct OUTRKey has key {
        id: 0x2::object::UID,
    }

    struct OUTRAdmin has key {
        id: 0x2::object::UID,
    }

    struct OUTRCreated has copy, drop {
        id: 0x2::object::ID,
    }

    entry fun create(arg0: OUTRKey, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OUTR{
            id         : 0x2::object::new(arg2),
            fee        : 0,
            treasury   : 0x2::tx_context::sender(arg2),
            live       : true,
            shaders    : 0,
            tokens     : 0,
            created_at : 0x2::clock::timestamp_ms(arg1),
        };
        let v1 = OUTRCreated{id: 0x2::object::id<OUTR>(&v0)};
        0x2::event::emit<OUTRCreated>(v1);
        0x2::transfer::share_object<OUTR>(v0);
        let OUTRKey { id: v2 } = arg0;
        0x2::object::delete(v2);
    }

    public(friend) fun fee(arg0: &OUTR) : u16 {
        arg0.fee
    }

    entry fun set_fee(arg0: &OUTRAdmin, arg1: &mut OUTR, arg2: u16) {
        assert!(arg2 <= 500, 2);
        arg1.fee = arg2;
    }

    entry fun set_live(arg0: &OUTRAdmin, arg1: &mut OUTR, arg2: bool) {
        arg1.live = arg2;
    }

    entry fun set_treasury(arg0: &OUTRAdmin, arg1: &mut OUTR, arg2: address) {
        arg1.treasury = arg2;
    }

    public(friend) fun setup(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        setup_admin(arg1);
        setup_display(arg0, arg1);
    }

    fun setup_admin(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OUTRKey{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OUTRKey>(v0, 0x2::tx_context::sender(arg0));
        let v1 = OUTRAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OUTRAdmin>(v1, 0x2::tx_context::sender(arg0));
    }

    fun setup_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"OUTRUN"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Nothing here but shaders."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://space.out.run/4f555452554e-4f555452.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://out.run/"));
        let v4 = 0x2::display::new_with_fields<OUTR>(arg0, v0, v2, arg1);
        0x2::display::update_version<OUTR>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<OUTR>>(v4, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun shader(arg0: &mut OUTR) : u64 {
        arg0.shaders = arg0.shaders + 1;
        arg0.shaders
    }

    public(friend) fun token(arg0: &mut OUTR) : u64 {
        assert!(arg0.live, 1);
        arg0.tokens = arg0.tokens + 1;
        arg0.tokens
    }

    public(friend) fun treasury(arg0: &OUTR) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v6
}

