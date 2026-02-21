module 0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::access_control {
    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GovernanceCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasuryManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakingManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct CapabilityIssued has copy, drop {
        cap_type: vector<u8>,
        recipient: address,
    }

    struct CapabilityRevoked has copy, drop {
        cap_type: vector<u8>,
        holder: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = SuperAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SuperAdminCap>(v1, v0);
        let v2 = CapabilityIssued{
            cap_type  : b"SuperAdminCap",
            recipient : v0,
        };
        0x2::event::emit<CapabilityIssued>(v2);
        let v3 = GovernanceCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GovernanceCap>(v3, v0);
        let v4 = CapabilityIssued{
            cap_type  : b"GovernanceCap",
            recipient : v0,
        };
        0x2::event::emit<CapabilityIssued>(v4);
        let v5 = TreasuryManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TreasuryManagerCap>(v5, v0);
        let v6 = CapabilityIssued{
            cap_type  : b"TreasuryManagerCap",
            recipient : v0,
        };
        0x2::event::emit<CapabilityIssued>(v6);
        let v7 = StakingManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<StakingManagerCap>(v7, v0);
        let v8 = CapabilityIssued{
            cap_type  : b"StakingManagerCap",
            recipient : v0,
        };
        0x2::event::emit<CapabilityIssued>(v8);
    }

    entry fun issue_governance_cap(arg0: &SuperAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GovernanceCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<GovernanceCap>(v0, arg1);
        let v1 = CapabilityIssued{
            cap_type  : b"GovernanceCap",
            recipient : arg1,
        };
        0x2::event::emit<CapabilityIssued>(v1);
    }

    entry fun issue_staking_cap(arg0: &SuperAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingManagerCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<StakingManagerCap>(v0, arg1);
        let v1 = CapabilityIssued{
            cap_type  : b"StakingManagerCap",
            recipient : arg1,
        };
        0x2::event::emit<CapabilityIssued>(v1);
    }

    entry fun issue_treasury_cap(arg0: &SuperAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryManagerCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<TreasuryManagerCap>(v0, arg1);
        let v1 = CapabilityIssued{
            cap_type  : b"TreasuryManagerCap",
            recipient : arg1,
        };
        0x2::event::emit<CapabilityIssued>(v1);
    }

    // decompiled from Move bytecode v6
}

