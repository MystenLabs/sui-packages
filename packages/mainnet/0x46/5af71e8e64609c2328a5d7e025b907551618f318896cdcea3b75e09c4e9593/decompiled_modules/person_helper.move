module 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person_helper {
    public entry fun add_action_for_objects<T0>(arg0: &mut 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::Person, arg1: address, arg2: vector<0x2::object::ID>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg3);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::add_action_for_objects<T0>(arg0, arg1, arg2, &v0);
    }

    public entry fun add_action_for_type<T0, T1>(arg0: &mut 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::Person, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg2);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::add_action_for_type<T0, T1>(arg0, arg1, &v0);
    }

    public entry fun add_general_action<T0>(arg0: &mut 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::Person, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg2);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::add_general_action<T0>(arg0, arg1, &v0);
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::return_and_share(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::create(0x2::tx_context::sender(arg0), arg0));
    }

    public entry fun destroy(arg0: 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::Person, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg1);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::destroy(arg0, &v0);
    }

    public entry fun remove_action_for_objects_from_agent<T0>(arg0: &mut 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::Person, arg1: address, arg2: vector<0x2::object::ID>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg3);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::remove_action_for_objects_from_agent<T0>(arg0, arg1, arg2, &v0);
    }

    public entry fun remove_action_for_type_from_agent<T0, T1>(arg0: &mut 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::Person, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg2);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::remove_action_for_type_from_agent<T0, T1>(arg0, arg1, &v0);
    }

    public entry fun remove_agent(arg0: &mut 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::Person, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg2);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::remove_agent(arg0, arg1, &v0);
    }

    public entry fun remove_all_actions_for_type_from_agent<T0>(arg0: &mut 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::Person, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg2);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::remove_all_actions_for_type_from_agent<T0>(arg0, arg1, &v0);
    }

    public entry fun remove_all_general_actions_from_agent(arg0: &mut 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::Person, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg2);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::remove_all_general_actions_from_agent(arg0, arg1, &v0);
    }

    public entry fun remove_general_action_from_agent<T0>(arg0: &mut 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::Person, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg2);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::remove_general_action_from_agent<T0>(arg0, arg1, &v0);
    }

    public entry fun remove_objects_from_agent(arg0: &mut 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::Person, arg1: address, arg2: vector<0x2::object::ID>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg3);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person::remove_all_actions_for_objects_from_agent(arg0, arg1, arg2, &v0);
    }

    // decompiled from Move bytecode v6
}

