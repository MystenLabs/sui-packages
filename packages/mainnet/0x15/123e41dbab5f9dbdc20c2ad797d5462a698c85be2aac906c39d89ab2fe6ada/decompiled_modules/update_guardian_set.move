module 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::update_guardian_set {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    struct GuardianSetAdded has copy, drop {
        new_index: u32,
    }

    struct UpdateGuardianSet {
        new_index: u32,
        guardians: vector<0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::guardian::Guardian>,
    }

    public fun update_guardian_set(arg0: &mut 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::State, arg1: 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::governance_message::DecreeReceipt<GovernanceWitness>, arg2: &0x2::clock::Clock) : u32 {
        let v0 = 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::assert_latest_only(arg0);
        let v1 = 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::governance_message::take_payload<GovernanceWitness>(0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::borrow_mut_consumed_vaas(&v0, arg0), arg1);
        handle_update_guardian_set(&v0, arg0, v1, arg2)
    }

    public fun authorize_governance(arg0: &0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::State) : 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::governance_message::DecreeTicket<GovernanceWitness> {
        let v0 = GovernanceWitness{dummy_field: false};
        0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::governance_message::authorize_verify_global<GovernanceWitness>(v0, 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::governance_chain(arg0), 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::governance_contract(arg0), 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::governance_module(), 2)
    }

    fun deserialize(arg0: vector<u8>) : UpdateGuardianSet {
        let v0 = 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::cursor::new<u8>(arg0);
        let v1 = 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::bytes::take_u8(&mut v0);
        assert!(v1 > 0, 0);
        let v2 = 0x1::vector::empty<0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::guardian::Guardian>();
        let v3 = 0;
        while (v3 < v1) {
            0x1::vector::push_back<0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::guardian::Guardian>(&mut v2, 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::guardian::new(0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::bytes::take_bytes(&mut v0, 20)));
            v3 = v3 + 1;
        };
        0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::cursor::destroy_empty<u8>(v0);
        UpdateGuardianSet{
            new_index : 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::bytes::take_u32_be(&mut v0),
            guardians : v2,
        }
    }

    fun handle_update_guardian_set(arg0: &0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::LatestOnly, arg1: &mut 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::State, arg2: vector<u8>, arg3: &0x2::clock::Clock) : u32 {
        let UpdateGuardianSet {
            new_index : v0,
            guardians : v1,
        } = deserialize(arg2);
        assert!(v0 == 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::guardian_set_index(arg1) + 1, 1);
        0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::expire_guardian_set(arg0, arg1, arg3);
        0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::add_new_guardian_set(arg0, arg1, 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::guardian_set::new(v0, v1));
        let v2 = GuardianSetAdded{new_index: v0};
        0x2::event::emit<GuardianSetAdded>(v2);
        v0
    }

    // decompiled from Move bytecode v6
}

