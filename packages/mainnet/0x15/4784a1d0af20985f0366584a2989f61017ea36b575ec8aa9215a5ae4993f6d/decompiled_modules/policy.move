module 0x154784a1d0af20985f0366584a2989f61017ea36b575ec8aa9215a5ae4993f6d::policy {
    struct Gate has key {
        id: 0x2::object::UID,
        creator: address,
        kind: u8,
        type_name: 0x1::ascii::String,
        min: u64,
        once_per_nft: bool,
        claims: 0x2::table::Table<0x2::object::ID, address>,
    }

    struct GateCreated has copy, drop {
        gate: 0x2::object::ID,
        creator: address,
        kind: u8,
        type_name: 0x1::ascii::String,
        min: u64,
        once_per_nft: bool,
    }

    struct Claimed has copy, drop {
        gate: 0x2::object::ID,
        nft: 0x2::object::ID,
        wallet: address,
    }

    public fun claim<T0: key>(arg0: &mut Gate, arg1: &T0, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.kind == 0, 7);
        assert!(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()) == arg0.type_name, 3);
        let v0 = 0x2::object::id<T0>(arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<0x2::object::ID, address>(&arg0.claims, v0)) {
            assert!(*0x2::table::borrow<0x2::object::ID, address>(&arg0.claims, v0) == v1, 6);
        } else {
            0x2::table::add<0x2::object::ID, address>(&mut arg0.claims, v0, v1);
            let v2 = Claimed{
                gate   : 0x2::object::id<Gate>(arg0),
                nft    : v0,
                wallet : v1,
            };
            0x2::event::emit<Claimed>(v2);
        };
    }

    public fun claimed_by(arg0: &Gate, arg1: 0x2::object::ID) : 0x1::option::Option<address> {
        if (0x2::table::contains<0x2::object::ID, address>(&arg0.claims, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<0x2::object::ID, address>(&arg0.claims, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun create_coin_gate<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        new_gate(1, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::coin::Coin<T0>>()), arg0, false, arg1)
    }

    public fun create_nft_gate<T0: key>(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        new_gate(0, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 0, arg0, arg1)
    }

    public fun creator(arg0: &Gate) : address {
        arg0.creator
    }

    public fun gate_type(arg0: &Gate) : 0x1::ascii::String {
        arg0.type_name
    }

    public fun has_prefix(arg0: 0x2::object::ID, arg1: &vector<u8>) : bool {
        let v0 = 0x2::object::id_to_bytes(&arg0);
        let v1 = 0x1::vector::length<u8>(&v0);
        if (0x1::vector::length<u8>(arg1) < v1) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            if (*0x1::vector::borrow<u8>(&v0, v2) != *0x1::vector::borrow<u8>(arg1, v2)) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun kind(arg0: &Gate) : u8 {
        arg0.kind
    }

    public fun min(arg0: &Gate) : u64 {
        arg0.min
    }

    fun new_gate(arg0: u8, arg1: 0x1::ascii::String, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x1::ascii::length(&arg1) > 0 && 0x1::ascii::length(&arg1) <= 512, 10);
        let v0 = Gate{
            id           : 0x2::object::new(arg4),
            creator      : 0x2::tx_context::sender(arg4),
            kind         : arg0,
            type_name    : arg1,
            min          : arg2,
            once_per_nft : arg3,
            claims       : 0x2::table::new<0x2::object::ID, address>(arg4),
        };
        let v1 = 0x2::object::id<Gate>(&v0);
        let v2 = GateCreated{
            gate         : v1,
            creator      : v0.creator,
            kind         : arg0,
            type_name    : arg1,
            min          : arg2,
            once_per_nft : arg3,
        };
        0x2::event::emit<GateCreated>(v2);
        0x2::transfer::share_object<Gate>(v0);
        v1
    }

    public fun once_per_nft(arg0: &Gate) : bool {
        arg0.once_per_nft
    }

    entry fun seal_approve_coin<T0>(arg0: vector<u8>, arg1: &Gate, arg2: &0x2::coin::Coin<T0>) {
        assert!(has_prefix(0x2::object::id<Gate>(arg1), &arg0), 2);
        assert!(arg1.kind == 1, 8);
        assert!(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::coin::Coin<T0>>()) == arg1.type_name, 3);
        assert!(0x2::coin::value<T0>(arg2) >= arg1.min, 4);
    }

    entry fun seal_approve_creator(arg0: vector<u8>, arg1: &Gate, arg2: &0x2::tx_context::TxContext) {
        assert!(has_prefix(0x2::object::id<Gate>(arg1), &arg0), 2);
        assert!(arg1.creator == 0x2::tx_context::sender(arg2), 9);
    }

    entry fun seal_approve_nft<T0: key>(arg0: vector<u8>, arg1: &Gate, arg2: &T0, arg3: &0x2::tx_context::TxContext) {
        assert!(has_prefix(0x2::object::id<Gate>(arg1), &arg0), 2);
        assert!(arg1.kind == 0, 7);
        assert!(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()) == arg1.type_name, 3);
        if (arg1.once_per_nft) {
            let v0 = 0x2::object::id<T0>(arg2);
            assert!(0x2::table::contains<0x2::object::ID, address>(&arg1.claims, v0), 5);
            assert!(*0x2::table::borrow<0x2::object::ID, address>(&arg1.claims, v0) == 0x2::tx_context::sender(arg3), 6);
        };
    }

    entry fun seal_approve_paywall<T0>(arg0: vector<u8>, arg1: &0x6a5e43b04523f8acf9cd5a07c0868eb37d549a947d78a4f9628f2ec34b5e54fd::paywall::Post<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(has_prefix(0x2::object::id<0x6a5e43b04523f8acf9cd5a07c0868eb37d549a947d78a4f9628f2ec34b5e54fd::paywall::Post<T0>>(arg1), &arg0), 2);
        assert!(0x6a5e43b04523f8acf9cd5a07c0868eb37d549a947d78a4f9628f2ec34b5e54fd::paywall::has_access<T0>(arg1, 0x2::tx_context::sender(arg2)), 1);
    }

    // decompiled from Move bytecode v7
}

