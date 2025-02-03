module 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::migrate {
    struct MigrateComplete has copy, drop {
        package: 0x2::object::ID,
    }

    public fun migrate(arg0: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::DecreeReceipt<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::GovernanceWitness>) {
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::migrate__v__0_1_1(arg0);
        handle_migrate(arg0, arg1);
    }

    fun handle_migrate(arg0: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::DecreeReceipt<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::GovernanceWitness>) {
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::migrate_version(arg0);
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::assert_latest_only(arg0);
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::assert_authorized_digest(&v0, arg0, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::contract_upgrade::take_digest(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::payload<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::GovernanceWitness>(&arg1)));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::destroy<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::GovernanceWitness>(arg1);
        let v1 = MigrateComplete{package: 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::current_package(&v0, arg0)};
        0x2::event::emit<MigrateComplete>(v1);
    }

    // decompiled from Move bytecode v6
}

