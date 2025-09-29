module 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::wowok {
    struct Wowok has store, key {
        id: 0x2::object::UID,
        initor: address,
        entities: address,
    }

    public fun guard_query(arg0: &Wowok, arg1: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport) {
        let v0 = 0x2::object::id_address<Wowok>(arg0);
        let (v1, v2, _) = 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::ON_PASSPORT(arg1, &v0);
        if (v2 == 900) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), &arg0.initor);
        } else if (v2 == 901) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), &arg0.entities);
        } else {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::Q_CMD_NOT_MATCH();
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Wowok{
            id       : 0x2::object::new(arg0),
            initor   : 0x2::tx_context::sender(arg0),
            entities : 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::entity::create(arg0),
        };
        0x2::transfer::share_object<Wowok>(v0);
    }

    public fun oracle_repository(arg0: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::wowok::ORACLE, arg1: 0x1::string::String, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::repository::wowok(&arg1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::TYPE_WOWOK_ORACLE(), 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::POLICY_MODE_STRICT(), arg2, arg3);
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::repository::wowok_create(v0);
        0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::repository::Repository>(&v0)
    }

    // decompiled from Move bytecode v6
}

