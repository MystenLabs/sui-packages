module 0x95c26907367b8c4defd108c6cee70b9499cbf02d34f636c210095597cc95803::source {
    struct PYTH has drop {
        dummy_field: bool,
    }

    public fun authorize<T0>(arg0: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<PYTH>, arg1: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg2: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::set_authorized<PYTH, T0>(arg0, arg1, arg2, true);
    }

    public fun create<T0>(arg0: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>) : 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<PYTH> {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::create<PYTH, T0>(arg0, arg1)
    }

    public fun deauthorize<T0>(arg0: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<PYTH>, arg1: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg2: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::set_authorized<PYTH, T0>(arg0, arg1, arg2, false);
    }

    public(friend) fun source_cap(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<PYTH>) : &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::SourceCap {
        let v0 = PYTH{dummy_field: false};
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::borrow_source_cap<PYTH>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

