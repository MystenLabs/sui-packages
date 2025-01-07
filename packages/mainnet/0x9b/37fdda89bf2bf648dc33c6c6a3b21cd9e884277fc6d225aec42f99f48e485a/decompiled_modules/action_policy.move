module 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::action_policy {
    struct ActionPolicy has store, key {
        id: 0x2::object::UID,
        rule: 0x1::type_name::TypeName,
        input_assets: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        output_assets: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public(friend) fun new<T0: drop>(arg0: &mut 0x2::tx_context::TxContext) : ActionPolicy {
        ActionPolicy{
            id            : 0x2::object::new(arg0),
            rule          : 0x1::type_name::get<T0>(),
            input_assets  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            output_assets : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public(friend) fun add_input_asset(arg0: &mut ActionPolicy, arg1: 0x1::type_name::TypeName) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.input_assets, arg1);
    }

    public(friend) fun add_output_asset(arg0: &mut ActionPolicy, arg1: 0x1::type_name::TypeName) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.output_assets, arg1);
    }

    public fun is_input_asset(arg0: &ActionPolicy, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.input_assets, &arg1)
    }

    public fun is_output_asset(arg0: &ActionPolicy, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.output_assets, &arg1)
    }

    public(friend) fun remove_input_asset(arg0: &mut ActionPolicy, arg1: 0x1::type_name::TypeName) {
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.input_assets, &arg1);
    }

    public(friend) fun remove_output_asset(arg0: &mut ActionPolicy, arg1: 0x1::type_name::TypeName) {
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.output_assets, &arg1);
    }

    public fun rule(arg0: &ActionPolicy) : 0x1::type_name::TypeName {
        arg0.rule
    }

    // decompiled from Move bytecode v6
}

