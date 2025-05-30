module 0x30aa42c5148de6e5f57500b5ce99aa97fe71319d3d1c42d4e90e8d2889e81ec7::router {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PauseConfig has key {
        id: 0x2::object::UID,
        paused: bool,
    }

    struct OrderRecord has copy, drop {
        order_id: u64,
        decimal: u8,
        out_amount: u64,
    }

    struct CommissionRecord has copy, drop {
        commission_amount: u64,
        referal_address: address,
    }

    struct HopRecord has copy, drop {
        out_amount: u64,
    }

    struct ChangeAdminEvent has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct ValidSigner has key {
        id: 0x2::object::UID,
        addresses: vector<vector<u8>>,
    }

    struct SignerChangeEvent has copy, drop {
        addr: vector<u8>,
        action: u8,
    }

    public entry fun add_signer(arg0: &PauseConfig, arg1: &AdminCap, arg2: &mut ValidSigner, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        check_pause(arg0);
        assert!(0x1::vector::length<u8>(&arg3) == 20, 11);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2.addresses)) {
            assert!(0x1::vector::borrow<vector<u8>>(&arg2.addresses, v0) != &arg3, 12);
            v0 = v0 + 1;
        };
        0x1::vector::push_back<vector<u8>>(&mut arg2.addresses, arg3);
        let v1 = SignerChangeEvent{
            addr   : arg3,
            action : 0,
        };
        0x2::event::emit<SignerChangeEvent>(v1);
    }

    public entry fun change_admin(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 9);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        let v0 = ChangeAdminEvent{
            old_admin : 0x2::tx_context::sender(arg2),
            new_admin : arg1,
        };
        0x2::event::emit<ChangeAdminEvent>(v0);
    }

    fun check_pause(arg0: &PauseConfig) {
        assert!(!arg0.paused, 8);
    }

    fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun finalize<T0>(arg0: &PauseConfig, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: u8, arg7: &ValidSigner, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        check_pause(arg0);
        let v0 = &mut arg9;
        assert!(verify(arg7, 0x2::tx_context::sender(arg11), arg8, v0, arg10), 13);
        assert!(arg3 == 0 || arg3 > 0 && arg4 != @0x0, 5);
        let v1 = 0x2::coin::value<T0>(&arg1);
        if (v1 < arg2) {
            abort 1
        };
        let v2 = OrderRecord{
            order_id   : arg5,
            decimal    : arg6,
            out_amount : v1,
        };
        0x2::event::emit<OrderRecord>(v2);
        if (arg3 > 0) {
            let v3 = &mut arg1;
            let (v4, _) = split_with_percentage_for_commission<T0>(arg0, v3, arg3, arg4, arg11);
            destroy_or_transfer<T0>(v4, arg11);
            destroy_or_transfer<T0>(arg1, arg11);
        } else {
            destroy_or_transfer<T0>(arg1, arg11);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = PauseConfig{
            id     : 0x2::object::new(arg0),
            paused : false,
        };
        0x2::transfer::share_object<PauseConfig>(v1);
        let v2 = ValidSigner{
            id        : 0x2::object::new(arg0),
            addresses : 0x1::vector::empty<vector<u8>>(),
        };
        0x2::transfer::share_object<ValidSigner>(v2);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun remove_signer(arg0: &PauseConfig, arg1: &AdminCap, arg2: &mut ValidSigner, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        check_pause(arg0);
        assert!(0x1::vector::length<u8>(&arg3) == 20, 11);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2.addresses)) {
            if (!v1 && 0x1::vector::borrow<vector<u8>>(&arg2.addresses, v0) == &arg3) {
                0x1::vector::remove<vector<u8>>(&mut arg2.addresses, v0);
                let v2 = SignerChangeEvent{
                    addr   : arg3,
                    action : 1,
                };
                0x2::event::emit<SignerChangeEvent>(v2);
                v1 = true;
                continue
            };
            v0 = v0 + 1;
        };
    }

    fun reverse_bytes(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::length<u8>(&arg0);
        while (v1 > 0) {
            v1 = v1 - 1;
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v1));
        };
        v0
    }

    public fun scallop_swap_exact_swap_a2b_with_return<T0, T1>(arg0: &PauseConfig, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T1, T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &ValidSigner, arg7: u64, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let v0 = &mut arg8;
        assert!(verify(arg6, 0x2::tx_context::sender(arg9), arg7, v0, arg5), 13);
        let v1 = 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::mint_s_coin<T1, T0>(arg3, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg1, arg2, arg4, arg5, arg9), arg9);
        let v2 = 0x2::coin::value<T1>(&v1);
        let v3 = HopRecord{out_amount: v2};
        0x2::event::emit<HopRecord>(v3);
        (v1, v2)
    }

    public fun scallop_swap_exact_swap_b2a_with_return<T0, T1>(arg0: &PauseConfig, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &ValidSigner, arg7: u64, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let v0 = &mut arg8;
        assert!(verify(arg6, 0x2::tx_context::sender(arg9), arg7, v0, arg5), 13);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T1>(arg1, arg2, 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::burn_s_coin<T0, T1>(arg3, arg4, arg9), arg5, arg9);
        let v2 = 0x2::coin::value<T1>(&v1);
        let v3 = HopRecord{out_amount: v2};
        0x2::event::emit<HopRecord>(v3);
        (v1, v2)
    }

    fun split_with_percentage<T0>(arg0: &PauseConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, 0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        assert!(arg2 <= 10000, 2);
        let v0 = 0x2::coin::value<T0>(arg1);
        let v1 = (((v0 as u128) * (arg2 as u128) / (10000 as u128)) as u64);
        (0x2::coin::split<T0>(arg1, v1, arg3), v1, 0x2::coin::split<T0>(arg1, v0 - v1, arg3), v0 - v1)
    }

    fun split_with_percentage_for_commission<T0>(arg0: &PauseConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        assert!(arg2 <= 300, 3);
        assert!(arg2 == 0 || arg2 > 0 && arg3 != @0x0, 5);
        let (v0, v1, v2, v3) = split_with_percentage<T0>(arg0, arg1, arg2, arg4);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg3);
            let v4 = CommissionRecord{
                commission_amount : v1,
                referal_address   : arg3,
            };
            0x2::event::emit<CommissionRecord>(v4);
        };
        (v2, v3)
    }

    fun sub_range(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public entry fun toggle_pause(arg0: &mut PauseConfig, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.paused = arg2;
    }

    fun u64_to_be_bytes(arg0: u64) : vector<u8> {
        reverse_bytes(0x1::bcs::to_bytes<u64>(&arg0))
    }

    fun verify(arg0: &ValidSigner, arg1: address, arg2: u64, arg3: &mut vector<u8>, arg4: &0x2::clock::Clock) : bool {
        assert!(0x2::clock::timestamp_ms(arg4) < arg2, 10);
        assert!(0x1::vector::length<u8>(arg3) == 65, 14);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, x"c0badfdeb4a0dfe2dc31d578b5df74f7e294f9617bc9d459ca2f9af5c4844251");
        0x1::vector::append<u8>(&mut v0, u64_to_be_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, u64_to_be_bytes(784));
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, x"19457468657265756d205369676e6564204d6573736167653a0a3332");
        0x1::vector::append<u8>(&mut v1, 0x2::hash::keccak256(&v0));
        let v2 = 0x1::vector::borrow_mut<u8>(arg3, 64);
        if (*v2 == 27) {
            *v2 = 0;
        } else {
            assert!(*v2 == 28, 15);
            *v2 = 1;
        };
        let v3 = 0x2::ecdsa_k1::secp256k1_ecrecover(arg3, &v1, 0);
        let v4 = 0x2::ecdsa_k1::decompress_pubkey(&v3);
        let v5 = sub_range(&v4, 1, 65);
        let v6 = 0x2::hash::keccak256(&v5);
        let v7 = sub_range(&v6, 12, 32);
        let v8 = 0;
        while (v8 < 0x1::vector::length<vector<u8>>(&arg0.addresses)) {
            if (&v7 == 0x1::vector::borrow<vector<u8>>(&arg0.addresses, v8)) {
                return true
            };
            v8 = v8 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

