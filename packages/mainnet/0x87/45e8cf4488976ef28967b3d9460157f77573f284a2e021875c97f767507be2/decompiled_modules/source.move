module 0x8745e8cf4488976ef28967b3d9460157f77573f284a2e021875c97f767507be2::source {
    struct STORK has drop {
        dummy_field: bool,
    }

    public(friend) fun borrow_mut_id(arg0: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<STORK>) : &mut 0x2::object::UID {
        let v0 = STORK{dummy_field: false};
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::borrow_mut_id<STORK>(arg0, v0)
    }

    public fun create<T0>(arg0: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>) : 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<STORK> {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::create<STORK, T0>(arg0, arg1)
    }

    public fun authorize<T0>(arg0: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<STORK>, arg1: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg2: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::set_authorized<STORK, T0>(arg0, arg1, arg2, true);
    }

    public fun deauthorize<T0>(arg0: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<STORK>, arg1: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg2: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::set_authorized<STORK, T0>(arg0, arg1, arg2, false);
    }

    public(friend) fun source_cap(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<STORK>) : &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::SourceCap {
        let v0 = STORK{dummy_field: false};
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::borrow_source_cap<STORK>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

