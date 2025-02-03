module 0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::set_fee {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    struct SetFee {
        amount: u64,
    }

    public fun set_fee(arg0: &mut 0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::state::State, arg1: 0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::governance_message::DecreeReceipt<GovernanceWitness>) : u64 {
        let v0 = 0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::state::assert_latest_only(arg0);
        let SetFee { amount: v1 } = deserialize(0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::governance_message::take_payload<GovernanceWitness>(0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::state::borrow_mut_consumed_vaas(&v0, arg0), arg1));
        0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::state::set_message_fee(&v0, arg0, v1);
        v1
    }

    public fun authorize_governance(arg0: &0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::state::State) : 0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::governance_message::DecreeTicket<GovernanceWitness> {
        let v0 = GovernanceWitness{dummy_field: false};
        0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::governance_message::authorize_verify_local<GovernanceWitness>(v0, 0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::state::governance_chain(arg0), 0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::state::governance_contract(arg0), 0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::state::governance_module(), 3)
    }

    fun deserialize(arg0: vector<u8>) : SetFee {
        let v0 = 0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::cursor::new<u8>(arg0);
        0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::cursor::destroy_empty<u8>(v0);
        SetFee{amount: (0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::bytes32::to_u64_be(0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::bytes32::take_bytes(&mut v0)) as u64)}
    }

    // decompiled from Move bytecode v6
}

