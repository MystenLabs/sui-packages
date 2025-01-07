module 0x3fef274ab2363f7bb99b937bc303299e59d5330066416cf61fa2e3f7d99fad70::participant {
    struct Participant has store, key {
        id: 0x2::object::UID,
        users: vector<address>,
        index_amount: vector<u64>,
        index_joined_at: vector<u64>,
        total_amount: u64,
        total_user: u32,
    }

    public(friend) fun add(arg0: &mut Participant, arg1: address, arg2: u64, arg3: u64) {
        if (!0x1::vector::contains<address>(&arg0.users, &arg1)) {
            arg0.total_user = arg0.total_user + 1;
        };
        0x1::vector::push_back<address>(&mut arg0.users, arg1);
        0x1::vector::push_back<u64>(&mut arg0.index_amount, arg2);
        0x1::vector::push_back<u64>(&mut arg0.index_joined_at, arg3);
        arg0.total_amount = arg0.total_amount + arg2;
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : Participant {
        Participant{
            id              : 0x2::object::new(arg0),
            users           : 0x1::vector::empty<address>(),
            index_amount    : 0x1::vector::empty<u64>(),
            index_joined_at : 0x1::vector::empty<u64>(),
            total_amount    : 0,
            total_user      : 0,
        }
    }

    public(friend) fun get_probs_in_bps(arg0: &Participant, arg1: u64) : vector<u32> {
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 0;
        while (v1 < arg0.total_user) {
            0x1::vector::push_back<u32>(&mut v0, 0x3fef274ab2363f7bb99b937bc303299e59d5330066416cf61fa2e3f7d99fad70::utils::get_prob_bps(arg0.total_amount, *0x1::vector::borrow<u64>(&arg0.index_amount, (v1 as u64)), arg1, *0x1::vector::borrow<u64>(&arg0.index_joined_at, (v1 as u64))));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

