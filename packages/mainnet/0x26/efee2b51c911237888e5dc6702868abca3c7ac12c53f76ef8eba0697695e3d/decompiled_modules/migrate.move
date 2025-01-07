module 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::migrate {
    struct MigrateComplete has copy, drop {
        package: 0x2::object::ID,
    }

    public fun migrate(arg0: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::DecreeReceipt<0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::upgrade_contract::GovernanceWitness>) {
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::migrate__v__0_2_0(arg0);
        handle_migrate(arg0, arg1);
    }

    fun handle_migrate(arg0: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::DecreeReceipt<0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::upgrade_contract::GovernanceWitness>) {
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::migrate_version(arg0);
        let v0 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::assert_latest_only(arg0);
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::assert_authorized_digest(&v0, arg0, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::upgrade_contract::take_digest(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::payload<0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::upgrade_contract::GovernanceWitness>(&arg1)));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::destroy<0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::upgrade_contract::GovernanceWitness>(arg1);
        let v1 = MigrateComplete{package: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::current_package(&v0, arg0)};
        0x2::event::emit<MigrateComplete>(v1);
    }

    // decompiled from Move bytecode v6
}

