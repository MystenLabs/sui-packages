module 0xebe76b184cca65aea2880b30101d1bae3325fbd4f86b91e2b53195949331093b::sui_red_envelope {
    struct RedEnvelope<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        total_amount: u64,
        remaining_count: u64,
        total_count: u64,
        mode: u8,
        claimed_list: 0x2::table::Table<address, bool>,
    }

    struct EnvelopeCreated has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        amount: u64,
        count: u64,
        mode: u8,
    }

    struct EnvelopeClaimed has copy, drop {
        id: 0x2::object::ID,
        claimer: address,
        amount: u64,
    }

    entry fun claim_red_envelope<T0>(arg0: &mut RedEnvelope<T0>, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.remaining_count > 0, 2);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed_list, v0), 3);
        let v1 = if (arg0.remaining_count == 1) {
            0x2::balance::value<T0>(&arg0.balance)
        } else if (arg0.mode == 1) {
            0x2::balance::value<T0>(&arg0.balance) / arg0.remaining_count
        } else {
            let v2 = 0x2::balance::value<T0>(&arg0.balance);
            let v3 = v2 / arg0.remaining_count * 2;
            let v4 = v3;
            if (v3 >= v2) {
                v4 = v2 - arg0.remaining_count + 1;
            };
            let v5 = 0x2::random::new_generator(arg1, arg2);
            0x2::random::generate_u64_in_range(&mut v5, 1, v4)
        };
        arg0.remaining_count = arg0.remaining_count - 1;
        0x2::table::add<address, bool>(&mut arg0.claimed_list, v0, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v1, arg2), v0);
        let v6 = EnvelopeClaimed{
            id      : 0x2::object::id<RedEnvelope<T0>>(arg0),
            claimer : v0,
            amount  : v1,
        };
        0x2::event::emit<EnvelopeClaimed>(v6);
    }

    public entry fun create_red_envelope<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 0);
        assert!(arg1 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = RedEnvelope<T0>{
            id              : 0x2::object::new(arg3),
            owner           : v1,
            balance         : 0x2::coin::into_balance<T0>(arg0),
            total_amount    : v0,
            remaining_count : arg1,
            total_count     : arg1,
            mode            : arg2,
            claimed_list    : 0x2::table::new<address, bool>(arg3),
        };
        let v3 = EnvelopeCreated{
            id     : 0x2::object::id<RedEnvelope<T0>>(&v2),
            owner  : v1,
            amount : v0,
            count  : arg1,
            mode   : arg2,
        };
        0x2::event::emit<EnvelopeCreated>(v3);
        0x2::transfer::share_object<RedEnvelope<T0>>(v2);
    }

    public entry fun withdraw_remaining<T0>(arg0: &mut RedEnvelope<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 4);
        let v1 = 0x2::balance::value<T0>(&arg0.balance);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v1, arg1), v0);
        };
    }

    // decompiled from Move bytecode v6
}

