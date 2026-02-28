module 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::setup {
    struct SETUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SETUP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SETUP>(arg0, arg1);
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::outrun::setup(&v0, arg1);
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::shader::setup(&v0, arg1);
        0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::token::setup(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

