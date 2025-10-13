module 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::manage {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        init: bool,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct ACL has store, key {
        id: 0x2::object::UID,
        minor_signs: vector<address>,
        breakers: vector<address>,
        robots: vector<address>,
    }

    public entry fun add_breaker_to_acl(arg0: &AdminCap, arg1: &mut ACL, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg1.breakers, &arg2), 2);
        0x1::vector::push_back<address>(&mut arg1.breakers, arg2);
    }

    public entry fun add_minor_signs_to_acl(arg0: &AdminCap, arg1: &mut ACL, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg1.minor_signs, &arg2), 2);
        0x1::vector::push_back<address>(&mut arg1.minor_signs, arg2);
    }

    public entry fun add_robot_to_acl(arg0: &AdminCap, arg1: &mut ACL, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg1.robots, &arg2), 2);
        0x1::vector::push_back<address>(&mut arg1.robots, arg2);
    }

    public entry fun claim_collect_protocol_fee_v2(arg0: &AdminCap, arg1: &mut 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::assert_version(arg1);
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::claim_collect_protocol_fee(arg1, arg2, arg3);
    }

    public entry fun claim_collect_rewards_fee(arg0: &AdminCap, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg3: &mut 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::assert_version(arg3);
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::claim_collect_rewards_fee(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun claim_collect_rewards_fee_v2(arg0: &AdminCap, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg3: &mut 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::assert_version(arg3);
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::claim_collect_rewards_fee(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun del_breaker_to_acl(arg0: &AdminCap, arg1: &mut ACL, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.breakers, &arg2);
        assert!(v0, 3);
        0x1::vector::remove<address>(&mut arg1.breakers, v1);
    }

    public entry fun del_minor_signs(arg0: &AdminCap, arg1: &mut ACL, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.minor_signs, &arg2);
        assert!(v0, 3);
        0x1::vector::remove<address>(&mut arg1.minor_signs, v1);
    }

    public entry fun del_robot_to_acl(arg0: &AdminCap, arg1: &mut ACL, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.robots, &arg2);
        assert!(v0, 3);
        0x1::vector::remove<address>(&mut arg1.robots, v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id   : 0x2::object::new(arg0),
            init : false,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize(arg0: &mut AdminCap, arg1: 0x2::coin::TreasuryCap<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.init, 1);
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::initialize(arg1, arg2);
        arg0.init = true;
    }

    public entry fun is_breaker(arg0: &ACL, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.breakers, &arg1)
    }

    public entry fun is_minor_sign(arg0: &ACL, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.minor_signs, &arg1)
    }

    public entry fun is_robot(arg0: &ACL, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.robots, &arg1)
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking) {
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::migrate(arg1);
    }

    public entry fun request_collect_rewards_fee(arg0: &AdminCap, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg3: &mut 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun set_deposit_fee_v2(arg0: &AdminCap, arg1: &mut 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg2: u64) {
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::assert_version(arg1);
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::config::set_deposit_fee(0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_config_mut(arg1), arg2);
    }

    public entry fun set_operator_cap_to_address(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<OperatorCap>(v0, arg1);
    }

    public entry fun set_reward_fee_v2(arg0: &AdminCap, arg1: &mut 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg2: u64) {
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::assert_version(arg1);
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::config::set_reward_fee(0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_config_mut(arg1), arg2);
    }

    public entry fun set_service_fee_v2(arg0: &AdminCap, arg1: &mut 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg2: u64) {
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::assert_version(arg1);
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::config::set_service_fee(0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_config_mut(arg1), arg2);
    }

    public entry fun set_validator_reward_fee_v2(arg0: &AdminCap, arg1: &mut 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg2: u64) {
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::assert_version(arg1);
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::config::set_validator_reward_fee(0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_config_mut(arg1), arg2);
    }

    public entry fun share_acl(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ACL{
            id          : 0x2::object::new(arg1),
            minor_signs : 0x1::vector::empty<address>(),
            breakers    : 0x1::vector::empty<address>(),
            robots      : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<ACL>(v0);
    }

    // decompiled from Move bytecode v6
}

