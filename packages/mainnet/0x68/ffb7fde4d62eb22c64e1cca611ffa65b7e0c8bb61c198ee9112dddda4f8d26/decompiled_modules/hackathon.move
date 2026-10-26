module 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::hackathon {
    struct HackathonKey has copy, drop, store {
        name: 0x1::string::String,
    }

    struct Hackathon has key {
        id: 0x2::object::UID,
        creator: address,
        company_id: 0x2::object::ID,
        teams: vector<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>,
        winner: 0x1::option::Option<u64>,
        name: 0x1::string::String,
        description: 0x1::string::String,
        awards: vector<0x1::string::String>,
        start_date: u64,
        end_date: u64,
        location: 0x1::string::String,
        recap_url: 0x1::string::String,
        url: 0x2::url::Url,
        pin_url: 0x2::url::Url,
        format: 0x1::string::String,
    }

    public fun url(arg0: &Hackathon) : &0x2::url::Url {
        &arg0.url
    }

    public fun add_participant(arg0: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::Version, arg1: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company, arg2: &mut Hackathon, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::check_is_valid(arg0);
        assert!(arg2.company_id == 0x2::object::id<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company>(arg1), 4);
        if (!0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::is_admin(arg1, 0x2::tx_context::sender(arg6))) {
            assert_open(arg2, arg5);
        };
        assert!(arg3 < 0x1::vector::length<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&arg2.teams), 6);
        assert!(0x1::option::is_none<u64>(&arg2.winner) || *0x1::option::borrow<u64>(&arg2.winner) != arg3, 10);
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::add_participant(arg1, 0x1::vector::borrow_mut<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&mut arg2.teams, arg3), arg4, arg6);
    }

    public fun add_team(arg0: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::Version, arg1: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company, arg2: &mut Hackathon, arg3: 0x1::string::String, arg4: vector<address>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : u64 {
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::check_is_valid(arg0);
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::assert_admin(arg1, arg6);
        assert!(arg2.company_id == 0x2::object::id<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company>(arg1), 4);
        if (!0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::is_admin(arg1, 0x2::tx_context::sender(arg6))) {
            assert_open(arg2, arg5);
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&arg2.teams)) {
            assert!(0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::team_title(0x1::vector::borrow<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&arg2.teams, v0)) != &arg3, 3);
            v0 = v0 + 1;
        };
        0x1::vector::push_back<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&mut arg2.teams, 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::new(arg1, arg3, arg4, arg6));
        0x1::vector::length<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&arg2.teams)
    }

    fun assert_open(arg0: &Hackathon, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.end_date, 5);
    }

    public fun awards(arg0: &Hackathon) : &vector<0x1::string::String> {
        &arg0.awards
    }

    public fun company_id(arg0: &Hackathon) : 0x2::object::ID {
        arg0.company_id
    }

    public fun create_hackathon(arg0: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::Version, arg1: &mut 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<u8>, arg10: vector<u8>, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::check_is_valid(arg0);
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::assert_admin_or_lead(arg1, arg12);
        assert!(arg5 < arg6, 1);
        let v0 = HackathonKey{name: arg2};
        let v1 = Hackathon{
            id          : 0x2::derived_object::claim<HackathonKey>(0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::uid_mut(arg1), v0),
            creator     : 0x2::tx_context::sender(arg12),
            company_id  : 0x2::object::id<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company>(arg1),
            teams       : 0x1::vector::empty<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(),
            winner      : 0x1::option::none<u64>(),
            name        : arg2,
            description : arg3,
            awards      : arg4,
            start_date  : arg5,
            end_date    : arg6,
            location    : arg7,
            recap_url   : arg8,
            url         : 0x2::url::new_unsafe_from_bytes(arg9),
            pin_url     : 0x2::url::new_unsafe_from_bytes(arg10),
            format      : arg11,
        };
        0x2::transfer::share_object<Hackathon>(v1);
        0x2::object::id<Hackathon>(&v1)
    }

    public fun description(arg0: &Hackathon) : &0x1::string::String {
        &arg0.description
    }

    public fun end_date(arg0: &Hackathon) : u64 {
        arg0.end_date
    }

    public fun format(arg0: &Hackathon) : &0x1::string::String {
        &arg0.format
    }

    public fun location(arg0: &Hackathon) : &0x1::string::String {
        &arg0.location
    }

    public fun name(arg0: &Hackathon) : &0x1::string::String {
        &arg0.name
    }

    public fun pin_url(arg0: &Hackathon) : &0x2::url::Url {
        &arg0.pin_url
    }

    public fun recap_url(arg0: &Hackathon) : &0x1::string::String {
        &arg0.recap_url
    }

    public fun set_recap_url(arg0: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::Version, arg1: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company, arg2: &mut Hackathon, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::check_is_valid(arg0);
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::assert_admin(arg1, arg4);
        assert!(arg2.company_id == 0x2::object::id<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company>(arg1), 4);
        arg2.recap_url = arg3;
    }

    public fun set_winner(arg0: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::Version, arg1: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company, arg2: &mut Hackathon, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::check_is_valid(arg0);
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::assert_admin(arg1, arg5);
        assert!(arg2.company_id == 0x2::object::id<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company>(arg1), 4);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg2.end_date, 7);
        assert!(0x1::option::is_none<u64>(&arg2.winner), 9);
        assert!(arg3 < 0x1::vector::length<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&arg2.teams), 6);
        arg2.winner = 0x1::option::some<u64>(arg3);
        let v0 = 0x1::string::utf8(b"Winner of ");
        0x1::string::append(&mut v0, arg2.name);
        let v1 = 0x1::string::utf8(b"Bragging rights as the winner of ");
        0x1::string::append(&mut v1, arg2.name);
        let v2 = 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::participants(0x1::vector::borrow<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&arg2.teams, arg3));
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(v2)) {
            0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::enzo_nft::mint(arg0, arg1, *0x1::vector::borrow<address>(v2, v3), v0, v1, 0x1::ascii::into_bytes(0x2::url::inner_url(&arg2.pin_url)), arg5);
            v3 = v3 + 1;
        };
    }

    public fun start_date(arg0: &Hackathon) : u64 {
        arg0.start_date
    }

    public fun teams(arg0: &Hackathon) : &vector<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team> {
        &arg0.teams
    }

    public fun update_hackathon(arg0: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::Version, arg1: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company, arg2: &mut Hackathon, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<u8>, arg11: vector<u8>, arg12: 0x1::string::String, arg13: &0x2::clock::Clock, arg14: &0x2::tx_context::TxContext) {
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::check_is_valid(arg0);
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::assert_admin(arg1, arg14);
        assert!(arg2.company_id == 0x2::object::id<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company>(arg1), 4);
        assert!(arg6 < arg7, 1);
        if (arg6 != arg2.start_date || arg7 != arg2.end_date) {
            assert_open(arg2, arg13);
        };
        arg2.name = arg3;
        arg2.description = arg4;
        arg2.awards = arg5;
        arg2.start_date = arg6;
        arg2.end_date = arg7;
        arg2.location = arg8;
        arg2.recap_url = arg9;
        arg2.url = 0x2::url::new_unsafe_from_bytes(arg10);
        arg2.pin_url = 0x2::url::new_unsafe_from_bytes(arg11);
        arg2.format = arg12;
    }

    public fun update_team(arg0: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::Version, arg1: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company, arg2: &mut Hackathon, arg3: u64, arg4: 0x1::string::String, arg5: vector<address>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::check_is_valid(arg0);
        assert!(arg2.company_id == 0x2::object::id<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company>(arg1), 4);
        if (!0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::is_admin(arg1, 0x2::tx_context::sender(arg7))) {
            assert_open(arg2, arg6);
        };
        assert!(arg3 < 0x1::vector::length<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&arg2.teams), 6);
        assert!(0x1::option::is_none<u64>(&arg2.winner) || *0x1::option::borrow<u64>(&arg2.winner) != arg3, 10);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&arg2.teams)) {
            if (v0 != arg3) {
                assert!(0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::team_title(0x1::vector::borrow<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&arg2.teams, v0)) != &arg4, 3);
            };
            v0 = v0 + 1;
        };
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::update(arg1, 0x1::vector::borrow_mut<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&mut arg2.teams, arg3), arg4, arg5, arg7);
    }

    public fun update_team_profile(arg0: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::Version, arg1: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company, arg2: &mut Hackathon, arg3: u64, arg4: 0x1::string::String, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::check_is_valid(arg0);
        assert!(arg2.company_id == 0x2::object::id<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company>(arg1), 4);
        if (!0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::is_admin(arg1, 0x2::tx_context::sender(arg7))) {
            assert_open(arg2, arg6);
        };
        assert!(arg3 < 0x1::vector::length<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&arg2.teams), 6);
        assert!(0x1::option::is_none<u64>(&arg2.winner) || *0x1::option::borrow<u64>(&arg2.winner) != arg3, 10);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&arg2.teams)) {
            if (v0 != arg3) {
                assert!(0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::team_title(0x1::vector::borrow<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&arg2.teams, v0)) != &arg4, 3);
            };
            v0 = v0 + 1;
        };
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::update_profile(arg1, 0x1::vector::borrow_mut<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&mut arg2.teams, arg3), arg4, arg5, arg7);
    }

    public fun update_team_url(arg0: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::Version, arg1: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company, arg2: &mut Hackathon, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::check_is_valid(arg0);
        assert!(arg2.company_id == 0x2::object::id<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company>(arg1), 4);
        if (!0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::is_admin(arg1, 0x2::tx_context::sender(arg6))) {
            assert_open(arg2, arg5);
        };
        assert!(arg3 < 0x1::vector::length<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&arg2.teams), 6);
        assert!(0x1::option::is_none<u64>(&arg2.winner) || *0x1::option::borrow<u64>(&arg2.winner) != arg3, 10);
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::update_url(arg1, 0x1::vector::borrow_mut<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&mut arg2.teams, arg3), arg4, arg6);
    }

    public fun winner(arg0: &Hackathon) : &0x1::option::Option<u64> {
        &arg0.winner
    }

    public fun winning_team(arg0: &Hackathon) : &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team {
        assert!(0x1::option::is_some<u64>(&arg0.winner), 8);
        0x1::vector::borrow<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::team::Team>(&arg0.teams, *0x1::option::borrow<u64>(&arg0.winner))
    }

    // decompiled from Move bytecode v7
}

