module 0x249d8e59cc51382a384ad098c5e02e082181090b48d9317345f14819477c3ae4::period_claim {
    struct CreatorCap has key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        balance: 0x2::balance::Balance<T0>,
        root: vector<u8>,
        domain: vector<u8>,
        first_start_ms: u64,
        period_starts: vector<u64>,
        budget: u64,
        spent: u64,
        active: bool,
        paused: bool,
        claimed: 0x2::table::Table<vector<u8>, bool>,
    }

    struct Activated has copy, drop {
        vault: 0x2::object::ID,
        root: vector<u8>,
    }

    struct Claimed has copy, drop {
        vault: 0x2::object::ID,
        claim_key: vector<u8>,
        period: u64,
    }

    struct PauseChanged has copy, drop {
        vault: 0x2::object::ID,
        paused: bool,
    }

    public fun activate<T0>(arg0: &CreatorCap, arg1: &mut Vault<T0>, arg2: &0x2::tx_context::TxContext) {
        assert_creator<T0>(arg0, arg1, arg2);
        assert!(!arg1.active && 0x1::vector::length<u8>(&arg1.root) == 32, 1);
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg1.budget, 6);
        arg1.active = true;
        let v0 = Activated{
            vault : 0x2::object::id<Vault<T0>>(arg1),
            root  : arg1.root,
        };
        0x2::event::emit<Activated>(v0);
    }

    fun address_hex(arg0: address) : vector<u8> {
        let v0 = b"0x";
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(0x2::address::to_bytes(arg0)));
        v0
    }

    fun assert_creator<T0>(arg0: &CreatorCap, arg1: &Vault<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.vault == 0x2::object::id<Vault<T0>>(arg1) && arg1.creator == 0x2::tx_context::sender(arg2), 0);
    }

    public fun claim<T0>(arg0: &CreatorCap, arg1: &mut Vault<T0>, arg2: vector<u8>, arg3: address, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_creator<T0>(arg0, arg1, arg12);
        assert!(arg1.active, 1);
        assert!(!arg1.paused, 9);
        let v0 = if (arg4 >= 1) {
            if (arg4 <= 9) {
                arg8 == arg4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg11);
        assert!(v1 >= *0x1::vector::borrow<u64>(&arg1.period_starts, arg4 - 1), 3);
        assert!(arg9 > v1 && arg9 - v1 <= 900000, 8);
        let v2 = if (0x1::vector::length<u8>(&arg2) == 20) {
            if (arg3 != @0x0) {
                if (arg5 > 0) {
                    0x1::vector::length<u8>(&arg6) == 32
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 4);
        let v3 = claim_key(arg2, arg4);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg1.claimed, v3), 5);
        assert!(verify_proof(arg1.root, leaf_hash(arg1.domain, arg2, arg3, arg4, arg5, arg6), arg7), 4);
        assert!(arg5 <= arg1.budget - arg1.spent, 6);
        assert!(recover_bsc(arg10, claim_message<T0>(arg1, arg2, arg3, arg4, arg5, arg8, arg9)) == arg2, 7);
        0x2::table::add<vector<u8>, bool>(&mut arg1.claimed, v3, true);
        arg1.spent = arg1.spent + arg5;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, arg5, arg12), arg3);
        let v4 = Claimed{
            vault     : 0x2::object::id<Vault<T0>>(arg1),
            claim_key : v3,
            period    : arg4,
        };
        0x2::event::emit<Claimed>(v4);
    }

    public fun claim_key(arg0: vector<u8>, arg1: u64) : vector<u8> {
        let v0 = x"02";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x2::hash::keccak256(&v0)
    }

    public fun claim_message<T0>(arg0: &Vault<T0>, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : vector<u8> {
        let v0 = x"4144415054204d65726b6c6520436c61696d2076330a416374696f6e3a20636c61696d0a42534320636861696e2049443a2035360a";
        0x1::vector::append<u8>(&mut v0, x"537569206e6574776f726b3a206d61696e6e65740a");
        0x1::vector::append<u8>(&mut v0, b"Package: ");
        0x1::vector::append<u8>(&mut v0, address_hex(0x1::type_name::original_id<Vault<T0>>()));
        0x1::vector::append<u8>(&mut v0, x"0a5661756c743a20");
        let v1 = 0x2::object::id<Vault<T0>>(arg0);
        0x1::vector::append<u8>(&mut v0, address_hex(0x2::object::id_to_address(&v1)));
        0x1::vector::append<u8>(&mut v0, x"0a436f696e20747970653a203078");
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())));
        0x1::vector::append<u8>(&mut v0, x"0a4d65726b6c6520726f6f743a203078");
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(arg0.root));
        0x1::vector::append<u8>(&mut v0, x"0a42534320616464726573733a203078");
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(arg1));
        0x1::vector::append<u8>(&mut v0, x"0a53756920726563697069656e743a20");
        0x1::vector::append<u8>(&mut v0, address_hex(arg2));
        0x1::vector::append<u8>(&mut v0, x"0a506572696f643a20");
        0x1::vector::append<u8>(&mut v0, decimal(arg3));
        0x1::vector::append<u8>(&mut v0, x"0a416d6f756e7420286261736520756e697473293a20");
        0x1::vector::append<u8>(&mut v0, decimal(arg4));
        0x1::vector::append<u8>(&mut v0, x"0a4e6f6e63653a20");
        0x1::vector::append<u8>(&mut v0, decimal(arg5));
        0x1::vector::append<u8>(&mut v0, x"0a457870697265732061742028556e6978206d73293a20");
        0x1::vector::append<u8>(&mut v0, decimal(arg6));
        v0
    }

    public fun configure<T0>(arg0: &CreatorCap, arg1: &mut Vault<T0>, arg2: vector<u8>, arg3: vector<u64>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_creator<T0>(arg0, arg1, arg6);
        let v0 = if (0x1::vector::is_empty<u8>(&arg1.root)) {
            if (0x1::vector::length<u8>(&arg2) == 32) {
                arg4 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        assert!(0x1::vector::length<u64>(&arg3) == 9 && *0x1::vector::borrow<u64>(&arg3, 0) > 0x2::clock::timestamp_ms(arg5), 3);
        let v1 = 1;
        while (v1 < 9) {
            assert!(*0x1::vector::borrow<u64>(&arg3, v1) > *0x1::vector::borrow<u64>(&arg3, v1 - 1), 3);
            v1 = v1 + 1;
        };
        arg1.root = arg2;
        arg1.first_start_ms = *0x1::vector::borrow<u64>(&arg3, 0);
        arg1.period_starts = arg3;
        arg1.budget = arg4;
    }

    public fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_vault<T0>(arg0);
        0x2::transfer::transfer<CreatorCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun current_period<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.period_starts) && *0x1::vector::borrow<u64>(&arg0.period_starts, v0) <= 0x2::clock::timestamp_ms(arg1)) {
            v0 = v0 + 1;
        };
        v0
    }

    fun decimal(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    fun domain_hash<T0>(arg0: &Vault<T0>) : vector<u8> {
        let v0 = 0x2::object::id<Vault<T0>>(arg0);
        domain_of(0x1::type_name::original_id<Vault<T0>>(), 0x2::object::id_to_address(&v0), 0x1::type_name::with_original_ids<T0>())
    }

    fun domain_of(arg0: address, arg1: address, arg2: 0x1::type_name::TypeName) : vector<u8> {
        let v0 = x"4144415054204d65726b6c6520436c61696d2076330a6d61696e6e65740a";
        0x1::vector::append<u8>(&mut v0, address_hex(arg0));
        0x1::vector::push_back<u8>(&mut v0, 10);
        0x1::vector::append<u8>(&mut v0, address_hex(arg1));
        0x1::vector::push_back<u8>(&mut v0, 10);
        0x1::vector::append<u8>(&mut v0, b"0x");
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(arg2)));
        0x2::hash::keccak256(&v0)
    }

    public fun fund<T0>(arg0: &CreatorCap, arg1: &mut Vault<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_creator<T0>(arg0, arg1, arg3);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun is_claimed<T0>(arg0: &Vault<T0>, arg1: vector<u8>, arg2: u64) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.claimed, claim_key(arg1, arg2))
    }

    public fun leaf_hash(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u64, arg5: vector<u8>) : vector<u8> {
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, arg5);
        0x2::hash::keccak256(&v0)
    }

    fun less(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 32) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return *0x1::vector::borrow<u8>(arg0, v0) < *0x1::vector::borrow<u8>(arg1, v0)
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun new_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) : (Vault<T0>, CreatorCap) {
        let v0 = Vault<T0>{
            id             : 0x2::object::new(arg0),
            creator        : 0x2::tx_context::sender(arg0),
            balance        : 0x2::balance::zero<T0>(),
            root           : b"",
            domain         : b"",
            first_start_ms : 0,
            period_starts  : vector[],
            budget         : 0,
            spent          : 0,
            active         : false,
            paused         : false,
            claimed        : 0x2::table::new<vector<u8>, bool>(arg0),
        };
        v0.domain = domain_hash<T0>(&v0);
        let v1 = CreatorCap{
            id    : 0x2::object::new(arg0),
            vault : 0x2::object::id<Vault<T0>>(&v0),
        };
        (v0, v1)
    }

    public fun node_hash(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32 && 0x1::vector::length<u8>(&arg1) == 32, 4);
        let v0 = x"01";
        if (less(&arg0, &arg1)) {
            0x1::vector::append<u8>(&mut v0, arg0);
            0x1::vector::append<u8>(&mut v0, arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, arg1);
            0x1::vector::append<u8>(&mut v0, arg0);
        };
        0x2::hash::keccak256(&v0)
    }

    fun personal_message(arg0: vector<u8>) : vector<u8> {
        let v0 = x"19";
        0x1::vector::append<u8>(&mut v0, x"457468657265756d205369676e6564204d6573736167653a0a");
        0x1::vector::append<u8>(&mut v0, decimal(0x1::vector::length<u8>(&arg0)));
        0x1::vector::append<u8>(&mut v0, arg0);
        v0
    }

    fun recover_bsc(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 65, 7);
        let v0 = *0x1::vector::borrow<u8>(&arg0, 64);
        let v1 = if (v0 == 0) {
            true
        } else if (v0 == 1) {
            true
        } else if (v0 == 27) {
            true
        } else {
            v0 == 28
        };
        assert!(v1, 7);
        if (v0 >= 27) {
            *0x1::vector::borrow_mut<u8>(&mut arg0, 64) = v0 - 27;
        };
        let v2 = personal_message(arg1);
        let v3 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &v2, 0);
        let v4 = 0x2::ecdsa_k1::decompress_pubkey(&v3);
        let v5 = b"";
        let v6 = 1;
        while (v6 < 65) {
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(&v4, v6));
            v6 = v6 + 1;
        };
        let v7 = 0x2::hash::keccak256(&v5);
        let v8 = b"";
        v6 = 12;
        while (v6 < 32) {
            0x1::vector::push_back<u8>(&mut v8, *0x1::vector::borrow<u8>(&v7, v6));
            v6 = v6 + 1;
        };
        v8
    }

    public fun set_paused<T0>(arg0: &CreatorCap, arg1: &mut Vault<T0>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_creator<T0>(arg0, arg1, arg3);
        arg1.paused = arg2;
        let v0 = PauseChanged{
            vault  : 0x2::object::id<Vault<T0>>(arg1),
            paused : arg2,
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun spent<T0>(arg0: &Vault<T0>) : u64 {
        arg0.spent
    }

    public fun verify_proof(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<vector<u8>>) : bool {
        assert!(0x1::vector::length<vector<u8>>(&arg2) <= 32, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2)) {
            arg1 = node_hash(arg1, *0x1::vector::borrow<vector<u8>>(&arg2, v0));
            v0 = v0 + 1;
        };
        arg1 == arg0
    }

    // decompiled from Move bytecode v7
}

