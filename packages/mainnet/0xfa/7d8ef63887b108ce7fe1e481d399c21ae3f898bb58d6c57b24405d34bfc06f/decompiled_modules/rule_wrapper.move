module 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper {
    struct RuleInitWrapper<phantom T0, T1> {
        rule: T1,
    }

    struct RuleUpdateWrapper<phantom T0, T1> {
        rule: T1,
    }

    public(friend) fun borrow_init<T0, T1>(arg0: &RuleInitWrapper<T0, T1>) : &T1 {
        &arg0.rule
    }

    public(friend) fun borrow_init_mut<T0, T1>(arg0: &mut RuleInitWrapper<T0, T1>) : &mut T1 {
        &mut arg0.rule
    }

    public(friend) fun borrow_update<T0, T1>(arg0: &RuleUpdateWrapper<T0, T1>) : &T1 {
        &arg0.rule
    }

    public(friend) fun borrow_update_mut<T0, T1>(arg0: &mut RuleUpdateWrapper<T0, T1>) : &mut T1 {
        &mut arg0.rule
    }

    public(friend) fun new_init<T0, T1>(arg0: T1) : RuleInitWrapper<T0, T1> {
        RuleInitWrapper<T0, T1>{rule: arg0}
    }

    public(friend) fun new_update<T0, T1>(arg0: T1) : RuleUpdateWrapper<T0, T1> {
        RuleUpdateWrapper<T0, T1>{rule: arg0}
    }

    public(friend) fun unwrap_init<T0, T1>(arg0: RuleInitWrapper<T0, T1>) : T1 {
        let RuleInitWrapper { rule: v0 } = arg0;
        v0
    }

    public(friend) fun unwrap_update<T0, T1>(arg0: RuleUpdateWrapper<T0, T1>) : T1 {
        let RuleUpdateWrapper { rule: v0 } = arg0;
        v0
    }

    // decompiled from Move bytecode v7
}

