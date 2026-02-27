module 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::shader {
    struct OUTRShader has store, key {
        id: 0x2::object::UID,
        index: u64,
        src: 0x1::string::String,
        tag: 0x1::string::String,
        name: 0x1::string::String,
        desc: 0x1::string::String,
        image: 0x1::string::String,
        sequence: 0x1::string::String,
        artist: address,
        gate: 0x1::option::Option<0x2::object::ID>,
        created_at: u64,
        updated_at: u64,
    }

    struct OUTRShaderCreated has copy, drop {
        id: 0x2::object::ID,
        artist: address,
    }

    struct OUTRShaderUpdated has copy, drop {
        id: 0x2::object::ID,
    }

    struct OUTRShaderCompiled has copy, drop {
        id: 0x2::object::ID,
        gate: 0x2::object::ID,
    }

    struct OUTRShaderBurned has copy, drop {
        id: 0x2::object::ID,
    }

    fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : OUTRShader {
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::validate::data(&arg0, &arg1, &arg2, &arg3, &arg4);
        let v0 = OUTRShader{
            id         : 0x2::object::new(arg7),
            index      : 0,
            src        : 0x1::string::utf8(b""),
            tag        : arg0,
            name       : arg1,
            desc       : arg2,
            image      : arg3,
            sequence   : arg4,
            artist     : arg5,
            gate       : 0x1::option::none<0x2::object::ID>(),
            created_at : 0x2::clock::timestamp_ms(arg6),
            updated_at : 0x2::clock::timestamp_ms(arg6),
        };
        let v1 = OUTRShaderCreated{
            id     : 0x2::object::id<OUTRShader>(&v0),
            artist : arg5,
        };
        0x2::event::emit<OUTRShaderCreated>(v1);
        v0
    }

    public(friend) fun artist(arg0: &OUTRShader) : address {
        arg0.artist
    }

    public(friend) fun assert_gate(arg0: &OUTRShader, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert!(compiled(arg0), 2);
        assert!(0x2::object::id<OUTRShader>(arg0) == arg1, 3);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.gate) == arg2, 3);
    }

    entry fun burn(arg0: OUTRShader) {
        assert!(!compiled(&arg0), 1);
        let v0 = OUTRShaderBurned{id: 0x2::object::id<OUTRShader>(&arg0)};
        0x2::event::emit<OUTRShaderBurned>(v0);
        let OUTRShader {
            id         : v1,
            index      : _,
            src        : _,
            tag        : _,
            name       : _,
            desc       : _,
            image      : _,
            sequence   : _,
            artist     : _,
            gate       : _,
            created_at : _,
            updated_at : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public(friend) fun compile(arg0: &mut 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::outrun::OUTR, arg1: &mut OUTRShader, arg2: 0x2::object::ID, arg3: u8, arg4: &0x2::clock::Clock) {
        assert!(!compiled(arg1), 1);
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::validate::src(&arg1.src);
        arg1.index = 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::outrun::shader(arg0);
        arg1.tag = 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::signal::tag_channel(arg1.tag, arg3);
        arg1.gate = 0x1::option::some<0x2::object::ID>(arg2);
        arg1.updated_at = 0x2::clock::timestamp_ms(arg4);
        let v0 = OUTRShaderCompiled{
            id   : 0x2::object::id<OUTRShader>(arg1),
            gate : arg2,
        };
        0x2::event::emit<OUTRShaderCompiled>(v0);
    }

    public(friend) fun compiled(arg0: &OUTRShader) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.gate)
    }

    public fun create(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : OUTRShader {
        let v0 = 0x2::tx_context::sender(arg6);
        new(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6)
    }

    public(friend) fun desc(arg0: &OUTRShader) : &0x1::string::String {
        &arg0.desc
    }

    public(friend) fun name(arg0: &OUTRShader) : &0x1::string::String {
        &arg0.name
    }

    entry fun set_image(arg0: &mut OUTRShader, arg1: 0x1::string::String) {
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::validate::image(&arg1);
        arg0.image = arg1;
    }

    entry fun set_sequence(arg0: &mut OUTRShader, arg1: 0x1::string::String) {
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::validate::sequence(&arg1);
        arg0.sequence = arg1;
    }

    public(friend) fun setup(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        setup_display(arg0, arg1);
    }

    fun setup_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"animation_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{desc}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{sequence}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{artist}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://out.run/s/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://out.run/"));
        let v4 = 0x2::display::new_with_fields<OUTRShader>(arg0, v0, v2, arg1);
        0x2::display::update_version<OUTRShader>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<OUTRShader>>(v4, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun tag(arg0: &OUTRShader) : &0x1::string::String {
        &arg0.tag
    }

    public fun update(arg0: &mut OUTRShader, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock) {
        assert!(!compiled(arg0), 1);
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::validate::data(&arg1, &arg2, &arg3, &arg4, &arg5);
        arg0.src = 0x1::string::utf8(b"");
        arg0.tag = arg1;
        arg0.name = arg2;
        arg0.desc = arg3;
        arg0.image = arg4;
        arg0.sequence = arg5;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg6);
        let v0 = OUTRShaderUpdated{id: 0x2::object::id<OUTRShader>(arg0)};
        0x2::event::emit<OUTRShaderUpdated>(v0);
    }

    public fun upload(arg0: &mut OUTRShader, arg1: 0x1::string::String) {
        assert!(!compiled(arg0), 1);
        0x1::string::append(&mut arg0.src, arg1);
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::validate::src(&arg0.src);
    }

    // decompiled from Move bytecode v6
}

