module 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::update_guardian_set {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    struct GuardianSetAdded has copy, drop {
        new_index: u32,
    }

    struct UpdateGuardianSet {
        new_index: u32,
        guardians: vector<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian::Guardian>,
    }

    public fun update_guardian_set(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::DecreeReceipt<GovernanceWitness>, arg2: &0x2::clock::Clock) : u32 {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::assert_latest_only(arg0);
        let v1 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::take_payload<GovernanceWitness>(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::borrow_mut_consumed_vaas(&v0, arg0), arg1);
        handle_update_guardian_set(&v0, arg0, v1, arg2)
    }

    public fun authorize_governance(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::DecreeTicket<GovernanceWitness> {
        let v0 = GovernanceWitness{dummy_field: false};
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::authorize_verify_global<GovernanceWitness>(v0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::governance_chain(arg0), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::governance_contract(arg0), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::governance_module(), 2)
    }

    fun deserialize(arg0: vector<u8>) : UpdateGuardianSet {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        let v1 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0);
        assert!(v1 > 0, 0);
        let v2 = 0x1::vector::empty<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian::Guardian>();
        let v3 = 0;
        while (v3 < v1) {
            0x1::vector::push_back<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian::Guardian>(&mut v2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 20)));
            v3 = v3 + 1;
        };
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        UpdateGuardianSet{
            new_index : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u32_be(&mut v0),
            guardians : v2,
        }
    }

    fun handle_update_guardian_set(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::LatestOnly, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: vector<u8>, arg3: &0x2::clock::Clock) : u32 {
        let UpdateGuardianSet {
            new_index : v0,
            guardians : v1,
        } = deserialize(arg2);
        assert!(v0 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::guardian_set_index(arg1) + 1, 1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::expire_guardian_set(arg0, arg1, arg3);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::add_new_guardian_set(arg0, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian_set::new(v0, v1));
        let v2 = GuardianSetAdded{new_index: v0};
        0x2::event::emit<GuardianSetAdded>(v2);
        v0
    }

    // decompiled from Move bytecode v6
}

