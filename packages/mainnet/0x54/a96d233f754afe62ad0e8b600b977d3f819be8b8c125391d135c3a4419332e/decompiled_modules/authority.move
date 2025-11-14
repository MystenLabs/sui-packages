module 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority {
    struct AUTHORITY has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
        cap: 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::GameCap,
        event_cap: 0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::EventCap,
        map_cap: 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapCap,
        crimes_cap: 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::CrimesCap,
        swap_cap: 0x7395b1aa27382bc96829269c7f557cd490dd31e953f6533cf10356da2942820b::swap::SwapCap,
        dvd_cap: 0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_authority::DVDCap,
    }

    struct Status has key {
        id: 0x2::object::UID,
        crimes_pause: bool,
        onboarding_pause: bool,
        battle_pause: bool,
    }

    struct GameMasterCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameOperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCapsBag has key {
        id: 0x2::object::UID,
        caps: 0x2::table::Table<0x2::object::ID, bool>,
    }

    entry fun add_cap<T0: store + key>(arg0: &GameMasterCap, arg1: &mut CapWrapper, arg2: 0x1::string::String, arg3: T0) {
        0x2::dynamic_field::add<0x1::string::String, T0>(&mut arg1.id, arg2, arg3);
    }

    entry fun add_game_cap(arg0: &GameMasterCap, arg1: 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::GameCap, arg2: 0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::EventCap, arg3: 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapCap, arg4: 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::CrimesCap, arg5: 0x7395b1aa27382bc96829269c7f557cd490dd31e953f6533cf10356da2942820b::swap::SwapCap, arg6: 0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_authority::DVDCap, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = CapWrapper{
            id         : 0x2::object::new(arg7),
            cap        : arg1,
            event_cap  : arg2,
            map_cap    : arg3,
            crimes_cap : arg4,
            swap_cap   : arg5,
            dvd_cap    : arg6,
        };
        0x2::transfer::share_object<CapWrapper>(v0);
    }

    public(friend) fun borrow_crimes_cap(arg0: &CapWrapper) : &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::CrimesCap {
        &arg0.crimes_cap
    }

    public(friend) fun borrow_df_cap<T0: store + key>(arg0: &CapWrapper, arg1: 0x1::string::String) : &T0 {
        0x2::dynamic_field::borrow<0x1::string::String, T0>(&arg0.id, arg1)
    }

    public(friend) fun borrow_dvd_cap(arg0: &CapWrapper) : &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_authority::DVDCap {
        &arg0.dvd_cap
    }

    public(friend) fun borrow_event_cap(arg0: &CapWrapper) : &0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::EventCap {
        &arg0.event_cap
    }

    public(friend) fun borrow_game_cap(arg0: &CapWrapper) : &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::GameCap {
        &arg0.cap
    }

    public(friend) fun borrow_map_cap(arg0: &CapWrapper) : &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapCap {
        &arg0.map_cap
    }

    public(friend) fun borrow_swap_cap(arg0: &CapWrapper) : &0x7395b1aa27382bc96829269c7f557cd490dd31e953f6533cf10356da2942820b::swap::SwapCap {
        &arg0.swap_cap
    }

    public(friend) fun is_operator(arg0: &GameOperatorCap, arg1: &OperatorCapsBag) {
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg1.caps, 0x2::object::id<GameOperatorCap>(arg0)), 1);
        assert!(*0x2::table::borrow<0x2::object::ID, bool>(&arg1.caps, 0x2::object::id<GameOperatorCap>(arg0)), 2);
    }

    public fun issue_operator_cap(arg0: &CapWrapper, arg1: &GameMasterCap, arg2: &mut OperatorCapsBag, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = GameOperatorCap{id: 0x2::object::new(arg5)};
        let v1 = 0x2::object::id<GameOperatorCap>(&v0);
        0x2::transfer::public_transfer<GameOperatorCap>(v0, arg3);
        0x2::table::add<0x2::object::ID, bool>(&mut arg2.caps, v1, true);
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_operator_cap_issued_event(borrow_event_cap(arg0), v1, 0x2::clock::timestamp_ms(arg4));
    }

    public fun revoke_operator_cap(arg0: &CapWrapper, arg1: &GameMasterCap, arg2: &mut OperatorCapsBag, arg3: &0x2::clock::Clock, arg4: 0x2::object::ID) {
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg2.caps, arg4), 0);
        *0x2::table::borrow_mut<0x2::object::ID, bool>(&mut arg2.caps, arg4) = false;
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_operator_cap_revoked_event(borrow_event_cap(arg0), arg4, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_status(arg0: &GameMasterCap, arg1: &mut Status, arg2: bool, arg3: bool, arg4: bool) {
        arg1.crimes_pause = arg2;
        arg1.onboarding_pause = arg3;
        arg1.battle_pause = arg4;
    }

    public(friend) fun validate_battle_status(arg0: &Status) {
        assert!(!arg0.battle_pause, 3);
    }

    public(friend) fun validate_crime_status(arg0: &Status) {
        assert!(!arg0.crimes_pause, 5);
    }

    public(friend) fun validate_onboarding_status(arg0: &Status) {
        assert!(!arg0.onboarding_pause, 4);
    }

    // decompiled from Move bytecode v6
}

