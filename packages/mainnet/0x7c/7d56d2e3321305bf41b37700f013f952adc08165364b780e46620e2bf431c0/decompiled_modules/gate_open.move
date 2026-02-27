module 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::gate_open {
    struct OUTROpenGate has store, key {
        id: 0x2::object::UID,
        shader: 0x2::object::ID,
        run: u64,
        src: 0x1::string::String,
        tag: 0x1::string::String,
        name: 0x1::string::String,
        desc: 0x1::string::String,
        artist: address,
        supply: u64,
        price: u64,
        payout: address,
    }

    entry fun burn(arg0: OUTROpenGate) {
        let OUTROpenGate {
            id     : v0,
            shader : _,
            run    : _,
            src    : _,
            tag    : _,
            name   : _,
            desc   : _,
            artist : _,
            supply : _,
            price  : _,
            payout : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun collect(arg0: &mut 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::outrun::OUTR, arg1: &mut OUTROpenGate, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!sold_out(arg1), 2);
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::payment::sui_exact(arg0, arg1.price, arg1.payout, arg6, arg8);
        arg1.run = arg1.run + 1;
        0x2::transfer::public_transfer<0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::token::OUTRToken>(0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::token::new(arg0, arg1.shader, arg1.run, arg2, arg3, &arg1.src, &arg1.tag, &arg1.name, &arg1.desc, arg4, arg5, arg1.artist, arg1.price, arg7, arg8), 0x2::tx_context::sender(arg8));
    }

    public fun compile(arg0: &mut 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::outrun::OUTR, arg1: OUTROpenGate, arg2: &mut 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::shader::OUTRShader, arg3: u8, arg4: &0x2::clock::Clock) {
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::validate::src(&arg1.src);
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::shader::compile(arg0, arg2, 0x2::object::id<OUTROpenGate>(&arg1), arg3, arg4);
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::shader::assert_gate(arg2, arg1.shader, 0x2::object::id<OUTROpenGate>(&arg1));
        0x2::transfer::public_share_object<OUTROpenGate>(arg1);
    }

    public fun create(arg0: &mut 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::shader::OUTRShader, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : OUTROpenGate {
        assert!(!0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::shader::compiled(arg0), 1);
        OUTROpenGate{
            id     : 0x2::object::new(arg4),
            shader : 0x2::object::id<0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::shader::OUTRShader>(arg0),
            run    : 0,
            src    : 0x1::string::utf8(b""),
            tag    : *0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::shader::tag(arg0),
            name   : *0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::shader::name(arg0),
            desc   : *0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::shader::desc(arg0),
            artist : 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::shader::artist(arg0),
            supply : arg1,
            price  : arg2,
            payout : arg3,
        }
    }

    entry fun set_payout(arg0: &mut OUTROpenGate, arg1: &0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::shader::OUTRShader, arg2: address) {
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::shader::assert_gate(arg1, arg0.shader, 0x2::object::id<OUTROpenGate>(arg0));
        arg0.payout = arg2;
    }

    fun sold_out(arg0: &OUTROpenGate) : bool {
        arg0.supply > 0 && arg0.run >= arg0.supply
    }

    public fun upload(arg0: &mut OUTROpenGate, arg1: 0x1::string::String) {
        0x1::string::append(&mut arg0.src, arg1);
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::validate::src(&arg0.src);
    }

    // decompiled from Move bytecode v6
}

