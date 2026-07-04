module 0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source {
    struct PYTH_LAZER_ROLLING has drop {
        dummy_field: bool,
    }

    public fun authorize<T0>(arg0: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<PYTH_LAZER_ROLLING>, arg1: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg2: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::set_authorized<PYTH_LAZER_ROLLING, T0>(arg0, arg1, arg2, true);
    }

    public(friend) fun borrow_mut_id(arg0: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<PYTH_LAZER_ROLLING>) : &mut 0x2::object::UID {
        let v0 = PYTH_LAZER_ROLLING{dummy_field: false};
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::borrow_mut_id<PYTH_LAZER_ROLLING>(arg0, v0)
    }

    public fun create<T0>(arg0: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>) : 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<PYTH_LAZER_ROLLING> {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::create<PYTH_LAZER_ROLLING, T0>(arg0, arg1)
    }

    public fun deauthorize<T0>(arg0: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<PYTH_LAZER_ROLLING>, arg1: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg2: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::set_authorized<PYTH_LAZER_ROLLING, T0>(arg0, arg1, arg2, false);
    }

    public(friend) fun source_cap(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<PYTH_LAZER_ROLLING>) : &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::SourceCap {
        let v0 = PYTH_LAZER_ROLLING{dummy_field: false};
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::borrow_source_cap<PYTH_LAZER_ROLLING>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

