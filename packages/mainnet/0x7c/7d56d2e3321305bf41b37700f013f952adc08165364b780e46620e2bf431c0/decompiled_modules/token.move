module 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::token {
    struct OUTRToken has store, key {
        id: 0x2::object::UID,
        index: u64,
        shader: 0x2::object::ID,
        run: u64,
        signal: 0x1::string::String,
        noise: u16,
        src: 0x1::string::String,
        tag: 0x1::string::String,
        name: 0x1::string::String,
        desc: 0x1::string::String,
        image: 0x1::string::String,
        sequence: 0x1::string::String,
        artist: address,
        created_at: u64,
    }

    struct OUTRTokenCreated has copy, drop {
        id: 0x2::object::ID,
        shader: 0x2::object::ID,
        runner: address,
        run: u64,
        price: u64,
    }

    struct OUTRTokenBurned has copy, drop {
        id: 0x2::object::ID,
    }

    public(friend) fun new(arg0: &mut 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::outrun::OUTR, arg1: 0x2::object::ID, arg2: u64, arg3: u8, arg4: 0x1::string::String, arg5: &0x1::string::String, arg6: &0x1::string::String, arg7: &0x1::string::String, arg8: &0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: address, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : OUTRToken {
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::validate::src(arg5);
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::validate::data(arg6, arg7, arg8, &arg9, &arg10);
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::validate::signal(&arg4);
        let v0 = OUTRToken{
            id         : 0x2::object::new(arg14),
            index      : 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::outrun::token(arg0),
            shader     : arg1,
            run        : arg2,
            signal     : arg4,
            noise      : 0,
            src        : *arg5,
            tag        : 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::signal::tag_channel(*arg6, arg3),
            name       : *arg7,
            desc       : *arg8,
            image      : arg9,
            sequence   : arg10,
            artist     : arg11,
            created_at : 0x2::clock::timestamp_ms(arg13),
        };
        let v1 = 0x2::object::id<OUTRToken>(&v0);
        v0.noise = 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::signal::gen_noise(&v1);
        let v2 = OUTRTokenCreated{
            id     : 0x2::object::id<OUTRToken>(&v0),
            shader : arg1,
            runner : 0x2::tx_context::sender(arg14),
            run    : arg2,
            price  : arg12,
        };
        0x2::event::emit<OUTRTokenCreated>(v2);
        v0
    }

    public(friend) fun burn(arg0: OUTRToken) {
        let v0 = OUTRTokenBurned{id: 0x2::object::id<OUTRToken>(&arg0)};
        0x2::event::emit<OUTRTokenBurned>(v0);
        let OUTRToken {
            id         : v1,
            index      : _,
            shader     : _,
            run        : _,
            signal     : _,
            noise      : _,
            src        : _,
            tag        : _,
            name       : _,
            desc       : _,
            image      : _,
            sequence   : _,
            artist     : _,
            created_at : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    entry fun set_image(arg0: &mut OUTRToken, arg1: 0x1::string::String) {
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::validate::image(&arg1);
        arg0.image = arg1;
    }

    entry fun set_sequence(arg0: &mut OUTRToken, arg1: 0x1::string::String) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name} #{run}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{desc}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{sequence}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{artist}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://out.run/t/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://out.run/"));
        let v4 = 0x2::display::new_with_fields<OUTRToken>(arg0, v0, v2, arg1);
        0x2::display::update_version<OUTRToken>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<OUTRToken>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

