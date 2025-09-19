module 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::proposal {
    struct Proposal<T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        quorum_upgrade: 0x2::object::ID,
        votes: vector<address>,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        data: T0,
    }

    public(friend) fun delete<T0>(arg0: Proposal<T0>) : T0 {
        let Proposal {
            id             : v0,
            creator        : _,
            quorum_upgrade : _,
            votes          : _,
            metadata       : _,
            data           : v5,
        } = arg0;
        0x2::object::delete(v0);
        v5
    }

    public fun new<T0: store>(arg0: &0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade, arg1: T0, arg2: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::voters(arg0), &v0), 13906834367616909313);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, 0x2::tx_context::sender(arg3));
        let v2 = Proposal<T0>{
            id             : 0x2::object::new(arg3),
            creator        : 0x2::tx_context::sender(arg3),
            quorum_upgrade : 0x2::object::id<0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade>(arg0),
            votes          : v1,
            metadata       : arg2,
            data           : arg1,
        };
        0x2::transfer::share_object<Proposal<T0>>(v2);
    }

    public fun delete_by_creator<T0: drop>(arg0: Proposal<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 13906834603840372741);
        0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::events::emit_proposal_deleted_event(0x2::object::uid_to_inner(&arg0.id));
        delete<T0>(arg0);
    }

    public(friend) fun execute<T0>(arg0: Proposal<T0>, arg1: &0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade) : T0 {
        assert!(quorum_reached<T0>(&arg0, arg1), 13906834638200242183);
        assert!(arg0.quorum_upgrade == 0x2::object::id<0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade>(arg1), 13906834642495340553);
        0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::events::emit_proposal_executed_event(0x2::object::uid_to_inner(&arg0.id));
        delete<T0>(arg0)
    }

    public fun quorum_upgrade<T0>(arg0: &Proposal<T0>) : 0x2::object::ID {
        arg0.quorum_upgrade
    }

    public fun quorum_reached<T0>(arg0: &Proposal<T0>, arg1: &0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade) : bool {
        let v0 = 0;
        let v1 = arg0.votes;
        0x1::vector::reverse<address>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            let v3 = 0x1::vector::pop_back<address>(&mut v1);
            let v4 = if (0x2::vec_set::contains<address>(0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::voters(arg1), &v3)) {
                v0 + 1
            } else {
                v0
            };
            v0 = v4;
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<address>(v1);
        v0 >= 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::required_votes(arg1)
    }

    public fun remove_vote<T0>(arg0: &mut Proposal<T0>, arg1: &0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0;
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::voters(arg1), &v1), 13906834741279064065);
        assert!(v0.quorum_upgrade == 0x2::object::id<0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade>(arg1), 13906834745574555657);
        let v2 = 0x2::tx_context::sender(arg2);
        let (v3, v4) = 0x1::vector::index_of<address>(&arg0.votes, &v2);
        assert!(v3, 13906834526531354635);
        0x1::vector::remove<address>(&mut arg0.votes, v4);
        0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::events::emit_vote_removed_event(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg2));
    }

    public fun vote<T0>(arg0: &mut Proposal<T0>, arg1: &0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0;
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::voters(arg1), &v1), 13906834741279064065);
        assert!(v0.quorum_upgrade == 0x2::object::id<0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade>(arg1), 13906834745574555657);
        let v2 = 0x2::tx_context::sender(arg2);
        assert!(!0x1::vector::contains<address>(&arg0.votes, &v2), 13906834453516386307);
        0x1::vector::push_back<address>(&mut arg0.votes, 0x2::tx_context::sender(arg2));
        0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::events::emit_vote_cast_event(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg2));
        if (quorum_reached<T0>(arg0, arg1)) {
            0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::events::emit_quorum_reached_event(0x2::object::uid_to_inner(&arg0.id));
        };
    }

    public fun votes<T0>(arg0: &Proposal<T0>) : &vector<address> {
        &arg0.votes
    }

    // decompiled from Move bytecode v6
}

