module 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GuardianCap has store, key {
        id: 0x2::object::UID,
    }

    struct TeamCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
    }

    public fun destroy_guardian_cap(arg0: GuardianCap) {
        let GuardianCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_keeper_cap(arg0: KeeperCap) {
        let KeeperCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_team_cap(arg0: TeamCap) {
        let TeamCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = GuardianCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GuardianCap>(v2, v0);
        let v3 = TeamCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TeamCap>(v3, v0);
        let v4 = KeeperCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<KeeperCap>(v4, v0);
    }

    public fun new_guardian_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : GuardianCap {
        GuardianCap{id: 0x2::object::new(arg1)}
    }

    public fun new_keeper_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : KeeperCap {
        KeeperCap{id: 0x2::object::new(arg1)}
    }

    public fun new_team_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : TeamCap {
        TeamCap{id: 0x2::object::new(arg1)}
    }

    // decompiled from Move bytecode v7
}

