module 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::migrate {
    struct MigrateComplete has copy, drop {
        package: 0x2::object::ID,
    }

    public fun migrate(arg0: &mut 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::migrate__v__0_2_0(arg0);
        handle_migrate(arg0, arg1, arg2);
    }

    fun handle_migrate(arg0: &mut 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::migrate_version(arg0);
        let v0 = 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::governance_message::verify_vaa<0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::upgrade_contract::GovernanceWitness>(arg0, 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::vaa::parse_and_verify(arg0, arg1, arg2), 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::upgrade_contract::authorize_governance(arg0));
        let v1 = 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::assert_latest_only(arg0);
        0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::assert_authorized_digest(&v1, arg0, 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::upgrade_contract::take_digest(0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::governance_message::payload<0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::upgrade_contract::GovernanceWitness>(&v0)));
        0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::governance_message::destroy<0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::upgrade_contract::GovernanceWitness>(v0);
        let v2 = MigrateComplete{package: 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::state::current_package(&v1, arg0)};
        0x2::event::emit<MigrateComplete>(v2);
    }

    // decompiled from Move bytecode v6
}

