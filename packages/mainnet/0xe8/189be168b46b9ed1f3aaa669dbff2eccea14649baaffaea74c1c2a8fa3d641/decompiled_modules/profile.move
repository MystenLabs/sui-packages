module 0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::profile {
    struct PROFILE has drop {
        dummy_field: bool,
    }

    struct MemberReg has key {
        id: 0x2::object::UID,
        registry: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct ProfileEligibility<phantom T0> has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<T0>,
    }

    struct Profile<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
    }

    public fun apply_eligibility<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 1);
        let v0 = ProfileEligibility<T0>{
            id     : 0x2::object::new(arg1),
            supply : 0x2::balance::create_supply<T0>(arg0),
        };
        0x2::transfer::transfer<ProfileEligibility<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: PROFILE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MemberReg{
            id       : 0x2::object::new(arg1),
            registry : 0x2::table::new<address, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<MemberReg>(v0);
        0x2::package::claim_and_keep<PROFILE>(arg0, arg1);
    }

    public fun owner<T0>(arg0: &Profile<T0>) : address {
        arg0.owner
    }

    public fun register<T0>(arg0: &mut MemberReg, arg1: ProfileEligibility<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.registry, v0), 8);
        let v1 = Profile<T0>{
            id    : 0x2::object::new(arg2),
            owner : v0,
        };
        let ProfileEligibility {
            id     : v2,
            supply : v3,
        } = arg1;
        0x2::object::delete(v2);
        0x2::transfer::transfer<Profile<T0>>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::TokenCap<T0>>(0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::new<T0>(v3, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

