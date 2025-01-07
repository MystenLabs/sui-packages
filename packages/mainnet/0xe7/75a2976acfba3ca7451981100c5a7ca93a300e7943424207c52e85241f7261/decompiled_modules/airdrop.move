module 0xe775a2976acfba3ca7451981100c5a7ca93a300e7943424207c52e85241f7261::airdrop {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Airdrop<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        balance: 0x2::balance::Balance<T0>,
        whitelist_roots: 0x2::vec_map::VecMap<address, bool>,
        user_claimed: 0x2::vec_map::VecMap<address, u64>,
    }

    struct Ticket has copy, drop {
        owner: address,
        amount: u64,
    }

    struct CreateAirdropEvent has copy, drop {
        airdrop: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        name: 0x1::string::String,
    }

    struct DepositEvent has copy, drop {
        airdrop: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        airdrop: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ClaimEvent has copy, drop {
        airdrop: 0x2::object::ID,
        user: address,
        amount: u64,
    }

    fun add_whitelist_merkle_roots(arg0: &mut 0x2::vec_map::VecMap<address, bool>, arg1: vector<vector<u8>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v1 = *0x1::vector::borrow<vector<u8>>(&arg1, v0);
            assert_merkle_root_hash(v1);
            let v2 = 0x2::address::from_bytes(v1);
            if (!0x2::vec_map::contains<address, bool>(arg0, &v2)) {
                0x2::vec_map::insert<address, bool>(arg0, 0x2::address::from_bytes(v1), true);
            };
            v0 = v0 + 1;
        };
    }

    fun assert_merkle_root_hash(arg0: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 10002);
    }

    fun assert_whitelist_merkle_root(arg0: 0x2::vec_map::VecMap<address, bool>, arg1: u64, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::address::from_bytes(generate_merkle_root(0x2::tx_context::sender(arg3), arg1, arg2));
        assert!(0x2::vec_map::contains<address, bool>(&arg0, &v0), 10000);
    }

    public entry fun claim<T0>(arg0: &mut Airdrop<T0>, arg1: u64, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_whitelist_merkle_root(arg0.whitelist_roots, arg1, arg2, arg3);
        let v0 = get_user_claimed<T0>(arg0, 0x2::tx_context::sender(arg3));
        assert!(v0 < arg1, 10001);
        let v1 = arg1 - v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v1, arg3), 0x2::tx_context::sender(arg3));
        if (v0 == 0) {
            0x2::vec_map::insert<address, u64>(&mut arg0.user_claimed, 0x2::tx_context::sender(arg3), arg1);
        } else {
            let v2 = 0x2::tx_context::sender(arg3);
            *0x2::vec_map::get_mut<address, u64>(&mut arg0.user_claimed, &v2) = arg1;
        };
        let v3 = ClaimEvent{
            airdrop : 0x2::object::id<Airdrop<T0>>(arg0),
            user    : 0x2::tx_context::sender(arg3),
            amount  : v1,
        };
        0x2::event::emit<ClaimEvent>(v3);
    }

    public entry fun create_admin_cap<T0>(arg0: &mut AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    public entry fun create_airdrop<T0>(arg0: &mut AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Airdrop<T0>{
            id              : 0x2::object::new(arg2),
            name            : 0x1::string::utf8(arg1),
            balance         : 0x2::balance::zero<T0>(),
            whitelist_roots : 0x2::vec_map::empty<address, bool>(),
            user_claimed    : 0x2::vec_map::empty<address, u64>(),
        };
        let v1 = CreateAirdropEvent{
            airdrop   : 0x2::object::id<Airdrop<T0>>(&v0),
            coin_type : 0x1::type_name::get<T0>(),
            name      : v0.name,
        };
        0x2::event::emit<CreateAirdropEvent>(v1);
        0x2::transfer::public_share_object<Airdrop<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &mut Airdrop<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        let v0 = DepositEvent{
            airdrop   : 0x2::object::id<Airdrop<T0>>(arg0),
            coin_type : 0x1::type_name::get<T0>(),
            amount    : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    fun generate_merkle_root(arg0: address, arg1: u64, arg2: vector<vector<u8>>) : vector<u8> {
        let v0 = Ticket{
            owner  : arg0,
            amount : arg1,
        };
        0xe775a2976acfba3ca7451981100c5a7ca93a300e7943424207c52e85241f7261::merkle_proof::process_proof(&arg2, 0x1::hash::sha2_256(0x1::bcs::to_bytes<Ticket>(&v0)))
    }

    public fun get_user_claimed<T0>(arg0: &mut Airdrop<T0>, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, u64>(&arg0.user_claimed, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.user_claimed, &arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun put_phaser_whitelist_merkle_roots<T0>(arg0: &mut AdminCap, arg1: &mut Airdrop<T0>, arg2: vector<vector<u8>>) {
        let v0 = &mut arg1.whitelist_roots;
        add_whitelist_merkle_roots(v0, arg2);
    }

    public entry fun remove_phaser_whitelist_merkle_roots<T0>(arg0: &mut AdminCap, arg1: &mut Airdrop<T0>, arg2: vector<vector<u8>>) {
        let v0 = &mut arg1.whitelist_roots;
        remove_whitelist_merkle_roots(v0, arg2);
    }

    fun remove_whitelist_merkle_roots(arg0: &mut 0x2::vec_map::VecMap<address, bool>, arg1: vector<vector<u8>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v1 = *0x1::vector::borrow<vector<u8>>(&arg1, v0);
            assert_merkle_root_hash(v1);
            let v2 = 0x2::address::from_bytes(v1);
            if (0x2::vec_map::contains<address, bool>(arg0, &v2)) {
                let v3 = 0x2::address::from_bytes(v1);
                let (_, _) = 0x2::vec_map::remove<address, bool>(arg0, &v3);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun withdraw<T0>(arg0: &mut AdminCap, arg1: &mut Airdrop<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, arg2, arg4), arg3);
        let v0 = DepositEvent{
            airdrop   : 0x2::object::id<Airdrop<T0>>(arg1),
            coin_type : 0x1::type_name::get<T0>(),
            amount    : arg2,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

