module 0x4779c9188b6076cb36f9c12b75c74652c13266cc720a9461e6fddf2929ec2afc::source {
    struct SWITCHBOARD has drop {
        dummy_field: bool,
    }

    public fun authorize<T0>(arg0: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<SWITCHBOARD>, arg1: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg2: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::set_authorized<SWITCHBOARD, T0>(arg0, arg1, arg2, true);
    }

    public fun create<T0>(arg0: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>) : 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<SWITCHBOARD> {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::create<SWITCHBOARD, T0>(arg0, arg1)
    }

    public fun deauthorize<T0>(arg0: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<SWITCHBOARD>, arg1: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg2: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::set_authorized<SWITCHBOARD, T0>(arg0, arg1, arg2, false);
    }

    public(friend) fun source_cap(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<SWITCHBOARD>) : &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::SourceCap {
        let v0 = SWITCHBOARD{dummy_field: false};
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::borrow_source_cap<SWITCHBOARD>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

