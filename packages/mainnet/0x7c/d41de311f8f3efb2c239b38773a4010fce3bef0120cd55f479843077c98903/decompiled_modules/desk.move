module 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk {
    struct OrderDesk has key {
        id: 0x2::object::UID,
        policy: 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::DelayedExecutionPolicy,
        version_watermark: u64,
    }

    struct QueueRegistry has key {
        id: 0x2::object::UID,
        desk_id: 0x2::object::ID,
    }

    public fun set_limits(arg0: &mut OrderDesk, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock) {
        assert_admin_allowed(arg0, arg2);
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::set_limits(&mut arg0.policy, arg3, arg4, arg5, arg6, arg7, arg8);
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue_events::emit_policy_updated(id(arg0), arg0.policy, 0x2::clock::timestamp_ms(arg9));
    }

    public fun set_order_fee(arg0: &mut OrderDesk, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_admin_allowed(arg0, arg2);
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::set_order_fee(&mut arg0.policy, arg3);
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue_events::emit_policy_updated(id(arg0), arg0.policy, 0x2::clock::timestamp_ms(arg4));
    }

    public fun set_timing(arg0: &mut OrderDesk, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: u64, arg10: &0x2::clock::Clock) {
        assert_admin_allowed(arg0, arg2);
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::set_timing(&mut arg0.policy, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue_events::emit_policy_updated(id(arg0), arg0.policy, 0x2::clock::timestamp_ms(arg10));
    }

    fun assert_admin_allowed(arg0: &OrderDesk, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig) {
        assert_version(arg0);
        assert!(!0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::frozen(arg1), 2);
    }

    public(friend) fun assert_version(arg0: &OrderDesk) {
        assert!(1 >= arg0.version_watermark, 0);
    }

    public fun bump_version_watermark(arg0: &mut OrderDesk, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap) {
        let v0 = 1;
        assert!(v0 > arg0.version_watermark, 1);
        arg0.version_watermark = v0;
    }

    public fun id(arg0: &OrderDesk) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OrderDesk{
            id                : 0x2::object::new(arg0),
            policy            : 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::new(),
            version_watermark : 1,
        };
        let v1 = QueueRegistry{
            id      : 0x2::object::new(arg0),
            desk_id : id(&v0),
        };
        0x2::transfer::share_object<QueueRegistry>(v1);
        0x2::transfer::share_object<OrderDesk>(v0);
    }

    public fun policy(arg0: &OrderDesk) : 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::DelayedExecutionPolicy {
        arg0.policy
    }

    public(friend) fun policy_ref(arg0: &OrderDesk) : &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::DelayedExecutionPolicy {
        &arg0.policy
    }

    public(friend) fun registry_desk_id(arg0: &QueueRegistry) : 0x2::object::ID {
        arg0.desk_id
    }

    public fun registry_id(arg0: &QueueRegistry) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun registry_uid_mut(arg0: &mut QueueRegistry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun version_watermark(arg0: &OrderDesk) : u64 {
        arg0.version_watermark
    }

    // decompiled from Move bytecode v7
}

