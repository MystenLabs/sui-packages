module 0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::treasury {
    struct ControlledTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        admin_count: u8,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        deny_cap: 0x2::coin::DenyCapV2<T0>,
        roles: 0x2::bag::Bag,
    }

    struct AdminCap has drop, store {
        dummy_field: bool,
    }

    struct MinterCap has drop, store {
        limit: u64,
        epoch: u64,
        left: u64,
    }

    struct PauserCap has drop, store {
        dummy_field: bool,
    }

    struct OperatorCap has drop, store {
        dummy_field: bool,
    }

    struct ClaimerCap has drop, store {
        dummy_field: bool,
    }

    struct LBTCWitness has drop {
        dummy_field: bool,
    }

    struct MintEvent<phantom T0> has copy, drop {
        amount: u64,
        to: address,
        tx_id: vector<u8>,
        index: u32,
    }

    struct MintWithPayloadEvent<phantom T0> has copy, drop {
        amount: u64,
        to: address,
        tx_id: vector<u8>,
        index: u32,
        payload_hash: vector<u8>,
    }

    struct MintWithFeeEvent<phantom T0> has copy, drop {
        amount: u64,
        to: address,
        tx_id: vector<u8>,
        index: u32,
        fee: u64,
        payload_hash: vector<u8>,
    }

    struct MintWithWitnessEvent<phantom T0> has copy, drop {
        amount: u64,
        to: address,
    }

    struct BurnEvent<phantom T0> has copy, drop {
        amount: u64,
        from: address,
    }

    struct UnstakeRequestEvent<phantom T0> has copy, drop {
        from: address,
        script_pubkey: vector<u8>,
        amount_after_fee: u64,
    }

    struct TreasuryAddressEvent has copy, drop {
        treasury_address: address,
    }

    struct DustFeeRateEvent has copy, drop {
        dust_fee_rate: u64,
    }

    struct ChainIdEvent has copy, drop {
        chain_id: u256,
    }

    struct PackageIdEvent has copy, drop {
        package_id: address,
    }

    struct MintActionBytesEvent has copy, drop {
        action_bytes: u32,
    }

    struct FeeActionBytesEvent has copy, drop {
        action_bytes: u32,
    }

    struct MintFeeEvent has copy, drop {
        maximum_fee: u64,
    }

    struct BurnCommissionEvent has copy, drop {
        burn_commission: u64,
    }

    struct WithdrawalEnabledEvent has copy, drop {
        withdrawal_enabled: bool,
    }

    struct BasculeCheckEvent has copy, drop {
        bascule_check: bool,
    }

    struct RoleKey<phantom T0> has copy, drop, store {
        owner: address,
    }

    struct WitnessRoleKey<phantom T0> has copy, drop, store {
        owner: 0x1::ascii::String,
    }

    public fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::DenyCapV2<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : ControlledTreasury<T0> {
        let v0 = ControlledTreasury<T0>{
            id           : 0x2::object::new(arg3),
            admin_count  : 1,
            treasury_cap : arg0,
            deny_cap     : arg1,
            roles        : 0x2::bag::new(arg3),
        };
        let v1 = &mut v0;
        let v2 = AdminCap{dummy_field: false};
        add_cap<T0, AdminCap>(v1, arg2, v2);
        v0
    }

    public fun burn<T0>(arg0: &mut ControlledTreasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BurnEvent<T0>{
            amount : 0x2::coin::value<T0>(&arg1),
            from   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BurnEvent<T0>>(v0);
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg1);
    }

    public fun mint<T0>(arg0: &mut ControlledTreasury<T0>, arg1: &mut 0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::consortium::Consortium, arg2: &0x2::deny_list::DenyList, arg3: &mut 0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::bascule::Bascule, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 9999
    }

    fun add_cap<T0, T1: drop + store>(arg0: &mut ControlledTreasury<T0>, arg1: address, arg2: T1) {
        let v0 = RoleKey<T1>{owner: arg1};
        0x2::bag::add<RoleKey<T1>, T1>(&mut arg0.roles, v0, arg2);
    }

    public fun add_capability<T0, T1: drop + store>(arg0: &mut ControlledTreasury<T0>, arg1: address, arg2: T1, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, AdminCap>(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(!has_cap<T0, T1>(arg0, arg1), 2);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<AdminCap>()) {
            arg0.admin_count = arg0.admin_count + 1;
        };
        add_cap<T0, T1>(arg0, arg1, arg2);
    }

    public fun add_witness_mint_capability<T0>(arg0: &mut ControlledTreasury<T0>, arg1: 0x1::ascii::String, arg2: MinterCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, AdminCap>(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(!witness_has_minter_cap<T0>(arg0, arg1), 2);
        add_witness_minter_cap<T0>(arg0, arg1, arg2);
    }

    fun add_witness_minter_cap<T0>(arg0: &mut ControlledTreasury<T0>, arg1: 0x1::ascii::String, arg2: MinterCap) {
        let v0 = WitnessRoleKey<MinterCap>{owner: arg1};
        0x2::bag::add<WitnessRoleKey<MinterCap>, MinterCap>(&mut arg0.roles, v0, arg2);
    }

    fun assert_decoded_payload<T0>(arg0: u32, arg1: u256, arg2: address, arg3: u256, arg4: u256, arg5: u256, arg6: &ControlledTreasury<T0>, arg7: &mut 0xff2c46f430582f4ea1842e584e7e6f99719d258c886b704509e65bc95c16e61b::bascule::Bascule) : (u64, vector<u8>, u32) {
        let v0 = 0x1::u256::try_as_u64(arg3);
        let v1 = 0x1::option::extract<u64>(&mut v0);
        let v2 = 0x2::bcs::to_bytes<u256>(&arg4);
        let v3 = 0x1::u256::try_as_u32(arg5);
        let v4 = 0x1::option::extract<u32>(&mut v3);
        assert!(v1 > 0, 6);
        assert!(arg2 != @0x0, 9);
        assert!(arg1 == get_chain_id<T0>(arg6), 8);
        assert!(arg0 == get_mint_action_bytes<T0>(arg6), 10);
        if (is_bascule_check_enabled<T0>(arg6)) {
            let v5 = LBTCWitness{dummy_field: false};
            0xff2c46f430582f4ea1842e584e7e6f99719d258c886b704509e65bc95c16e61b::bascule::validate_withdrawal<LBTCWitness>(v5, arg7, arg2, v1, v2, v4);
        };
        (v1, v2, v4)
    }

    public fun deconstruct<T0>(arg0: ControlledTreasury<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<T0>, 0x2::coin::DenyCapV2<T0>, 0x2::bag::Bag) {
        assert!(has_cap<T0, AdminCap>(&arg0, 0x2::tx_context::sender(arg1)), 0);
        let ControlledTreasury {
            id           : v0,
            admin_count  : _,
            treasury_cap : v2,
            deny_cap     : v3,
            roles        : v4,
        } = arg0;
        0x2::object::delete(v0);
        (v2, v3, v4)
    }

    public fun disable_global_pause<T0>(arg0: &mut ControlledTreasury<T0>, arg1: &mut 0x2::deny_list::DenyList, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) {
        0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::pk_util::validate_pks(&arg2);
        assert!(0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::multisig::is_sender_multisig(arg2, arg3, arg4, arg5), 5);
        assert!(has_cap<T0, PauserCap>(arg0, 0x2::tx_context::sender(arg5)), 0);
        0x2::coin::deny_list_v2_disable_global_pause<T0>(arg1, &mut arg0.deny_cap, arg5);
    }

    public fun disable_global_pause_v2<T0>(arg0: &mut ControlledTreasury<T0>, arg1: &mut 0x2::deny_list::DenyList, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, PauserCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        0x2::coin::deny_list_v2_disable_global_pause<T0>(arg1, &mut arg0.deny_cap, arg2);
    }

    public fun enable_global_pause<T0>(arg0: &mut ControlledTreasury<T0>, arg1: &mut 0x2::deny_list::DenyList, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) {
        0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::pk_util::validate_pks(&arg2);
        assert!(0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::multisig::is_sender_multisig(arg2, arg3, arg4, arg5), 5);
        assert!(has_cap<T0, PauserCap>(arg0, 0x2::tx_context::sender(arg5)), 0);
        0x2::coin::deny_list_v2_enable_global_pause<T0>(arg1, &mut arg0.deny_cap, arg5);
    }

    public fun enable_global_pause_v2<T0>(arg0: &mut ControlledTreasury<T0>, arg1: &mut 0x2::deny_list::DenyList, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, PauserCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        0x2::coin::deny_list_v2_enable_global_pause<T0>(arg1, &mut arg0.deny_cap, arg2);
    }

    public fun get_burn_commission<T0>(arg0: &ControlledTreasury<T0>) : u64 {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"burn_commission"), 18);
        *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"burn_commission")
    }

    fun get_cap<T0, T1: drop + store>(arg0: &ControlledTreasury<T0>, arg1: address) : &T1 {
        let v0 = RoleKey<T1>{owner: arg1};
        0x2::bag::borrow<RoleKey<T1>, T1>(&arg0.roles, v0)
    }

    fun get_cap_mut<T0, T1: drop + store>(arg0: &mut ControlledTreasury<T0>, arg1: address) : &mut T1 {
        let v0 = RoleKey<T1>{owner: arg1};
        0x2::bag::borrow_mut<RoleKey<T1>, T1>(&mut arg0.roles, v0)
    }

    public fun get_chain_id<T0>(arg0: &ControlledTreasury<T0>) : u256 {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"chain_id"), 23);
        *0x2::dynamic_field::borrow<vector<u8>, u256>(&arg0.id, b"chain_id")
    }

    public fun get_dust_fee_rate<T0>(arg0: &ControlledTreasury<T0>) : u64 {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"dust_fee_rate"), 17);
        *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"dust_fee_rate")
    }

    public fun get_fee_action_bytes<T0>(arg0: &ControlledTreasury<T0>) : u32 {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"fee_action_bytes"), 11);
        *0x2::dynamic_field::borrow<vector<u8>, u32>(&arg0.id, b"fee_action_bytes")
    }

    public fun get_mint_action_bytes<T0>(arg0: &ControlledTreasury<T0>) : u32 {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"mint_action_bytes"), 11);
        *0x2::dynamic_field::borrow<vector<u8>, u32>(&arg0.id, b"mint_action_bytes")
    }

    public fun get_mint_fee<T0>(arg0: &ControlledTreasury<T0>) : u64 {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"maximum_fee"), 20);
        *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"maximum_fee")
    }

    public fun get_package_id<T0>(arg0: &ControlledTreasury<T0>) : address {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"package_id"), 29);
        *0x2::dynamic_field::borrow<vector<u8>, address>(&arg0.id, b"package_id")
    }

    public fun get_treasury_address<T0>(arg0: &ControlledTreasury<T0>) : &address {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"treasury_address"), 16);
        0x2::dynamic_field::borrow<vector<u8>, address>(&arg0.id, b"treasury_address")
    }

    fun get_witness_cap<T0>(arg0: &ControlledTreasury<T0>, arg1: 0x1::ascii::String) : &MinterCap {
        let v0 = WitnessRoleKey<MinterCap>{owner: arg1};
        0x2::bag::borrow<WitnessRoleKey<MinterCap>, MinterCap>(&arg0.roles, v0)
    }

    fun get_witness_cap_mut<T0>(arg0: &mut ControlledTreasury<T0>, arg1: 0x1::ascii::String) : &mut MinterCap {
        let v0 = WitnessRoleKey<MinterCap>{owner: arg1};
        0x2::bag::borrow_mut<WitnessRoleKey<MinterCap>, MinterCap>(&mut arg0.roles, v0)
    }

    public fun get_witness_minter_cap_left<T0>(arg0: &ControlledTreasury<T0>, arg1: 0x1::ascii::String) : u64 {
        let v0 = WitnessRoleKey<MinterCap>{owner: arg1};
        assert!(0x2::bag::contains<WitnessRoleKey<MinterCap>>(&arg0.roles, v0), 0);
        get_witness_cap<T0>(arg0, arg1).left
    }

    public fun has_cap<T0, T1: store>(arg0: &ControlledTreasury<T0>, arg1: address) : bool {
        let v0 = RoleKey<T1>{owner: arg1};
        0x2::bag::contains<RoleKey<T1>>(&arg0.roles, v0)
    }

    public fun is_bascule_check_enabled<T0>(arg0: &ControlledTreasury<T0>) : bool {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"bascule_check"), 7);
        *0x2::dynamic_field::borrow<vector<u8>, bool>(&arg0.id, b"bascule_check")
    }

    public fun is_global_pause_enabled<T0>(arg0: &0x2::deny_list::DenyList) : bool {
        0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<T0>(arg0)
    }

    public fun is_payload_used<T0>(arg0: &ControlledTreasury<T0>, arg1: vector<u8>) : bool {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"used_payloads"), 27);
        0x2::table::contains<vector<u8>, bool>(0x2::dynamic_field::borrow<vector<u8>, 0x2::table::Table<vector<u8>, bool>>(&arg0.id, b"used_payloads"), arg1)
    }

    public fun is_withdrawal_enabled<T0>(arg0: &ControlledTreasury<T0>) : bool {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"withdrawal_enabled"), 19);
        *0x2::dynamic_field::borrow<vector<u8>, bool>(&arg0.id, b"withdrawal_enabled")
    }

    public fun list_roles<T0>(arg0: &ControlledTreasury<T0>, arg1: address) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        if (has_cap<T0, AdminCap>(arg0, arg1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"AdminCap"));
        };
        if (has_cap<T0, MinterCap>(arg0, arg1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"MinterCap"));
        };
        if (has_cap<T0, PauserCap>(arg0, arg1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"PauserCap"));
        };
        if (has_cap<T0, OperatorCap>(arg0, arg1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"OperatorCap"));
        };
        if (has_cap<T0, ClaimerCap>(arg0, arg1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"ClaimerCap"));
        };
        v0
    }

    public fun mint_and_transfer<T0>(arg0: &mut ControlledTreasury<T0>, arg1: u64, arg2: address, arg3: &0x2::deny_list::DenyList, arg4: vector<vector<u8>>, arg5: vector<u8>, arg6: u16, arg7: vector<u8>, arg8: u32, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 6);
        0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::pk_util::validate_pks(&arg4);
        assert!(0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::multisig::is_sender_multisig(arg4, arg5, arg6, arg9), 5);
        assert!(has_cap<T0, MinterCap>(arg0, 0x2::tx_context::sender(arg9)), 0);
        assert!(!is_global_pause_enabled<T0>(arg3), 4);
        let v0 = get_cap_mut<T0, MinterCap>(arg0, 0x2::tx_context::sender(arg9));
        let v1 = &mut v0.limit;
        let v2 = &mut v0.epoch;
        let v3 = &mut v0.left;
        if (0x2::tx_context::epoch(arg9) > *v2) {
            *v3 = *v1;
            *v2 = 0x2::tx_context::epoch(arg9);
        };
        assert!(arg1 <= *v3, 1);
        *v3 = *v3 - arg1;
        let v4 = MintEvent<T0>{
            amount : arg1,
            to     : arg2,
            tx_id  : arg7,
            index  : arg8,
        };
        0x2::event::emit<MintEvent<T0>>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg0.treasury_cap, arg1, arg9), arg2);
    }

    public fun mint_v2<T0>(arg0: &mut ControlledTreasury<T0>, arg1: &mut 0x2af188f9cc293640ced68e89a4c5773ee84702df3f10bcd080ccb894116398c3::consortium::Consortium, arg2: &0x2::deny_list::DenyList, arg3: &mut 0xff2c46f430582f4ea1842e584e7e6f99719d258c886b704509e65bc95c16e61b::bascule::Bascule, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!is_global_pause_enabled<T0>(arg2), 4);
        let v0 = 0x1::hash::sha2_256(arg4);
        assert!(!is_payload_used<T0>(arg0, v0), 26);
        0x2af188f9cc293640ced68e89a4c5773ee84702df3f10bcd080ccb894116398c3::consortium::validate_payload(arg1, arg4, arg5);
        let (v1, v2, v3, v4, v5, v6) = 0x2af188f9cc293640ced68e89a4c5773ee84702df3f10bcd080ccb894116398c3::payload_decoder::decode_mint_payload(arg4);
        let (v7, v8, v9) = assert_decoded_payload<T0>(v1, v2, v3, v4, v5, v6, arg0, arg3);
        0x2::table::add<vector<u8>, bool>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::table::Table<vector<u8>, bool>>(&mut arg0.id, b"used_payloads"), v0, true);
        let v10 = MintWithPayloadEvent<T0>{
            amount       : v7,
            to           : v3,
            tx_id        : v8,
            index        : v9,
            payload_hash : v0,
        };
        0x2::event::emit<MintWithPayloadEvent<T0>>(v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg0.treasury_cap, v7, arg6), v3);
    }

    public fun mint_with_fee<T0>(arg0: &mut ControlledTreasury<T0>, arg1: &mut 0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::consortium::Consortium, arg2: &0x2::deny_list::DenyList, arg3: &mut 0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::bascule::Bascule, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 9999
    }

    public fun mint_with_fee_v2<T0>(arg0: &mut ControlledTreasury<T0>, arg1: &mut 0x2af188f9cc293640ced68e89a4c5773ee84702df3f10bcd080ccb894116398c3::consortium::Consortium, arg2: &0x2::deny_list::DenyList, arg3: &mut 0xff2c46f430582f4ea1842e584e7e6f99719d258c886b704509e65bc95c16e61b::bascule::Bascule, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, ClaimerCap>(arg0, 0x2::tx_context::sender(arg10)), 0);
        assert!(!is_global_pause_enabled<T0>(arg2), 4);
        let v0 = 0x1::hash::sha2_256(arg4);
        assert!(!is_payload_used<T0>(arg0, v0), 26);
        0x2af188f9cc293640ced68e89a4c5773ee84702df3f10bcd080ccb894116398c3::consortium::validate_payload(arg1, arg4, arg5);
        let (v1, v2, v3, v4, v5, v6) = 0x2af188f9cc293640ced68e89a4c5773ee84702df3f10bcd080ccb894116398c3::payload_decoder::decode_mint_payload(arg4);
        let (v7, v8, v9) = assert_decoded_payload<T0>(v1, v2, v3, v4, v5, v6, arg0, arg3);
        assert!(0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::pk_util::validate_signature(arg7, arg8, &arg6) == true, 24);
        assert!(0x2::address::to_bytes(v3) == 0x2::hash::blake2b256(&arg8), 25);
        let (v10, v11, v12, v13, v14) = 0x2af188f9cc293640ced68e89a4c5773ee84702df3f10bcd080ccb894116398c3::payload_decoder::decode_fee_payload(arg6);
        let v15 = 0x1::u256::try_as_u64(v13);
        let v16 = 0x1::option::extract<u64>(&mut v15);
        let v17 = 0x1::u256::try_as_u64(v14);
        assert!(v11 == get_chain_id<T0>(arg0), 8);
        assert!(v12 == get_package_id<T0>(arg0), 28);
        assert!(v10 == get_fee_action_bytes<T0>(arg0), 10);
        assert!(v16 < v7, 22);
        assert!(0x1::option::extract<u64>(&mut v17) > 0x2::clock::timestamp_ms(arg9) / 1000, 21);
        let v18 = get_mint_fee<T0>(arg0);
        let v19 = v18;
        if (v18 > v16) {
            v19 = v16;
        };
        let v20 = v7 - v19;
        0x2::table::add<vector<u8>, bool>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::table::Table<vector<u8>, bool>>(&mut arg0.id, b"used_payloads"), v0, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg0.treasury_cap, v20, arg10), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg0.treasury_cap, v19, arg10), *get_treasury_address<T0>(arg0));
        let v21 = MintWithFeeEvent<T0>{
            amount       : v20,
            to           : v3,
            tx_id        : v8,
            index        : v9,
            fee          : v16,
            payload_hash : v0,
        };
        0x2::event::emit<MintWithFeeEvent<T0>>(v21);
    }

    public fun mint_with_witness<T0, T1: drop>(arg0: T1, arg1: &mut ControlledTreasury<T0>, arg2: u64, arg3: address, arg4: &0x2::deny_list::DenyList, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 6);
        let v0 = 0x1::type_name::get<T1>();
        assert!(witness_has_minter_cap<T0>(arg1, 0x1::type_name::into_string(v0)), 0);
        assert!(!is_global_pause_enabled<T0>(arg4), 4);
        let v1 = get_witness_cap_mut<T0>(arg1, 0x1::type_name::into_string(v0));
        let v2 = &mut v1.limit;
        let v3 = &mut v1.epoch;
        let v4 = &mut v1.left;
        if (0x2::tx_context::epoch(arg5) > *v3) {
            *v4 = *v2;
            *v3 = 0x2::tx_context::epoch(arg5);
        };
        assert!(arg2 <= *v4, 1);
        *v4 = *v4 - arg2;
        let v5 = MintWithWitnessEvent<T0>{
            amount : arg2,
            to     : arg3,
        };
        0x2::event::emit<MintWithWitnessEvent<T0>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg1.treasury_cap, arg2, arg5), arg3);
    }

    public fun new_admin_cap() : AdminCap {
        AdminCap{dummy_field: false}
    }

    public fun new_claimer_cap() : ClaimerCap {
        ClaimerCap{dummy_field: false}
    }

    public fun new_minter_cap(arg0: u64, arg1: &0x2::tx_context::TxContext) : MinterCap {
        assert!(arg0 > 0, 6);
        MinterCap{
            limit : arg0,
            epoch : 0x2::tx_context::epoch(arg1),
            left  : arg0,
        }
    }

    public fun new_operator_cap() : OperatorCap {
        OperatorCap{dummy_field: false}
    }

    public fun new_pauser_cap() : PauserCap {
        PauserCap{dummy_field: false}
    }

    public fun redeem<T0>(arg0: &mut ControlledTreasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::bitcoin_utils::get_output_type(&arg2);
        assert!(v0 != 0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::bitcoin_utils::get_unsupported_output_type(), 12);
        assert!(is_withdrawal_enabled<T0>(arg0), 13);
        let v1 = get_burn_commission<T0>(arg0);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 > v1, 15);
        let v3 = v2 - v1;
        assert!(v3 >= 0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::bitcoin_utils::get_dust_limit_for_output(v0, &arg2, get_dust_fee_rate<T0>(arg0)), 14);
        0x2::pay::split_and_transfer<T0>(&mut arg1, v1, *get_treasury_address<T0>(arg0), arg3);
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg1);
        let v4 = UnstakeRequestEvent<T0>{
            from             : 0x2::tx_context::sender(arg3),
            script_pubkey    : arg2,
            amount_after_fee : v3,
        };
        0x2::event::emit<UnstakeRequestEvent<T0>>(v4);
    }

    fun remove_cap<T0, T1: drop + store>(arg0: &mut ControlledTreasury<T0>, arg1: address) : T1 {
        let v0 = RoleKey<T1>{owner: arg1};
        0x2::bag::remove<RoleKey<T1>, T1>(&mut arg0.roles, v0)
    }

    public fun remove_capability<T0, T1: drop + store>(arg0: &mut ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, AdminCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        assert!(has_cap<T0, T1>(arg0, arg1), 0);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<AdminCap>()) {
            assert!(arg0.admin_count > 1, 3);
            arg0.admin_count = arg0.admin_count - 1;
        };
        remove_cap<T0, T1>(arg0, arg1);
    }

    public fun remove_witness_mint_capability<T0>(arg0: &mut ControlledTreasury<T0>, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, AdminCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        assert!(witness_has_minter_cap<T0>(arg0, arg1), 0);
        remove_witness_minter_cap<T0>(arg0, arg1);
    }

    fun remove_witness_minter_cap<T0>(arg0: &mut ControlledTreasury<T0>, arg1: 0x1::ascii::String) : MinterCap {
        let v0 = WitnessRoleKey<MinterCap>{owner: arg1};
        0x2::bag::remove<WitnessRoleKey<MinterCap>, MinterCap>(&mut arg0.roles, v0)
    }

    public fun set_burn_commission<T0>(arg0: &mut ControlledTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, AdminCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"burn_commission")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, b"burn_commission") = arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, b"burn_commission", arg1);
        };
        let v0 = BurnCommissionEvent{burn_commission: arg1};
        0x2::event::emit<BurnCommissionEvent>(v0);
    }

    public fun set_chain_id<T0>(arg0: &mut ControlledTreasury<T0>, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, AdminCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"chain_id")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u256>(&mut arg0.id, b"chain_id") = arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u256>(&mut arg0.id, b"chain_id", arg1);
        };
        let v0 = ChainIdEvent{chain_id: arg1};
        0x2::event::emit<ChainIdEvent>(v0);
    }

    public fun set_dust_fee_rate<T0>(arg0: &mut ControlledTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, AdminCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"dust_fee_rate")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, b"dust_fee_rate") = arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, b"dust_fee_rate", arg1);
        };
        let v0 = DustFeeRateEvent{dust_fee_rate: arg1};
        0x2::event::emit<DustFeeRateEvent>(v0);
    }

    public fun set_fee_action_bytes<T0>(arg0: &mut ControlledTreasury<T0>, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, AdminCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"fee_action_bytes")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u32>(&mut arg0.id, b"fee_action_bytes") = arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u32>(&mut arg0.id, b"fee_action_bytes", arg1);
        };
        let v0 = FeeActionBytesEvent{action_bytes: arg1};
        0x2::event::emit<FeeActionBytesEvent>(v0);
    }

    public fun set_mint_action_bytes<T0>(arg0: &mut ControlledTreasury<T0>, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, AdminCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"mint_action_bytes")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u32>(&mut arg0.id, b"mint_action_bytes") = arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u32>(&mut arg0.id, b"mint_action_bytes", arg1);
        };
        let v0 = MintActionBytesEvent{action_bytes: arg1};
        0x2::event::emit<MintActionBytesEvent>(v0);
    }

    public fun set_mint_fee<T0>(arg0: &mut ControlledTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, OperatorCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"maximum_fee")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, b"maximum_fee") = arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, b"maximum_fee", arg1);
        };
        let v0 = MintFeeEvent{maximum_fee: arg1};
        0x2::event::emit<MintFeeEvent>(v0);
    }

    public fun set_package_id<T0>(arg0: &mut ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, AdminCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"package_id")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, address>(&mut arg0.id, b"package_id") = arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, address>(&mut arg0.id, b"package_id", arg1);
        };
        let v0 = PackageIdEvent{package_id: arg1};
        0x2::event::emit<PackageIdEvent>(v0);
    }

    public fun set_payload_table<T0>(arg0: &mut ControlledTreasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, AdminCap>(arg0, 0x2::tx_context::sender(arg1)), 0);
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"used_payloads"), 2);
        0x2::dynamic_field::add<vector<u8>, 0x2::table::Table<vector<u8>, bool>>(&mut arg0.id, b"used_payloads", 0x2::table::new<vector<u8>, bool>(arg1));
    }

    public fun set_treasury_address<T0>(arg0: &mut ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, AdminCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"treasury_address")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, address>(&mut arg0.id, b"treasury_address") = arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, address>(&mut arg0.id, b"treasury_address", arg1);
        };
        let v0 = TreasuryAddressEvent{treasury_address: arg1};
        0x2::event::emit<TreasuryAddressEvent>(v0);
    }

    public fun share<T0>(arg0: ControlledTreasury<T0>) {
        0x2::transfer::share_object<ControlledTreasury<T0>>(arg0);
    }

    public fun toggle_bascule_check<T0>(arg0: &mut ControlledTreasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, AdminCap>(arg0, 0x2::tx_context::sender(arg1)), 0);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"bascule_check")) {
            let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, bool>(&mut arg0.id, b"bascule_check");
            *v0 = !*v0;
        } else {
            0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, b"bascule_check", true);
        };
        let v1 = BasculeCheckEvent{bascule_check: is_bascule_check_enabled<T0>(arg0)};
        0x2::event::emit<BasculeCheckEvent>(v1);
    }

    public fun toggle_withdrawal<T0>(arg0: &mut ControlledTreasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, AdminCap>(arg0, 0x2::tx_context::sender(arg1)), 0);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"withdrawal_enabled")) {
            let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, bool>(&mut arg0.id, b"withdrawal_enabled");
            *v0 = !*v0;
        } else {
            0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, b"withdrawal_enabled", true);
        };
        let v1 = WithdrawalEnabledEvent{withdrawal_enabled: is_withdrawal_enabled<T0>(arg0)};
        0x2::event::emit<WithdrawalEnabledEvent>(v1);
    }

    public fun witness_has_minter_cap<T0>(arg0: &ControlledTreasury<T0>, arg1: 0x1::ascii::String) : bool {
        let v0 = WitnessRoleKey<MinterCap>{owner: arg1};
        0x2::bag::contains<WitnessRoleKey<MinterCap>>(&arg0.roles, v0)
    }

    // decompiled from Move bytecode v6
}

