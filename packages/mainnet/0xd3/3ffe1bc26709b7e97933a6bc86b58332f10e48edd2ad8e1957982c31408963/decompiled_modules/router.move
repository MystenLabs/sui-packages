module 0xd33ffe1bc26709b7e97933a6bc86b58332f10e48edd2ad8e1957982c31408963::router {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
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

    struct UpgradeEvent has copy, drop {
        old_version: u64,
        new_version: u64,
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

    public entry fun add_signer(arg0: &mut Version, arg1: &AdminCap, arg2: &mut ValidSigner, arg3: vector<u8>) {
        check_dexrouter_version(arg0);
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg1), 8);
        assert!(0x1::vector::length<u8>(&arg3) == 20, 13);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2.addresses)) {
            assert!(0x1::vector::borrow<vector<u8>>(&arg2.addresses, v0) != &arg3, 14);
            v0 = v0 + 1;
        };
        0x1::vector::push_back<vector<u8>>(&mut arg2.addresses, arg3);
        let v1 = SignerChangeEvent{
            addr   : arg3,
            action : 0,
        };
        0x2::event::emit<SignerChangeEvent>(v1);
    }

    public fun afsui_swap_a2b_with_return_sigverify(arg0: &mut Version, arg1: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg2: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: address, arg7: &ValidSigner, arg8: u64, arg9: &mut vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, u64) {
        check_dexrouter_version(arg0);
        assert!(verify(arg7, 0x2::tx_context::sender(arg11), arg8, arg9, arg10), 15);
        let v0 = 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_stake(arg1, arg2, arg3, arg4, arg5, arg6, arg11);
        let v1 = 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun afsui_swap_b2a_with_return_sigverify(arg0: &mut Version, arg1: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg2: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: &mut 0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::Treasury, arg5: 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg6: &ValidSigner, arg7: u64, arg8: &mut vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64) {
        check_dexrouter_version(arg0);
        assert!(verify(arg6, 0x2::tx_context::sender(arg10), arg7, arg8, arg9), 15);
        let v0 = 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_unstake_atomic(arg1, arg2, arg3, arg4, arg5, arg10);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public entry fun change_admin(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 11);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        let v0 = ChangeAdminEvent{
            old_admin : 0x2::tx_context::sender(arg2),
            new_admin : arg1,
        };
        0x2::event::emit<ChangeAdminEvent>(v0);
    }

    public fun check_dexrouter_version(arg0: &Version) {
        assert!(arg0.version == 0, 9);
    }

    fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun finalize_sigverify<T0>(arg0: &mut Version, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: u8, arg7: &ValidSigner, arg8: u64, arg9: &mut vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        check_dexrouter_version(arg0);
        assert!(verify(arg7, 0x2::tx_context::sender(arg11), arg8, arg9, arg10), 15);
        assert!(arg3 == 0 || arg3 > 0 && arg4 != @0x0, 5);
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 < arg2) {
            abort 1
        };
        let v1 = OrderRecord{
            order_id   : arg5,
            decimal    : arg6,
            out_amount : v0,
        };
        0x2::event::emit<OrderRecord>(v1);
        if (arg3 > 0) {
            let v2 = &mut arg1;
            let (v3, _) = split_with_percentage_for_commission<T0>(arg0, v2, arg3, arg4, arg11);
            destroy_or_transfer<T0>(v3, arg11);
            destroy_or_transfer<T0>(arg1, arg11);
        } else {
            destroy_or_transfer<T0>(arg1, arg11);
        };
    }

    public fun get_signers(arg0: &ValidSigner) : &vector<vector<u8>> {
        &arg0.addresses
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Version{
            id      : 0x2::object::new(arg0),
            version : 0,
            admin   : 0x2::object::id<AdminCap>(&v0),
        };
        0x2::transfer::share_object<Version>(v1);
        let v2 = ValidSigner{
            id        : 0x2::object::new(arg0),
            addresses : 0x1::vector::empty<vector<u8>>(),
        };
        0x2::transfer::share_object<ValidSigner>(v2);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate(arg0: &mut Version, arg1: &AdminCap) {
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg1), 8);
        let v0 = arg0.version;
        assert!(v0 < 0, 10);
        arg0.version = 0;
        let v1 = UpgradeEvent{
            old_version : v0,
            new_version : 0,
        };
        0x2::event::emit<UpgradeEvent>(v1);
    }

    public entry fun remove_signer(arg0: &mut Version, arg1: &AdminCap, arg2: &mut ValidSigner, arg3: vector<u8>) {
        check_dexrouter_version(arg0);
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg1), 8);
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

    public fun split_with_percentage<T0>(arg0: &mut Version, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, 0x2::coin::Coin<T0>, u64) {
        check_dexrouter_version(arg0);
        assert!(arg2 <= 10000, 2);
        let v0 = 0x2::coin::value<T0>(arg1);
        let v1 = (((v0 as u128) * (arg2 as u128) / (10000 as u128)) as u64);
        (0x2::coin::split<T0>(arg1, v1, arg3), v1, 0x2::coin::split<T0>(arg1, v0 - v1, arg3), v0 - v1)
    }

    public fun split_with_percentage_for_commission<T0>(arg0: &mut Version, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_dexrouter_version(arg0);
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

    fun u64_to_be_bytes(arg0: u64) : vector<u8> {
        reverse_bytes(0x1::bcs::to_bytes<u64>(&arg0))
    }

    fun verify(arg0: &ValidSigner, arg1: address, arg2: u64, arg3: &mut vector<u8>, arg4: &0x2::clock::Clock) : bool {
        assert!(0x2::clock::timestamp_ms(arg4) < arg2, 12);
        assert!(0x1::vector::length<u8>(arg3) == 65, 16);
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
            assert!(*v2 == 28, 17);
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

