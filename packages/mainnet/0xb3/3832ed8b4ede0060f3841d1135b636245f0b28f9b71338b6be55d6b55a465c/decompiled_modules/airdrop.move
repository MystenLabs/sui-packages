module 0xb33832ed8b4ede0060f3841d1135b636245f0b28f9b71338b6be55d6b55a465c::airdrop {
    struct AirdropData<phantom T0> has key {
        id: 0x2::object::UID,
        total_airdrop_token: 0x2::coin::Coin<T0>,
        total_airdrop: u64,
        public_key: vector<u8>,
        start_time_claim: u64,
        end_time_claim: u64,
        total_claim: u64,
        admin: address,
    }

    struct UserData has store {
        is_claim_airdrop: bool,
        amount_ref: u64,
    }

    public entry fun add_reward<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut AirdropData<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg2.admin == v0, 0);
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v0);
        0x2::coin::join<T0>(&mut arg2.total_airdrop_token, 0x2::coin::split<T0>(&mut arg0, arg1, arg3));
        arg2.total_airdrop = arg2.total_airdrop + arg1;
    }

    public entry fun claim_airdrop<T0>(arg0: &mut AirdropData<T0>, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg0.start_time_claim <= v1 && arg0.end_time_claim >= v1, 0);
        let v2 = 0x2::address::to_bytes(v0);
        0x1::vector::append<u8>(&mut v2, num_vec_u8(arg2));
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg0.public_key, &v2), 0);
        if (!0x2::dynamic_field::exists_with_type<address, UserData>(&arg0.id, v0)) {
            let v3 = UserData{
                is_claim_airdrop : false,
                amount_ref       : 0,
            };
            0x2::dynamic_field::add<address, UserData>(&mut arg0.id, v0, v3);
        };
        let v4 = 0x2::dynamic_field::borrow_mut<address, UserData>(&mut arg0.id, v0);
        assert!(!v4.is_claim_airdrop, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.total_airdrop_token, arg2, arg4), v0);
        arg0.total_claim = arg0.total_claim + arg2;
        v4.is_claim_airdrop = true;
    }

    public entry fun claim_airdrop_with_ref<T0>(arg0: &mut AirdropData<T0>, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg0.start_time_claim <= v1 && arg0.end_time_claim >= v1, 0);
        let v2 = 0x2::address::to_bytes(v0);
        0x1::vector::append<u8>(&mut v2, num_vec_u8(arg2));
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg0.public_key, &v2), 0);
        if (!0x2::dynamic_field::exists_with_type<address, UserData>(&arg0.id, v0)) {
            let v3 = UserData{
                is_claim_airdrop : false,
                amount_ref       : 0,
            };
            0x2::dynamic_field::add<address, UserData>(&mut arg0.id, v0, v3);
        };
        let v4 = 0x2::dynamic_field::borrow_mut<address, UserData>(&mut arg0.id, v0);
        assert!(!v4.is_claim_airdrop, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.total_airdrop_token, arg2, arg5), v0);
        arg0.total_claim = arg0.total_claim + arg2;
        v4.is_claim_airdrop = true;
        if (!0x2::dynamic_field::exists_with_type<address, UserData>(&arg0.id, arg4)) {
            let v5 = UserData{
                is_claim_airdrop : false,
                amount_ref       : 0,
            };
            0x2::dynamic_field::add<address, UserData>(&mut arg0.id, arg4, v5);
        };
        let v6 = 0x2::dynamic_field::borrow_mut<address, UserData>(&mut arg0.id, arg4);
        v6.amount_ref = v6.amount_ref + arg2 * 5 / 100;
        arg0.total_claim = arg0.total_claim + arg2;
    }

    public entry fun claim_ref_airdrop<T0>(arg0: &mut AirdropData<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.start_time_claim <= v1 && arg0.end_time_claim >= v1, 0);
        assert!(0x2::dynamic_field::exists_with_type<address, UserData>(&arg0.id, v0), 0);
        let v2 = 0x2::dynamic_field::borrow_mut<address, UserData>(&mut arg0.id, v0);
        assert!(v2.amount_ref > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.total_airdrop_token, v2.amount_ref, arg2), v0);
        arg0.total_claim = arg0.total_claim + v2.amount_ref;
        v2.amount_ref = 0;
    }

    public entry fun init_airdrop<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(@0xe86f6f33784307d2878559b48b6ce15562853662db078cbcbf01b403c0c56f28 == 0x2::tx_context::sender(arg0), 0);
        let v0 = AirdropData<T0>{
            id                  : 0x2::object::new(arg0),
            total_airdrop_token : 0x2::coin::zero<T0>(arg0),
            total_airdrop       : 0,
            public_key          : x"56c3453d434c5e62a1fbf2bf888af5fa6478e51e6bf9a0e8d1677262cc4195bd",
            start_time_claim    : 1683248400000,
            end_time_claim      : 1683421200000,
            total_claim         : 0,
            admin               : @0xe86f6f33784307d2878559b48b6ce15562853662db078cbcbf01b403c0c56f28,
        };
        0x2::transfer::share_object<AirdropData<T0>>(v0);
    }

    fun num_vec_u8(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public entry fun update_publickey<T0>(arg0: &mut AirdropData<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
        arg0.public_key = arg1;
    }

    public entry fun withdraw_unclaim_coin<T0>(arg0: &mut AirdropData<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.admin == v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.total_airdrop_token, 0x2::coin::value<T0>(&arg0.total_airdrop_token), arg1), v0);
        arg0.total_airdrop = 0;
    }

    // decompiled from Move bytecode v6
}

