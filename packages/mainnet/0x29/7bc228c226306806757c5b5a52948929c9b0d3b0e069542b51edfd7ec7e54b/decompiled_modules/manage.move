module 0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::manage {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        init: bool,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun claim_collect_rewards_fee(arg0: &AdminCap, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg3: &mut 0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::walstaking::Staking, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::walstaking::assert_version(arg3);
        0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::walstaking::claim_collect_rewards_fee(arg1, arg2, arg3, arg4, arg5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id   : 0x2::object::new(arg0),
            init : false,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize(arg0: &mut AdminCap, arg1: 0x2::coin::TreasuryCap<0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::hawal::HAWAL>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.init, 1);
        0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::walstaking::initialize(arg1, arg2);
        arg0.init = true;
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut 0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::walstaking::Staking) {
        0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::walstaking::migrate(arg1);
    }

    public entry fun request_collect_rewards_fee(arg0: &AdminCap, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg3: &mut 0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::walstaking::Staking, arg4: &mut 0x2::tx_context::TxContext) {
        0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::walstaking::assert_version(arg3);
        0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::walstaking::request_collect_rewards_fee(arg1, arg2, arg3, arg4);
    }

    public entry fun set_operator_cap_to_address(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<OperatorCap>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

