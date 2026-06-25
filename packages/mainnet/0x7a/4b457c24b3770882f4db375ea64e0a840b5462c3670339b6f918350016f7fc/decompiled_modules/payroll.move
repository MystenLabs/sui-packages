module 0x7a4b457c24b3770882f4db375ea64e0a840b5462c3670339b6f918350016f7fc::payroll {
    struct Member has copy, drop, store {
        recipient: address,
        amount_micro: u64,
        label: 0x1::string::String,
    }

    struct Team has key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        members: vector<Member>,
        seq: u64,
    }

    struct TeamCreated has copy, drop {
        team_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        count: u64,
    }

    struct TeamUpdated has copy, drop {
        team_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        count: u64,
        seq: u64,
    }

    struct TeamDeleted has copy, drop {
        team_id: 0x2::object::ID,
        owner: address,
    }

    public fun delete(arg0: Team, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 800);
        let Team {
            id      : v0,
            owner   : _,
            name    : _,
            members : _,
            seq     : _,
        } = arg0;
        0x2::object::delete(v0);
        let v5 = TeamDeleted{
            team_id : 0x2::object::id<Team>(&arg0),
            owner   : arg0.owner,
        };
        0x2::event::emit<TeamDeleted>(v5);
    }

    fun build_members(arg0: vector<address>, arg1: vector<u64>, arg2: vector<0x1::string::String>) : vector<Member> {
        let v0 = 0x1::vector::length<address>(&arg0);
        assert!(v0 == 0x1::vector::length<u64>(&arg1), 801);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg2), 801);
        assert!(v0 <= 256, 802);
        let v1 = 0x1::vector::empty<Member>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = Member{
                recipient    : *0x1::vector::borrow<address>(&arg0, v2),
                amount_micro : *0x1::vector::borrow<u64>(&arg1, v2),
                label        : *0x1::vector::borrow<0x1::string::String>(&arg2, v2),
            };
            0x1::vector::push_back<Member>(&mut v1, v3);
            v2 = v2 + 1;
        };
        v1
    }

    public fun create(arg0: 0x1::string::String, arg1: vector<address>, arg2: vector<u64>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = build_members(arg1, arg2, arg3);
        let v1 = Team{
            id      : 0x2::object::new(arg4),
            owner   : 0x2::tx_context::sender(arg4),
            name    : arg0,
            members : v0,
            seq     : 0,
        };
        let v2 = 0x2::object::id<Team>(&v1);
        let v3 = TeamCreated{
            team_id : v2,
            owner   : v1.owner,
            name    : v1.name,
            count   : 0x1::vector::length<Member>(&v0),
        };
        0x2::event::emit<TeamCreated>(v3);
        0x2::transfer::share_object<Team>(v1);
        v2
    }

    public fun member_at(arg0: &Team, arg1: u64) : (address, u64, 0x1::string::String) {
        let v0 = 0x1::vector::borrow<Member>(&arg0.members, arg1);
        (v0.recipient, v0.amount_micro, v0.label)
    }

    public fun name(arg0: &Team) : 0x1::string::String {
        arg0.name
    }

    public fun owner(arg0: &Team) : address {
        arg0.owner
    }

    public fun seq(arg0: &Team) : u64 {
        arg0.seq
    }

    public fun set_roster(arg0: &mut Team, arg1: 0x1::string::String, arg2: vector<address>, arg3: vector<u64>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 800);
        let v0 = build_members(arg2, arg3, arg4);
        arg0.name = arg1;
        arg0.members = v0;
        arg0.seq = arg0.seq + 1;
        let v1 = TeamUpdated{
            team_id : 0x2::object::id<Team>(arg0),
            owner   : arg0.owner,
            name    : arg0.name,
            count   : 0x1::vector::length<Member>(&v0),
            seq     : arg0.seq,
        };
        0x2::event::emit<TeamUpdated>(v1);
    }

    public fun size(arg0: &Team) : u64 {
        0x1::vector::length<Member>(&arg0.members)
    }

    // decompiled from Move bytecode v7
}

