module 0x12e1f586a1c368f0c871384f0970a39dd84fb35bedb30088424edda55bc1552d::hmu {
    public fun f<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x7053fc17eb04ef22d2a67a709e314600fdbb2177da878684c6b0bd8678c782b7::holder::hold<T0>(arg0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

