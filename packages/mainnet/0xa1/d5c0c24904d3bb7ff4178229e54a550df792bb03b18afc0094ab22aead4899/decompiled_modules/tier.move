module 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::tier {
    struct Tier has store, key {
        id: 0x2::object::UID,
        risk_config: 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::table_keys::TableKeys<0x1::type_name::TypeName, 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::risk_model::RiskModel>,
        whitelisted_actions: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Tier {
        Tier{
            id                  : 0x2::object::new(arg0),
            risk_config         : 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::risk_model::initialize_risk_model_table(arg0),
            whitelisted_actions : 0x2::vec_set::empty<0x2::object::ID>(),
        }
    }

    public(friend) fun add_whitelisted_action(arg0: &mut Tier, arg1: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.whitelisted_actions, arg1);
    }

    public(friend) fun borrow_risk_config(arg0: &Tier) : &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::table_keys::TableKeys<0x1::type_name::TypeName, 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::risk_model::RiskModel> {
        &arg0.risk_config
    }

    public(friend) fun borrow_risk_config_mut(arg0: &mut Tier) : &mut 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::table_keys::TableKeys<0x1::type_name::TypeName, 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::risk_model::RiskModel> {
        &mut arg0.risk_config
    }

    public fun is_whitelisted_action(arg0: &Tier, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.whitelisted_actions, &arg1)
    }

    public(friend) fun remove_whitelisted_action(arg0: &mut Tier, arg1: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.whitelisted_actions, &arg1);
    }

    // decompiled from Move bytecode v6
}

