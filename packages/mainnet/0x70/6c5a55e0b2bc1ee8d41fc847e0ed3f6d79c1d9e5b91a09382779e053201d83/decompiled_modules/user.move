module 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user {
    struct Invitation has store, key {
        id: 0x2::object::UID,
        invite_code: 0x1::string::String,
        invited_by: 0x1::option::Option<address>,
    }

    struct InviteCodeRegistry has key {
        id: 0x2::object::UID,
        invitations: 0x2::table::Table<0x1::string::String, address>,
        user_invite_counts: 0x2::table::Table<address, u64>,
    }

    struct UserRegisterEvent has copy, drop {
        user_address: address,
        invited_by: 0x1::option::Option<address>,
    }

    struct User has key {
        id: 0x2::object::UID,
        user_address: address,
        fish_encyclopedia: 0x2::table::Table<u64, vector<bool>>,
        total_fish_encyclopedia_activated: u64,
        purchased_divers: u64,
        purchased_aquariums: u64,
        purchased_aquarium_slots: u64,
        total_dive_token_burned: u64,
        total_aquariums_yielded: u64,
        total_fishes_obtained: u64,
        total_fishes_released: u64,
        invitation: Invitation,
        registered_at: u64,
    }

    public fun active_fish_encyclopedia_count(arg0: &User) : u64 {
        0x2::table::length<u64, vector<bool>>(&arg0.fish_encyclopedia)
    }

    public(friend) fun add_aquarium_yielded(arg0: &mut User, arg1: u64, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard) {
        arg0.total_aquariums_yielded = arg0.total_aquariums_yielded + arg1;
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::update_leaderboard_with_limit(arg2, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::get_enum_aquariums_yielded(), arg0.total_aquariums_yielded, arg0.total_aquariums_yielded, 0x2::object::id_from_address(arg0.user_address));
    }

    public(friend) fun add_dive_token_burned(arg0: &mut User, arg1: u64, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard) {
        arg0.total_dive_token_burned = arg0.total_dive_token_burned + arg1;
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::update_leaderboard_with_limit(arg2, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::get_enum_dive_token_burned(), arg0.total_dive_token_burned, arg0.total_dive_token_burned, 0x2::object::id_from_address(arg0.user_address));
    }

    public(friend) fun add_fishes_obtained(arg0: &mut User, arg1: u64, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard) {
        arg0.total_fishes_obtained = arg0.total_fishes_obtained + arg1;
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::update_leaderboard_with_limit(arg2, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::get_enum_fishes_obtained(), arg0.total_fishes_obtained, arg0.total_fishes_obtained, 0x2::object::id_from_address(arg0.user_address));
    }

    public(friend) fun add_fishes_released(arg0: &mut User, arg1: u64, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard) {
        arg0.total_fishes_released = arg0.total_fishes_released + arg1;
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::update_leaderboard_with_limit(arg2, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::get_enum_fishes_released(), arg0.total_fishes_released, arg0.total_fishes_released, 0x2::object::id_from_address(arg0.user_address));
    }

    public fun aquarium_count(arg0: &User) : u64 {
        arg0.purchased_aquariums
    }

    public fun aquarium_slot_count(arg0: &User) : u64 {
        arg0.purchased_aquarium_slots
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InviteCodeRegistry{
            id                 : 0x2::object::new(arg0),
            invitations        : 0x2::table::new<0x1::string::String, address>(arg0),
            user_invite_counts : 0x2::table::new<address, u64>(arg0),
        };
        0x2::table::add<0x1::string::String, address>(&mut v0.invitations, 0x1::string::utf8(b"suidiver"), 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<InviteCodeRegistry>(v0);
    }

    public(friend) fun purchase_aquarium(arg0: &mut User) {
        arg0.purchased_aquariums = arg0.purchased_aquariums + 1;
    }

    public(friend) fun purchase_aquarium_slot(arg0: &mut User, arg1: u64) {
        arg0.purchased_aquarium_slots = arg0.purchased_aquarium_slots + arg1;
    }

    public(friend) fun purchase_divers(arg0: &mut User, arg1: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg2: u64) {
        arg0.purchased_divers = arg0.purchased_divers + arg2;
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::update_leaderboard_with_limit(arg1, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::get_enum_divers_purchased(), arg0.purchased_divers, arg0.purchased_divers, 0x2::object::id_from_address(arg0.user_address));
    }

    entry fun register(arg0: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg1: &mut InviteCodeRegistry, arg2: 0x1::option::Option<0x1::string::String>, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::is_user_registered(arg0, v0), 2);
        let v1 = if (0x1::option::is_some<0x1::string::String>(&arg2)) {
            let v2 = 0x1::option::borrow<0x1::string::String>(&arg2);
            assert!(0x2::table::contains<0x1::string::String, address>(&arg1.invitations, *v2), 1);
            let v3 = *0x2::table::borrow<0x1::string::String, address>(&arg1.invitations, *v2);
            if (!0x2::table::contains<address, u64>(&arg1.user_invite_counts, v3)) {
                0x2::table::add<address, u64>(&mut arg1.user_invite_counts, v3, 0);
            };
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg1.user_invite_counts, v3);
            *v4 = *v4 + 1;
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::update_leaderboard_with_limit(arg3, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::get_enum_invite_count(), *v4, *v4, 0x2::object::id_from_address(v3));
            0x1::option::some<address>(*0x2::table::borrow<0x1::string::String, address>(&arg1.invitations, *v2))
        } else {
            0x1::option::none<address>()
        };
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::register_user(arg0, v0);
        let v5 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::enum_total_users();
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::increment_global_counter_stats(arg0, &v5, 1);
        let v6 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::generate_unique_invite_code(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::registered_users_count(arg0), arg4, arg5);
        0x2::table::add<0x1::string::String, address>(&mut arg1.invitations, v6, v0);
        let v7 = Invitation{
            id          : 0x2::object::new(arg5),
            invite_code : v6,
            invited_by  : v1,
        };
        let v8 = User{
            id                                : 0x2::object::new(arg5),
            user_address                      : v0,
            fish_encyclopedia                 : 0x2::table::new<u64, vector<bool>>(arg5),
            total_fish_encyclopedia_activated : 0,
            purchased_divers                  : 0,
            purchased_aquariums               : 0,
            purchased_aquarium_slots          : 0,
            total_dive_token_burned           : 0,
            total_aquariums_yielded           : 0,
            total_fishes_obtained             : 0,
            total_fishes_released             : 0,
            invitation                        : v7,
            registered_at                     : 0x2::clock::timestamp_ms(arg4),
        };
        let v9 = UserRegisterEvent{
            user_address : v0,
            invited_by   : v1,
        };
        0x2::event::emit<UserRegisterEvent>(v9);
        0x2::transfer::transfer<User>(v8, v0);
    }

    public fun total_fish_encyclopedia_activated(arg0: &User) : u64 {
        arg0.total_fish_encyclopedia_activated
    }

    public(friend) fun user_active_fish_encyclopedia(arg0: &mut User, arg1: u64, arg2: u64, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard) {
        assert!(arg2 < (0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_fish_size_count() as u64), 3);
        let v0 = &mut arg0.fish_encyclopedia;
        if (!0x2::table::contains<u64, vector<bool>>(v0, arg1)) {
            let v1 = 0x1::vector::empty<bool>();
            let v2 = 0;
            while (v2 < (0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_fish_size_count() as u64)) {
                0x1::vector::push_back<bool>(&mut v1, false);
                v2 = v2 + 1;
            };
            *0x1::vector::borrow_mut<bool>(&mut v1, arg2) = true;
            0x2::table::add<u64, vector<bool>>(v0, arg1, v1);
        } else {
            let v3 = 0x2::table::borrow_mut<u64, vector<bool>>(v0, arg1);
            assert!(!*0x1::vector::borrow<bool>(v3, arg2), 0);
            *0x1::vector::borrow_mut<bool>(v3, arg2) = true;
        };
        arg0.total_fish_encyclopedia_activated = arg0.total_fish_encyclopedia_activated + 1;
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::update_leaderboard_with_limit(arg3, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::get_enum_fish_encyclopedia_activated(), arg0.total_fish_encyclopedia_activated, arg0.total_fish_encyclopedia_activated, 0x2::object::id_from_address(arg0.user_address));
    }

    public fun user_address(arg0: &User) : address {
        arg0.user_address
    }

    public fun user_fish_encyclopedia(arg0: &User) : &0x2::table::Table<u64, vector<bool>> {
        &arg0.fish_encyclopedia
    }

    public fun user_invite_code(arg0: &User) : 0x1::string::String {
        arg0.invitation.invite_code
    }

    public fun user_invitees(arg0: address, arg1: &InviteCodeRegistry) : u64 {
        if (0x2::table::contains<address, u64>(&arg1.user_invite_counts, arg0)) {
            *0x2::table::borrow<address, u64>(&arg1.user_invite_counts, arg0)
        } else {
            0
        }
    }

    public fun user_inviter(arg0: &User) : 0x1::option::Option<address> {
        arg0.invitation.invited_by
    }

    // decompiled from Move bytecode v6
}

