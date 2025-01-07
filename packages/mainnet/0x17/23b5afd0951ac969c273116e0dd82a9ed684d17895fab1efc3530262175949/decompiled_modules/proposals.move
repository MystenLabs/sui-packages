module 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::proposals {
    struct Proposal<phantom T0: drop, T1: drop + store> has store {
        key: 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::roles::Role<T0>,
        value: 0x1::option::Option<T1>,
        proposer: address,
        proposal_timestamp_ms: u64,
    }

    struct ProposalsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Proposals has store {
        proposals: 0x2::bag::Bag,
        seq_num: u64,
    }

    public(friend) fun add<T0: drop, T1: drop + store>(arg0: &mut Proposals, arg1: Proposal<T0, T1>) {
        0x2::bag::add<u64, Proposal<T0, T1>>(&mut arg0.proposals, arg0.seq_num, arg1);
        arg0.seq_num = arg0.seq_num + 1;
    }

    public(friend) fun new<T0: drop, T1: drop + store>(arg0: 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::roles::Role<T0>, arg1: 0x1::option::Option<T1>, arg2: address, arg3: u64) : Proposal<T0, T1> {
        Proposal<T0, T1>{
            key                   : arg0,
            value                 : arg1,
            proposer              : arg2,
            proposal_timestamp_ms : arg3,
        }
    }

    public(friend) fun remove<T0: drop, T1: drop + store>(arg0: &mut Proposals, arg1: u64) : Proposal<T0, T1> {
        assert!(0x2::bag::contains<u64>(&arg0.proposals, arg1), 1);
        0x2::bag::remove<u64, Proposal<T0, T1>>(&mut arg0.proposals, arg1)
    }

    public(friend) fun active_proposals(arg0: &Proposals) : u64 {
        0x2::bag::length(&arg0.proposals)
    }

    public(friend) fun destroy<T0: drop, T1: drop + store>(arg0: Proposal<T0, T1>) : (0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::roles::Role<T0>, 0x1::option::Option<T1>) {
        let Proposal {
            key                   : v0,
            value                 : v1,
            proposer              : _,
            proposal_timestamp_ms : _,
        } = arg0;
        (v0, v1)
    }

    public(friend) fun key() : ProposalsKey {
        ProposalsKey{dummy_field: false}
    }

    public(friend) fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : Proposals {
        Proposals{
            proposals : 0x2::bag::new(arg0),
            seq_num   : 0,
        }
    }

    public(friend) fun proposer<T0: drop, T1: drop + store>(arg0: &Proposal<T0, T1>) : address {
        arg0.proposer
    }

    public(friend) fun timestamp_ms<T0: drop, T1: drop + store>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.proposal_timestamp_ms
    }

    // decompiled from Move bytecode v6
}

