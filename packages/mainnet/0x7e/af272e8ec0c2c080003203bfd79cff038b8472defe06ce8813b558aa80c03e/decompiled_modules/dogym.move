module 0x7eaf272e8ec0c2c080003203bfd79cff038b8472defe06ce8813b558aa80c03e::dogym {
    struct DogymAridrop<phantom T0> has key {
        id: 0x2::object::UID,
        total_dogym_coin: 0x2::coin::Coin<T0>,
        total_coin_balance: u64,
        public_key: vector<u8>,
        start_time: u64,
        end_time: u64,
        total_coin_claim: u64,
        admin: address,
    }

    struct AddressAirdrop has store {
        is_claim: bool,
        total_ref: u64,
    }

    public entry fun add_coin_to_airdrop<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut DogymAridrop<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg2.admin == v0, 0);
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v0);
        0x2::coin::join<T0>(&mut arg2.total_dogym_coin, 0x2::coin::split<T0>(&mut arg0, arg1, arg3));
        arg2.total_coin_balance = arg2.total_coin_balance + arg1;
    }

    public entry fun claim_coin_airdrop<T0>(arg0: &mut DogymAridrop<T0>, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg0.start_time <= v1 && arg0.end_time >= v1, 0);
        let v2 = 0x2::address::to_bytes(v0);
        0x1::vector::append<u8>(&mut v2, num_vec_u8(arg2));
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg0.public_key, &v2), 0);
        if (!0x2::dynamic_field::exists_with_type<address, AddressAirdrop>(&arg0.id, v0)) {
            let v3 = AddressAirdrop{
                is_claim  : false,
                total_ref : 0,
            };
            0x2::dynamic_field::add<address, AddressAirdrop>(&mut arg0.id, v0, v3);
        };
        let v4 = 0x2::dynamic_field::borrow_mut<address, AddressAirdrop>(&mut arg0.id, v0);
        assert!(!v4.is_claim, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.total_dogym_coin, arg2, arg4), v0);
        arg0.total_coin_claim = arg0.total_coin_claim + arg2;
        v4.is_claim = true;
    }

    public entry fun claim_ref<T0>(arg0: &mut DogymAridrop<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.start_time <= v1 && arg0.end_time >= v1, 0);
        assert!(0x2::dynamic_field::exists_with_type<address, AddressAirdrop>(&arg0.id, v0), 0);
        let v2 = 0x2::dynamic_field::borrow_mut<address, AddressAirdrop>(&mut arg0.id, v0);
        assert!(v2.total_ref > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.total_dogym_coin, v2.total_ref, arg2), v0);
        arg0.total_coin_claim = arg0.total_coin_claim + v2.total_ref;
        v2.total_ref = 0;
    }

    public entry fun init_module<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(@0xb416fa71712c1900bc458c89eebb6cf2c232e08467c0d0ae3ecef95275ad7779 == 0x2::tx_context::sender(arg0), 0);
        let v0 = DogymAridrop<T0>{
            id                 : 0x2::object::new(arg0),
            total_dogym_coin   : 0x2::coin::zero<T0>(arg0),
            total_coin_balance : 0,
            public_key         : x"f9fe1d9c2e005bb003c11c3cf1006bb7fdd63ea17b559be7c392f57656f55a97",
            start_time         : 168400080000,
            end_time           : 16841556000000,
            total_coin_claim   : 0,
            admin              : @0xb416fa71712c1900bc458c89eebb6cf2c232e08467c0d0ae3ecef95275ad7779,
        };
        0x2::transfer::share_object<DogymAridrop<T0>>(v0);
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

    public entry fun ref_claim_coin_airdrop<T0>(arg0: &mut DogymAridrop<T0>, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg0.start_time <= v1 && arg0.end_time >= v1, 0);
        let v2 = 0x2::address::to_bytes(v0);
        0x1::vector::append<u8>(&mut v2, num_vec_u8(arg2));
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg0.public_key, &v2), 0);
        if (!0x2::dynamic_field::exists_with_type<address, AddressAirdrop>(&arg0.id, v0)) {
            let v3 = AddressAirdrop{
                is_claim  : false,
                total_ref : 0,
            };
            0x2::dynamic_field::add<address, AddressAirdrop>(&mut arg0.id, v0, v3);
        };
        let v4 = 0x2::dynamic_field::borrow_mut<address, AddressAirdrop>(&mut arg0.id, v0);
        assert!(!v4.is_claim, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.total_dogym_coin, arg2, arg5), v0);
        arg0.total_coin_claim = arg0.total_coin_claim + arg2;
        v4.is_claim = true;
        if (!0x2::dynamic_field::exists_with_type<address, AddressAirdrop>(&arg0.id, arg4)) {
            let v5 = AddressAirdrop{
                is_claim  : false,
                total_ref : 0,
            };
            0x2::dynamic_field::add<address, AddressAirdrop>(&mut arg0.id, arg4, v5);
        };
        let v6 = 0x2::dynamic_field::borrow_mut<address, AddressAirdrop>(&mut arg0.id, arg4);
        v6.total_ref = v6.total_ref + arg2 * 5 / 100;
    }

    public entry fun update_share_admin<T0>(arg0: &mut DogymAridrop<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg4), 0);
        arg0.public_key = arg1;
        arg0.start_time = arg2;
        arg0.end_time = arg3;
    }

    public entry fun withdraw_admin<T0>(arg0: &mut DogymAridrop<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.admin == v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.total_dogym_coin, 0x2::coin::value<T0>(&arg0.total_dogym_coin), arg1), v0);
        arg0.total_coin_balance = 0;
    }

    // decompiled from Move bytecode v6
}

