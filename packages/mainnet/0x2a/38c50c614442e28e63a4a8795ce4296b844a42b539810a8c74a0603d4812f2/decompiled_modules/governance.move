module 0x2a38c50c614442e28e63a4a8795ce4296b844a42b539810a8c74a0603d4812f2::governance {
    struct GovernanceActionExecuted has copy, drop {
        action: u8,
        vaa_digest: address,
    }

    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    struct GovernanceDecree {
        action: u8,
        payload: vector<u8>,
    }

    struct AdminCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct UpgradeCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DeployerCap has store, key {
        id: 0x2::object::UID,
    }

    struct GovernanceState has key {
        id: 0x2::object::UID,
        consumed_vaas: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::ConsumedVAAs,
    }

    public fun create(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::assert_package_upgrade_cap<DeployerCap>(&arg1, 0x2::package::compatible_policy(), 1);
        0x2::package::make_immutable(arg1);
        let v1 = GovernanceState{
            id            : 0x2::object::new(arg2),
            consumed_vaas : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::new(arg2),
        };
        0x2::transfer::share_object<GovernanceState>(v1);
    }

    public fun execute_authorize_upgrade(arg0: &mut GovernanceState, arg1: GovernanceDecree) : 0x2::package::UpgradeTicket {
        let GovernanceDecree {
            action  : v0,
            payload : v1,
        } = arg1;
        assert!(v0 == 10, 13906836313237749771);
        let v2 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(v1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v2);
        let v3 = UpgradeCapKey{dummy_field: false};
        0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::upgrades::authorize_upgrade(0x2::dynamic_object_field::borrow_mut<UpgradeCapKey, 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::upgrades::UpgradeCap>(&mut arg0.id, v3), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v2, 32))
    }

    public fun execute_commit_upgrade<T0>(arg0: &mut GovernanceState, arg1: &mut 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::State<T0>, arg2: 0x2::package::UpgradeReceipt) {
        let v0 = UpgradeCapKey{dummy_field: false};
        0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::upgrades::commit_upgrade<T0>(0x2::dynamic_object_field::borrow_mut<UpgradeCapKey, 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::upgrades::UpgradeCap>(&mut arg0.id, v0), arg1, arg2);
    }

    public fun execute_disable_transceiver<T0>(arg0: &mut GovernanceState, arg1: &mut 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::State<T0>, arg2: GovernanceDecree) {
        let GovernanceDecree {
            action  : v0,
            payload : v1,
        } = arg2;
        assert!(v0 == 9, 13906836231633371147);
        let v2 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(v1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v2);
        let v3 = AdminCapKey{dummy_field: false};
        0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::disable_transceiver<T0>(arg1, 0x2::dynamic_object_field::borrow<AdminCapKey, 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::AdminCap>(&arg0.id, v3), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v2));
    }

    public fun execute_enable_transceiver<T0>(arg0: &mut GovernanceState, arg1: &mut 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::State<T0>, arg2: GovernanceDecree) {
        let GovernanceDecree {
            action  : v0,
            payload : v1,
        } = arg2;
        assert!(v0 == 8, 13906836154323959819);
        let v2 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(v1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v2);
        let v3 = AdminCapKey{dummy_field: false};
        0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::enable_transceiver<T0>(arg1, 0x2::dynamic_object_field::borrow<AdminCapKey, 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::AdminCap>(&arg0.id, v3), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v2));
    }

    public fun execute_pause<T0>(arg0: &mut GovernanceState, arg1: &mut 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::State<T0>, arg2: GovernanceDecree) {
        let GovernanceDecree {
            action  : v0,
            payload : v1,
        } = arg2;
        assert!(v0 == 5, 13906835870856118283);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(v1));
        let v2 = AdminCapKey{dummy_field: false};
        0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::pause<T0>(0x2::dynamic_object_field::borrow<AdminCapKey, 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::AdminCap>(&arg0.id, v2), arg1);
    }

    public fun execute_register_transceiver<T0, T1>(arg0: &mut GovernanceState, arg1: &mut 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::State<T1>, arg2: GovernanceDecree) {
        let GovernanceDecree {
            action  : v0,
            payload : v1,
        } = arg2;
        assert!(v0 == 7, 13906836025474940939);
        let v2 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(v1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v2);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v2, (0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v2) as u64)) == 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), 13906836077014024195);
        let v3 = AdminCapKey{dummy_field: false};
        0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::register_transceiver<T0, T1>(arg1, 0x2::object::id_from_address(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::to_address(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::take_bytes(&mut v2))), 0x2::dynamic_object_field::borrow<AdminCapKey, 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::AdminCap>(&arg0.id, v3));
    }

    public fun execute_set_inbound_limit<T0>(arg0: &mut GovernanceState, arg1: &mut 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::State<T0>, arg2: GovernanceDecree, arg3: &0x2::clock::Clock) {
        let GovernanceDecree {
            action  : v0,
            payload : v1,
        } = arg2;
        assert!(v0 == 4, 13906835759186968587);
        let v2 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(v1);
        let v3 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v2);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v2);
        let v4 = 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::borrow_peer<T0>(arg1, v3);
        let v5 = AdminCapKey{dummy_field: false};
        0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::set_peer<T0>(0x2::dynamic_object_field::borrow<AdminCapKey, 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::AdminCap>(&arg0.id, v5), arg1, v3, *0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::peer::borrow_address(v4), 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::peer::get_token_decimals(v4), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut v2), arg3);
    }

    public fun execute_set_outbound_limit<T0>(arg0: &mut GovernanceState, arg1: &mut 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::State<T0>, arg2: GovernanceDecree, arg3: &0x2::clock::Clock) {
        let GovernanceDecree {
            action  : v0,
            payload : v1,
        } = arg2;
        assert!(v0 == 3, 13906835673287622667);
        let v2 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(v1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v2);
        let v3 = AdminCapKey{dummy_field: false};
        0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::set_outbound_rate_limit<T0>(0x2::dynamic_object_field::borrow<AdminCapKey, 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::AdminCap>(&arg0.id, v3), arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut v2), arg3);
    }

    public fun execute_set_peer<T0>(arg0: &mut GovernanceState, arg1: &mut 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::State<T0>, arg2: GovernanceDecree, arg3: &0x2::clock::Clock) {
        let GovernanceDecree {
            action  : v0,
            payload : v1,
        } = arg2;
        assert!(v0 == 1, 13906835467129192459);
        let v2 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(v1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v2);
        let v3 = AdminCapKey{dummy_field: false};
        0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::set_peer<T0>(0x2::dynamic_object_field::borrow<AdminCapKey, 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::AdminCap>(&arg0.id, v3), arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v2), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_bytes(&mut v2), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v2), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut v2), arg3);
    }

    public fun execute_set_threshold<T0>(arg0: &mut GovernanceState, arg1: &mut 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::State<T0>, arg2: GovernanceDecree) {
        let GovernanceDecree {
            action  : v0,
            payload : v1,
        } = arg2;
        assert!(v0 == 2, 13906835591683244043);
        let v2 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(v1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v2);
        let v3 = AdminCapKey{dummy_field: false};
        0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::set_threshold<T0>(0x2::dynamic_object_field::borrow<AdminCapKey, 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::AdminCap>(&arg0.id, v3), arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v2));
    }

    public fun execute_transfer_ownership(arg0: &mut GovernanceState, arg1: GovernanceDecree) {
        let GovernanceDecree {
            action  : v0,
            payload : v1,
        } = arg1;
        assert!(v0 == 11, 13906836485036441611);
        let v2 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(v1);
        let v3 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::to_address(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::take_bytes(&mut v2));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v2);
        let v4 = AdminCapKey{dummy_field: false};
        let v5 = 0x2::dynamic_object_field::exists_<AdminCapKey>(&arg0.id, v4);
        let v6 = UpgradeCapKey{dummy_field: false};
        let v7 = 0x2::dynamic_object_field::exists_<UpgradeCapKey>(&arg0.id, v6);
        assert!(v5 || v7, 13906836519396048905);
        if (v5) {
            let v8 = AdminCapKey{dummy_field: false};
            0x2::transfer::public_transfer<0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::AdminCap>(0x2::dynamic_object_field::remove<AdminCapKey, 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::AdminCap>(&mut arg0.id, v8), v3);
        };
        if (v7) {
            let v9 = UpgradeCapKey{dummy_field: false};
            0x2::transfer::public_transfer<0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::upgrades::UpgradeCap>(0x2::dynamic_object_field::remove<UpgradeCapKey, 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::upgrades::UpgradeCap>(&mut arg0.id, v9), v3);
        };
    }

    public fun execute_unpause<T0>(arg0: &mut GovernanceState, arg1: &mut 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::State<T0>, arg2: GovernanceDecree) {
        let GovernanceDecree {
            action  : v0,
            payload : v1,
        } = arg2;
        assert!(v0 == 6, 13906835943870562315);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(v1));
        let v2 = AdminCapKey{dummy_field: false};
        0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::unpause<T0>(0x2::dynamic_object_field::borrow<AdminCapKey, 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::AdminCap>(&arg0.id, v2), arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun parse_governance_payload(arg0: &GovernanceState, arg1: vector<u8>) : (u8, vector<u8>) {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg1);
        assert!(0x2::object::id_from_address(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::to_address(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::take_bytes(&mut v0))) == 0x2::object::id<GovernanceState>(arg0), 13906835398409060353);
        (0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v0))
    }

    public fun receive_admin_cap(arg0: &mut GovernanceState, arg1: 0x2::transfer::Receiving<0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::AdminCap>) {
        let v0 = AdminCapKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists_<AdminCapKey>(&arg0.id, v0), 13906835071991808005);
        let v1 = AdminCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<AdminCapKey, 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::AdminCap>(&mut arg0.id, v1, 0x2::transfer::public_receive<0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::state::AdminCap>(&mut arg0.id, arg1));
    }

    public fun receive_upgrade_cap(arg0: &mut GovernanceState, arg1: 0x2::transfer::Receiving<0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::upgrades::UpgradeCap>) {
        let v0 = UpgradeCapKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists_<UpgradeCapKey>(&arg0.id, v0), 13906835149301350407);
        let v1 = UpgradeCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<UpgradeCapKey, 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::upgrades::UpgradeCap>(&mut arg0.id, v1, 0x2::transfer::public_receive<0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::upgrades::UpgradeCap>(&mut arg0.id, arg1));
    }

    public fun verify_and_consume(arg0: &mut GovernanceState, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA) : GovernanceDecree {
        let v0 = GovernanceWitness{dummy_field: false};
        let (v1, v2) = parse_governance_payload(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::take_payload<GovernanceWitness>(&mut arg0.consumed_vaas, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::verify_vaa<GovernanceWitness>(arg1, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::authorize_verify_local<GovernanceWitness>(v0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::governance_chain(arg1), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::governance_contract(arg1), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(b"GeneralPurposeGovernance"), 3))));
        let v3 = GovernanceActionExecuted{
            action     : v1,
            vaa_digest : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::to_address(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&arg2)),
        };
        0x2::event::emit<GovernanceActionExecuted>(v3);
        GovernanceDecree{
            action  : v1,
            payload : v2,
        }
    }

    // decompiled from Move bytecode v6
}

