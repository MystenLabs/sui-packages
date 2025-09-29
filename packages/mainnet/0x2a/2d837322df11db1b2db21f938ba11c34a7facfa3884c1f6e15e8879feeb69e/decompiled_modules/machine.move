module 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::machine {
    struct Machine has key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        nodes: 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::LinkedTable<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>,
        consensus_repositories: vector<address>,
        endpoint: 0x1::option::Option<0x1::string::String>,
        permission: address,
        bPaused: bool,
        bPublished: bool,
    }

    public fun new(arg0: 0x1::string::String, arg1: 0x1::option::Option<0x1::string::String>, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) : Machine {
        let v0 = 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission>(arg2);
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &v0, 600, arg3);
        new_imp(&arg0, &arg1, &v0, arg3)
    }

    public fun clone(arg0: &Machine, arg1: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) : Machine {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg1, &arg0.permission, 603, arg2);
        clone_imp(arg0, arg2)
    }

    fun clone_imp(arg0: &Machine, arg1: &mut 0x2::tx_context::TxContext) : Machine {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = Machine{
            id                     : v0,
            description            : arg0.description,
            nodes                  : 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::new<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&v1),
            consensus_repositories : arg0.consensus_repositories,
            endpoint               : arg0.endpoint,
            permission             : arg0.permission,
            bPaused                : false,
            bPublished             : false,
        };
        let v3 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::front<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&arg0.nodes);
        while (0x1::option::is_some<0x1::string::String>(v3)) {
            let v4 = *0x1::option::borrow<0x1::string::String>(v3);
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::push_back<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&mut v2.id, &mut v2.nodes, v4, *0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::borrow<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&arg0.id, &arg0.nodes, v4));
            v3 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::next<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&arg0.id, &arg0.nodes, v4);
        };
        v2
    }

    public fun clone_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &Machine, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) : Machine {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 603, arg3);
        clone_imp(arg1, arg3)
    }

    public fun consensus_repositories_contains(arg0: &Machine, arg1: &address) : bool {
        0x1::vector::contains<address>(&arg0.consensus_repositories, arg1)
    }

    public fun create(arg0: Machine) : address {
        0x2::transfer::share_object<Machine>(arg0);
        0x2::object::id_address<Machine>(&arg0)
    }

    public fun description_set(arg0: &mut Machine, arg1: 0x1::string::String, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &arg0.permission, 601, arg3);
        description_set_imp(arg0, &arg1);
    }

    fun description_set_imp(arg0: &mut Machine, arg1: &0x1::string::String) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_DESCRIPTIONLEN(arg1);
        arg0.description = *arg1;
    }

    public fun description_set_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Machine, arg2: 0x1::string::String, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 601, arg4);
        description_set_imp(arg1, &arg2);
    }

    public fun endpoint_set(arg0: &mut Machine, arg1: 0x1::option::Option<0x1::string::String>, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &arg0.permission, 605, arg3);
        endpoint_set_imp(arg0, &arg1);
    }

    fun endpoint_set_imp(arg0: &mut Machine, arg1: &0x1::option::Option<0x1::string::String>) {
        if (0x1::option::is_some<0x1::string::String>(arg1)) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_ENDPOINTLEN(0x1::option::borrow<0x1::string::String>(arg1));
        };
        arg0.endpoint = *arg1;
    }

    public fun endpoint_set_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Machine, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 605, arg4);
        endpoint_set_imp(arg1, &arg2);
    }

    public fun guard_query(arg0: &Machine, arg1: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport) {
        let v0 = 0x2::object::id_address<Machine>(arg0);
        let (v1, v2, _) = 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::ON_PASSPORT(arg1, &v0);
        if (v2 == 700) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), &arg0.permission);
        } else if (v2 == 701) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &arg0.bPaused);
        } else if (v2 == 702) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &arg0.bPublished);
        } else if (v2 == 703) {
            let v4 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1);
            let v5 = 0x1::vector::contains<address>(&arg0.consensus_repositories, &v4);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v5);
        } else if (v2 == 704) {
            let v6 = 0x1::option::is_some<0x1::string::String>(&arg0.endpoint);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v6);
        } else if (v2 == 705) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_STRING(), 0x1::option::borrow<0x1::string::String>(&arg0.endpoint));
        } else {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::Q_CMD_NOT_MATCH();
        };
    }

    fun new_imp(arg0: &0x1::string::String, arg1: &0x1::option::Option<0x1::string::String>, arg2: &address, arg3: &mut 0x2::tx_context::TxContext) : Machine {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_DESCRIPTIONLEN(arg0);
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_address(&v0);
        Machine{
            id                     : v0,
            description            : *arg0,
            nodes                  : 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::new<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&v1),
            consensus_repositories : 0x1::vector::empty<address>(),
            endpoint               : *arg1,
            permission             : *arg2,
            bPaused                : true,
            bPublished             : false,
        }
    }

    public fun new_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) : Machine {
        let v0 = 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission>(arg3);
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &v0, 600, arg4);
        new_imp(&arg1, &arg2, &v0, arg4)
    }

    public fun node_add(arg0: &mut Machine, arg1: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::Node, arg2: bool, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg3, &arg0.permission, 604, arg4);
        node_add_imp(arg0, arg1, arg2);
    }

    fun node_add_imp(arg0: &mut Machine, arg1: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::Node, arg2: bool) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::UNPUBLISHED(arg0.bPublished);
        let (v0, v1) = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::node_get(arg1);
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::contains<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&arg0.id, &arg0.nodes, *v0)) {
            if (arg2) {
                *0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&mut arg0.id, &mut arg0.nodes, *v0) = *v1;
            } else {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::node_add_imp(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&mut arg0.id, &mut arg0.nodes, *v0), arg1);
            };
        } else {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NODE_COUNT(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::length<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&arg0.nodes));
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::push_back<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&mut arg0.id, &mut arg0.nodes, *v0, *v1);
        };
    }

    public fun node_add_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Machine, arg2: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::Node, arg3: bool, arg4: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg4, &arg1.permission, 604, arg5);
        node_add_imp(arg1, arg2, arg3);
    }

    public fun node_borrow(arg0: &Machine, arg1: &0x1::string::String) : &0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair> {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::borrow<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&arg0.id, &arg0.nodes, *arg1)
    }

    public fun node_contains(arg0: &Machine, arg1: &0x1::string::String) : bool {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::contains<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&arg0.id, &arg0.nodes, *arg1)
    }

    public fun node_fetch(arg0: &mut Machine, arg1: 0x1::string::String, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) : 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::Node {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &arg0.permission, 604, arg3);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::node_new2(&arg1, node_fetch_imp(arg0, &arg1))
    }

    fun node_fetch_imp(arg0: &mut Machine, arg1: &0x1::string::String) : &mut 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair> {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::UNPUBLISHED(arg0.bPublished);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&mut arg0.id, &mut arg0.nodes, *arg1)
    }

    public fun node_fetch_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Machine, arg2: 0x1::string::String, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) : 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::Node {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 604, arg4);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::node_new2(&arg2, node_fetch_imp(arg1, &arg2))
    }

    public fun node_remove(arg0: &mut Machine, arg1: vector<0x1::string::String>, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &arg0.permission, 604, arg3);
        node_remove_imp(arg0, &arg1);
    }

    fun node_remove_imp(arg0: &mut Machine, arg1: &vector<0x1::string::String>) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::UNPUBLISHED(arg0.bPublished);
        let v0 = 0x1::vector::length<0x1::string::String>(arg1);
        while (v0 > 0) {
            let v1 = 0x1::vector::borrow<0x1::string::String>(arg1, v0 - 1);
            if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::contains<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&arg0.id, &arg0.nodes, *v1)) {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::remove<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&mut arg0.id, &mut arg0.nodes, *v1);
                let v2 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::front<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&arg0.nodes);
                while (0x1::option::is_some<0x1::string::String>(v2)) {
                    let v3 = *0x1::option::borrow<0x1::string::String>(v2);
                    0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::pair_remove_imp(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&mut arg0.id, &mut arg0.nodes, v3), v1);
                    v2 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::next<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&arg0.id, &arg0.nodes, v3);
                };
            };
            v0 = v0 - 1;
        };
    }

    public fun node_remove_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Machine, arg2: vector<0x1::string::String>, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 604, arg4);
        node_remove_imp(arg1, &arg2);
    }

    public fun node_rename(arg0: &mut Machine, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg3, &arg0.permission, 604, arg4);
        node_rename_imp(arg0, &arg1, &arg2);
    }

    fun node_rename_imp(arg0: &mut Machine, arg1: &0x1::string::String, arg2: &0x1::string::String) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::UNPUBLISHED(arg0.bPublished);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_NAMELEN_ANDNOT_EMPTY(arg2);
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::contains<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&arg0.id, &arg0.nodes, *arg1)) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::push_front<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&mut arg0.id, &mut arg0.nodes, *arg2, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::remove<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&mut arg0.id, &mut arg0.nodes, *arg1));
            let v0 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::front<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&arg0.nodes);
            while (0x1::option::is_some<0x1::string::String>(v0)) {
                let v1 = *0x1::option::borrow<0x1::string::String>(v0);
                let v2 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&mut arg0.id, &mut arg0.nodes, v1);
                if (0x2::vec_map::contains<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>(v2, arg1)) {
                    let (_, v4) = 0x2::vec_map::remove<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>(v2, arg1);
                    0x2::vec_map::insert<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>(v2, *arg2, v4);
                };
                v0 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::next<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NodePair>>(&arg0.id, &arg0.nodes, v1);
            };
        } else {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::NODE_EXIST();
        };
    }

    public fun node_rename_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Machine, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg4, &arg1.permission, 604, arg5);
        node_rename_imp(arg1, &arg2, &arg3);
    }

    public fun on_progress_new(arg0: &Machine) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine::PROGRESS(arg0.bPaused, arg0.bPublished);
    }

    public fun pause(arg0: &mut Machine, arg1: bool, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &arg0.permission, 606, arg3);
        pause_imp(arg0, arg1);
    }

    fun pause_imp(arg0: &mut Machine, arg1: bool) {
        arg0.bPaused = arg1;
    }

    public fun pause_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Machine, arg2: bool, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 606, arg4);
        pause_imp(arg1, arg2);
    }

    public fun paused(arg0: &Machine) : bool {
        arg0.bPaused
    }

    public fun permission_id(arg0: &Machine) : &address {
        &arg0.permission
    }

    public fun permission_set(arg0: &mut Machine, arg1: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_CREATOR(arg1, arg3);
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_ADMIN(arg2, arg3);
        arg0.permission = 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission>(arg2);
    }

    public fun publish(arg0: &mut Machine, arg1: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg1, &arg0.permission, 607, arg2);
        publish_imp(arg0);
    }

    fun publish_imp(arg0: &mut Machine) {
        arg0.bPaused = false;
        arg0.bPublished = true;
    }

    public fun publish_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Machine, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 607, arg3);
        publish_imp(arg1);
    }

    public fun published(arg0: &Machine) : bool {
        arg0.bPublished
    }

    public fun repository_add(arg0: &mut Machine, arg1: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::repository::Repository, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &arg0.permission, 602, arg3);
        repository_add_imp(arg0, arg1);
    }

    fun repository_add_imp(arg0: &mut Machine, arg1: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::repository::Repository) {
        let v0 = 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::repository::Repository>(arg1);
        if (!0x1::vector::contains<address>(&arg0.consensus_repositories, &v0)) {
            0x1::vector::push_back<address>(&mut arg0.consensus_repositories, v0);
        };
    }

    public fun repository_add_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Machine, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::repository::Repository, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 602, arg4);
        repository_add_imp(arg1, arg2);
    }

    public fun repository_remove(arg0: &mut Machine, arg1: vector<address>, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &arg0.permission, 602, arg3);
        repository_remove_imp(arg0, &arg1);
    }

    public fun repository_remove_all(arg0: &mut Machine, arg1: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg1, &arg0.permission, 602, arg2);
        repository_remove_all_imp(arg0);
    }

    fun repository_remove_all_imp(arg0: &mut Machine) {
        arg0.consensus_repositories = 0x1::vector::empty<address>();
    }

    public fun repository_remove_all_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Machine, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 602, arg3);
        repository_remove_all_imp(arg1);
    }

    fun repository_remove_imp(arg0: &mut Machine, arg1: &vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1)) {
            let (v1, v2) = 0x1::vector::index_of<address>(&arg0.consensus_repositories, 0x1::vector::borrow<address>(arg1, v0));
            if (v1) {
                0x1::vector::remove<address>(&mut arg0.consensus_repositories, v2);
            };
            v0 = v0 + 1;
        };
    }

    public fun repository_remove_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Machine, arg2: vector<address>, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 602, arg4);
        repository_remove_imp(arg1, &arg2);
    }

    // decompiled from Move bytecode v6
}

