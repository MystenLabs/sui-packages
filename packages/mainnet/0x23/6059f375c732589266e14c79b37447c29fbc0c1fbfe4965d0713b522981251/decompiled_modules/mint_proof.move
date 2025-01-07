module 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof {
    struct MintProof has store, key {
        id: 0x2::object::UID,
        minter_public_key: vector<u8>,
        used_bit_map: 0x2::vec_map::VecMap<u64, u64>,
    }

    struct MintArg has copy, drop {
        coin_type: 0x1::string::String,
        to: address,
        amount: u256,
        nonce: u64,
    }

    public fun new(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : MintProof {
        MintProof{
            id                : 0x2::object::new(arg1),
            minter_public_key : arg0,
            used_bit_map      : 0x2::vec_map::empty<u64, u64>(),
        }
    }

    public fun decode_msg(arg0: &0x1::option::Option<vector<u8>>) : 0x1::option::Option<MintArg> {
        if (0x1::option::is_none<vector<u8>>(arg0)) {
            return 0x1::option::none<MintArg>()
        };
        let v0 = 0x1::option::borrow<vector<u8>>(arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0;
        while (v4 < 32) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(v0, v4));
            v4 = v4 + 1;
        };
        while (v4 < 64) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(v0, v4));
            v4 = v4 + 1;
        };
        let v5 = 0;
        while (v5 < 24) {
            0x1::vector::push_back<u8>(&mut v3, 0);
            v5 = v5 + 1;
        };
        while (v4 < 72) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(v0, v4));
            v4 = v4 + 1;
        };
        v4 = v4 + 1;
        let v6 = 0x1::vector::empty<u8>();
        while (v4 < 73 + (*0x1::vector::borrow<u8>(v0, 72) as u64)) {
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(v0, v4));
            v4 = v4 + 1;
        };
        let v7 = MintArg{
            coin_type : 0x1::string::utf8(v6),
            to        : 0x2::address::from_bytes(v1),
            amount    : 0x2::address::to_u256(0x2::address::from_bytes(v2)),
            nonce     : (0x2::address::to_u256(0x2::address::from_bytes(v3)) as u64),
        };
        0x1::option::some<MintArg>(v7)
    }

    public fun get_mint_arg_amount(arg0: &MintArg) : u256 {
        arg0.amount
    }

    public fun get_mint_arg_coin_type(arg0: &MintArg) : 0x1::string::String {
        arg0.coin_type
    }

    public fun get_mint_arg_nonce(arg0: &MintArg) : u64 {
        arg0.nonce
    }

    public fun get_mint_arg_to(arg0: &MintArg) : address {
        arg0.to
    }

    public fun is_nonce_used(arg0: &MintProof, arg1: u64) : bool {
        let v0 = arg1 / 64;
        if (0x2::vec_map::contains<u64, u64>(&arg0.used_bit_map, &v0)) {
            let v1 = 0x1::u64::try_as_u8(arg1 % 64);
            let v2 = 1 << *0x1::option::borrow<u8>(&v1);
            return *0x2::vec_map::get<u64, u64>(&arg0.used_bit_map, &v0) & v2 == v2
        };
        false
    }

    public fun set_nonce_used(arg0: &mut MintProof, arg1: u64) {
        let v0 = arg1 / 64;
        let v1 = 0x1::u64::try_as_u8(arg1 % 64);
        if (0x2::vec_map::contains<u64, u64>(&arg0.used_bit_map, &v0)) {
            let v2 = 0x2::vec_map::get_mut<u64, u64>(&mut arg0.used_bit_map, &v0);
            *v2 = *v2 | 1 << *0x1::option::borrow<u8>(&v1);
        } else {
            0x2::vec_map::insert<u64, u64>(&mut arg0.used_bit_map, v0, 1 << *0x1::option::borrow<u8>(&v1));
        };
    }

    public fun set_public_key(arg0: &mut MintProof, arg1: vector<u8>) {
        arg0.minter_public_key = arg1;
    }

    public fun verify_msg(arg0: &MintProof, arg1: &vector<u8>) : (bool, 0x1::option::Option<vector<u8>>) {
        if (0x1::vector::length<u8>(arg1) <= 64) {
            return (false, 0x1::option::none<vector<u8>>())
        };
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg1) - 64) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg1, v2));
            v2 = v2 + 1;
        };
        while (v2 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg1, v2));
            v2 = v2 + 1;
        };
        (0x2::ed25519::ed25519_verify(&v0, &arg0.minter_public_key, &v1), 0x1::option::some<vector<u8>>(v1))
    }

    // decompiled from Move bytecode v6
}

