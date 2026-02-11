module 0xc56f89b4d7d0ae35a01067cd0c15cb6e823b9dd78721069a612e5432f195a021::sui_red_envelope {
    struct Registry has key {
        id: 0x2::object::UID,
        admin: address,
        public_key: vector<u8>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EnvelopeCreated<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        amount: u64,
        count: u64,
        mode: u8,
        requires_verification: bool,
    }

    struct EnvelopeClaimed has copy, drop {
        id: 0x2::object::ID,
        claimer: address,
        amount: u64,
    }

    struct RedEnvelope<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        total_amount: u64,
        remaining_count: u64,
        total_count: u64,
        mode: u8,
        requires_verification: bool,
        claimed_list: 0x2::table::Table<address, bool>,
    }

    entry fun claim_red_envelope<T0>(arg0: &mut RedEnvelope<T0>, arg1: &Registry, arg2: &0x2::random::Random, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        if (arg0.requires_verification) {
            let v1 = 0x2::object::id_bytes<RedEnvelope<T0>>(arg0);
            0x1::vector::append<u8>(&mut v1, 0x2::address::to_bytes(v0));
            assert!(0x2::ed25519::ed25519_verify(&arg3, &arg1.public_key, &v1), 5);
        };
        assert!(arg0.remaining_count > 0, 2);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed_list, v0), 3);
        let v2 = if (arg0.remaining_count == 1) {
            0x2::balance::value<T0>(&arg0.balance)
        } else if (arg0.mode == 1) {
            0x2::balance::value<T0>(&arg0.balance) / arg0.remaining_count
        } else {
            let v3 = 0x2::balance::value<T0>(&arg0.balance);
            let v4 = v3 / arg0.remaining_count * 2;
            let v5 = v4;
            if (v4 >= v3) {
                v5 = v3 - arg0.remaining_count + 1;
            };
            let v6 = 0x2::random::new_generator(arg2, arg4);
            0x2::random::generate_u64_in_range(&mut v6, 1, v5)
        };
        arg0.remaining_count = arg0.remaining_count - 1;
        0x2::table::add<address, bool>(&mut arg0.claimed_list, v0, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v2, arg4), v0);
        let v7 = EnvelopeClaimed{
            id      : 0x2::object::id<RedEnvelope<T0>>(arg0),
            claimer : v0,
            amount  : v2,
        };
        0x2::event::emit<EnvelopeClaimed>(v7);
    }

    public entry fun create_red_envelope<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u8, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 0);
        assert!(arg1 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = RedEnvelope<T0>{
            id                    : 0x2::object::new(arg4),
            owner                 : v1,
            balance               : 0x2::coin::into_balance<T0>(arg0),
            total_amount          : v0,
            remaining_count       : arg1,
            total_count           : arg1,
            mode                  : arg2,
            requires_verification : arg3,
            claimed_list          : 0x2::table::new<address, bool>(arg4),
        };
        let v3 = EnvelopeCreated<T0>{
            id                    : 0x2::object::id<RedEnvelope<T0>>(&v2),
            owner                 : v1,
            amount                : v0,
            count                 : arg1,
            mode                  : arg2,
            requires_verification : arg3,
        };
        0x2::event::emit<EnvelopeCreated<T0>>(v3);
        0x2::transfer::share_object<RedEnvelope<T0>>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Registry{
            id         : 0x2::object::new(arg0),
            admin      : v0,
            public_key : b"placeholder_pubkey_replace_with_real_one",
        };
        0x2::transfer::share_object<Registry>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public entry fun update_public_key(arg0: &AdminCap, arg1: &mut Registry, arg2: vector<u8>) {
        arg1.public_key = arg2;
    }

    public entry fun withdraw_remaining<T0>(arg0: &mut RedEnvelope<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 4);
        arg0.remaining_count = 0;
        let v1 = 0x2::balance::value<T0>(&arg0.balance);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v1, arg1), v0);
        };
    }

    // decompiled from Move bytecode v6
}

