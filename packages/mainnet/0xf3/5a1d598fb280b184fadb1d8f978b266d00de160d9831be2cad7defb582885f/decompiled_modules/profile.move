module 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile {
    struct Profile has copy, drop, store {
        shares: u64,
        states: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::UserState>,
        referrer: 0x1::option::Option<address>,
        referral_score: u64,
    }

    public(friend) fun add_score(arg0: &mut Profile) {
        arg0.referral_score = referral_score(arg0) + 1;
    }

    public(friend) fun add_shares(arg0: &mut Profile, arg1: u64) : u64 {
        let v0 = shares(arg0) + arg1;
        arg0.shares = v0;
        v0
    }

    public(friend) fun new(arg0: 0x1::option::Option<address>) : Profile {
        Profile{
            shares         : 0,
            states         : 0x2::vec_map::empty<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::UserState>(),
            referrer       : arg0,
            referral_score : 0,
        }
    }

    public fun referral_score(arg0: &Profile) : u64 {
        arg0.referral_score
    }

    public fun referrer(arg0: &Profile) : 0x1::option::Option<address> {
        arg0.referrer
    }

    public(friend) fun set_referrer(arg0: &mut Profile, arg1: address) {
        let v0 = referrer(arg0);
        if (0x1::option::is_none<address>(&v0)) {
            0x1::option::fill<address>(&mut arg0.referrer, arg1);
        };
    }

    public fun shares(arg0: &Profile) : u64 {
        arg0.shares
    }

    public fun states(arg0: &Profile) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::UserState> {
        &arg0.states
    }

    public(friend) fun states_mut(arg0: &mut Profile) : &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::UserState> {
        &mut arg0.states
    }

    // decompiled from Move bytecode v6
}

