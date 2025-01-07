module 0xfc293f77024de528f1f30abb7b4edf2cd63f506f3ed1abba18e2d5db531aa614::airdrop {
    struct Aridrop<phantom T0> has key {
        id: 0x2::object::UID,
        coin_balance: 0x2::balance::Balance<T0>,
        end_time: u64,
        total_claim: u64,
        admin: address,
    }

    struct UserAirdrop has store {
        is_claim: bool,
        total_ref: u64,
    }

    public entry fun add_coin_to_airdrop<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut Aridrop<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg2.coin_balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, arg1, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public entry fun claim_coin_airdrop<T0>(arg0: &mut Aridrop<T0>, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.end_time >= 0x2::clock::timestamp_ms(arg3), 1);
        let v1 = 0x2::address::to_bytes(v0);
        0x1::vector::append<u8>(&mut v1, num_vec_u8(arg2));
        let v2 = x"3e61aed96d2b264e29285e248a9d2eef08d449dd2e90e24adbc30e1f4364dd8e";
        assert!(0x2::ed25519::ed25519_verify(&arg1, &v2, &v1), 2);
        if (!0x2::dynamic_field::exists_with_type<address, UserAirdrop>(&arg0.id, v0)) {
            let v3 = UserAirdrop{
                is_claim  : false,
                total_ref : 0,
            };
            0x2::dynamic_field::add<address, UserAirdrop>(&mut arg0.id, v0, v3);
        };
        let v4 = 0x2::dynamic_field::borrow_mut<address, UserAirdrop>(&mut arg0.id, v0);
        assert!(!v4.is_claim, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coin_balance, arg2, arg4), v0);
        arg0.total_claim = arg0.total_claim + arg2;
        v4.is_claim = true;
    }

    public entry fun claim_ref<T0>(arg0: &mut Aridrop<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.end_time >= 0x2::clock::timestamp_ms(arg1), 0);
        assert!(0x2::dynamic_field::exists_with_type<address, UserAirdrop>(&arg0.id, v0), 0);
        let v1 = 0x2::dynamic_field::borrow_mut<address, UserAirdrop>(&mut arg0.id, v0);
        assert!(v1.total_ref > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coin_balance, v1.total_ref, arg2), v0);
        arg0.total_claim = arg0.total_claim + v1.total_ref;
        v1.total_ref = 0;
    }

    public entry fun init_module<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(@0x633381806726bcdfbce9fa94327b148662ebc0ee3f922a9ed413f52badc8aa95 == 0x2::tx_context::sender(arg0), 0);
        let v0 = Aridrop<T0>{
            id           : 0x2::object::new(arg0),
            coin_balance : 0x2::balance::zero<T0>(),
            end_time     : 1733702400000,
            total_claim  : 0,
            admin        : @0x633381806726bcdfbce9fa94327b148662ebc0ee3f922a9ed413f52badc8aa95,
        };
        0x2::transfer::share_object<Aridrop<T0>>(v0);
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

    public entry fun ref_claim_coin_airdrop<T0>(arg0: &mut Aridrop<T0>, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.end_time >= 0x2::clock::timestamp_ms(arg3), 0);
        let v1 = 0x2::address::to_bytes(v0);
        0x1::vector::append<u8>(&mut v1, num_vec_u8(arg2));
        let v2 = x"3e61aed96d2b264e29285e248a9d2eef08d449dd2e90e24adbc30e1f4364dd8e";
        assert!(0x2::ed25519::ed25519_verify(&arg1, &v2, &v1), 0);
        if (!0x2::dynamic_field::exists_with_type<address, UserAirdrop>(&arg0.id, v0)) {
            let v3 = UserAirdrop{
                is_claim  : false,
                total_ref : 0,
            };
            0x2::dynamic_field::add<address, UserAirdrop>(&mut arg0.id, v0, v3);
        };
        let v4 = 0x2::dynamic_field::borrow_mut<address, UserAirdrop>(&mut arg0.id, v0);
        assert!(!v4.is_claim, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coin_balance, arg2, arg5), v0);
        arg0.total_claim = arg0.total_claim + arg2;
        v4.is_claim = true;
        if (!0x2::dynamic_field::exists_with_type<address, UserAirdrop>(&arg0.id, arg4)) {
            let v5 = UserAirdrop{
                is_claim  : false,
                total_ref : 0,
            };
            0x2::dynamic_field::add<address, UserAirdrop>(&mut arg0.id, arg4, v5);
        };
        let v6 = 0x2::dynamic_field::borrow_mut<address, UserAirdrop>(&mut arg0.id, arg4);
        v6.total_ref = v6.total_ref + arg2 * 15 / 100;
    }

    public entry fun update_airdrop<T0>(arg0: &mut Aridrop<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
        arg0.end_time = arg1;
    }

    public entry fun withdraw_admin<T0>(arg0: &mut Aridrop<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.admin == v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coin_balance, 0x2::balance::value<T0>(&arg0.coin_balance), arg1), v0);
    }

    // decompiled from Move bytecode v6
}

