module 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source {
    struct SourceObjectKey has copy, drop, store {
        pos0: u16,
    }

    struct Source<phantom T0> has store, key {
        id: 0x2::object::UID,
        source_cap: 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::SourceCap,
    }

    public fun source_id<T0>(arg0: &Source<T0>) : u16 {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::source_id(&arg0.source_cap)
    }

    public fun borrow_mut_id<T0: drop>(arg0: &mut Source<T0>, arg1: T0) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun set_authorized<T0, T1>(arg0: &mut Source<T0>, arg1: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg2: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T1>, arg3: bool) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::set_authorized<T1>(arg1, arg2, &mut arg0.source_cap, arg3);
    }

    public fun borrow_source_cap<T0: drop>(arg0: &Source<T0>, arg1: T0) : &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::SourceCap {
        &arg0.source_cap
    }

    public fun child_exists<T0, T1: copy + drop + store>(arg0: &Source<T0>, arg1: T1) : bool {
        0x2::derived_object::exists<T1>(&arg0.id, arg1)
    }

    public fun child_id<T0, T1: copy + drop + store>(arg0: &Source<T0>, arg1: T1) : 0x2::object::ID {
        0x2::object::id_from_address(0x2::derived_object::derive_address<T1>(0x2::object::uid_to_inner(&arg0.id), arg1))
    }

    public fun create<T0, T1>(arg0: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T1>) : Source<T0> {
        let v0 = 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::new_source_id<T0, T1>(arg0, arg1);
        let v1 = 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::source_id(&v0);
        let v2 = SourceObjectKey{pos0: v1};
        let v3 = Source<T0>{
            id         : 0x2::derived_object::claim<SourceObjectKey>(0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::borrow_mut_id(arg0), v2),
            source_cap : v0,
        };
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::events::emit_created_source(v1, 0x2::object::uid_to_inner(&v3.id));
        v3
    }

    public fun derived_id(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg1: u16) : 0x2::object::ID {
        let v0 = SourceObjectKey{pos0: arg1};
        0x2::object::id_from_address(0x2::derived_object::derive_address<SourceObjectKey>(0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::id(arg0), v0))
    }

    public fun object_id<T0>(arg0: &Source<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun share<T0>(arg0: Source<T0>) {
        0x2::transfer::share_object<Source<T0>>(arg0);
    }

    // decompiled from Move bytecode v7
}

