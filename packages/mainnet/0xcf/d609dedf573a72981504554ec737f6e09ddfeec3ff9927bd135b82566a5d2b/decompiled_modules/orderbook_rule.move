module 0xcfd609dedf573a72981504554ec737f6e09ddfeec3ff9927bd135b82566a5d2b::orderbook_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public entry fun add<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, Rule, bool>(v0, arg0, arg1, true);
    }

    public(friend) fun prove<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>) {
        if (0x2::transfer_policy::has_rule<T0, Rule>(arg0)) {
            let v0 = Rule{dummy_field: false};
            0x2::transfer_policy::add_receipt<T0, Rule>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

