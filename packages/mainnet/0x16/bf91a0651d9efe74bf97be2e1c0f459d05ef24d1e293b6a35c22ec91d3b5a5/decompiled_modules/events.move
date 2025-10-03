module 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::events {
    struct OracleCreated has copy, drop {
        oracle_id: 0x2::object::ID,
        admin: address,
        initial_price: u64,
    }

    struct PriceUpdated has copy, drop {
        oracle_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
        updater: address,
    }

    struct UpdaterAdded has copy, drop {
        oracle_id: 0x2::object::ID,
        updater: address,
    }

    struct UpdaterRemoved has copy, drop {
        oracle_id: 0x2::object::ID,
        updater: address,
    }

    struct AdminChanged has copy, drop {
        oracle_id: 0x2::object::ID,
        old_admin: address,
        new_admin: address,
    }

    public(friend) fun admin_changed(arg0: 0x2::object::ID, arg1: address, arg2: address) {
        let v0 = AdminChanged{
            oracle_id : arg0,
            old_admin : arg1,
            new_admin : arg2,
        };
        0x2::event::emit<AdminChanged>(v0);
    }

    public(friend) fun oracle_created(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = OracleCreated{
            oracle_id     : arg0,
            admin         : arg1,
            initial_price : arg2,
        };
        0x2::event::emit<OracleCreated>(v0);
    }

    public(friend) fun price_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address) {
        let v0 = PriceUpdated{
            oracle_id : arg0,
            old_price : arg1,
            new_price : arg2,
            updater   : arg3,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    public(friend) fun updater_added(arg0: 0x2::object::ID, arg1: address) {
        let v0 = UpdaterAdded{
            oracle_id : arg0,
            updater   : arg1,
        };
        0x2::event::emit<UpdaterAdded>(v0);
    }

    public(friend) fun updater_removed(arg0: 0x2::object::ID, arg1: address) {
        let v0 = UpdaterRemoved{
            oracle_id : arg0,
            updater   : arg1,
        };
        0x2::event::emit<UpdaterRemoved>(v0);
    }

    // decompiled from Move bytecode v6
}

