module 0xdc8c6bee94f44ff0204ae9c6cdf370c6e24e0b774bb665ac614c47ab3dfac06e::mirror {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        paused: bool,
        total_positions: u64,
        total_orders: u64,
        version: u64,
    }

    struct MirrorPosition has store, key {
        id: 0x2::object::UID,
        owner: address,
        target_maker: address,
        ratio: u64,
        pool_id: 0x2::object::ID,
        active_orders: vector<u128>,
        total_orders_placed: u64,
        created_at: u64,
        updated_at: u64,
        active: bool,
    }

    struct MirrorCapability has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        authorized_operator: address,
        max_order_size: u64,
        expires_at: u64,
    }

    struct PositionCreated has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        target_maker: address,
        ratio: u64,
        pool_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct PositionUpdated has copy, drop {
        position_id: 0x2::object::ID,
        old_ratio: u64,
        new_ratio: u64,
        timestamp: u64,
    }

    struct OrderRecorded has copy, drop {
        position_id: 0x2::object::ID,
        order_id: u128,
        timestamp: u64,
    }

    struct OrderRemoved has copy, drop {
        position_id: 0x2::object::ID,
        order_id: u128,
        timestamp: u64,
    }

    struct PositionStatusChanged has copy, drop {
        position_id: 0x2::object::ID,
        active: bool,
        timestamp: u64,
    }

    struct PositionClosed has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct ProtocolPaused has copy, drop {
        paused: bool,
        timestamp: u64,
    }

    struct CapabilityGranted has copy, drop {
        capability_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        operator: address,
        max_order_size: u64,
        expires_at: u64,
        timestamp: u64,
    }

    struct CapabilityRevoked has copy, drop {
        capability_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        operator: address,
        timestamp: u64,
    }

    public fun active_order_count(arg0: &MirrorPosition) : u64 {
        0x1::vector::length<u128>(&arg0.active_orders)
    }

    public fun active_orders(arg0: &MirrorPosition) : &vector<u128> {
        &arg0.active_orders
    }

    public fun capability_expires_at(arg0: &MirrorCapability) : u64 {
        arg0.expires_at
    }

    public fun capability_max_order_size(arg0: &MirrorCapability) : u64 {
        arg0.max_order_size
    }

    public fun capability_operator(arg0: &MirrorCapability) : address {
        arg0.authorized_operator
    }

    public fun capability_position_id(arg0: &MirrorCapability) : 0x2::object::ID {
        arg0.position_id
    }

    public fun clear_orders(arg0: &mut MirrorPosition, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        arg0.active_orders = vector[];
        arg0.updated_at = 0x2::clock::timestamp_ms(arg1);
    }

    public fun clear_orders_with_capability(arg0: &MirrorCapability, arg1: &mut MirrorPosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.authorized_operator, 8);
        assert!(arg0.position_id == 0x2::object::uid_to_inner(&arg1.id), 2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0.expires_at > 0) {
            assert!(v0 <= arg0.expires_at, 9);
        };
        arg1.active_orders = vector[];
        arg1.updated_at = v0;
    }

    public fun close_position(arg0: MirrorPosition, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        assert!(0x1::vector::is_empty<u128>(&arg0.active_orders), 3);
        let v0 = PositionClosed{
            position_id : 0x2::object::uid_to_inner(&arg0.id),
            owner       : arg0.owner,
            timestamp   : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<PositionClosed>(v0);
        let MirrorPosition {
            id                  : v1,
            owner               : _,
            target_maker        : _,
            ratio               : _,
            pool_id             : _,
            active_orders       : _,
            total_orders_placed : _,
            created_at          : _,
            updated_at          : _,
            active              : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun create_position(arg0: &mut ProtocolConfig, arg1: address, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : MirrorPosition {
        assert!(!arg0.paused, 6);
        assert!(arg2 >= 1 && arg2 <= 100, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x2::object::new(arg5);
        arg0.total_positions = arg0.total_positions + 1;
        let v3 = MirrorPosition{
            id                  : v2,
            owner               : v0,
            target_maker        : arg1,
            ratio               : arg2,
            pool_id             : arg3,
            active_orders       : vector[],
            total_orders_placed : 0,
            created_at          : v1,
            updated_at          : v1,
            active              : true,
        };
        let v4 = PositionCreated{
            position_id  : 0x2::object::uid_to_inner(&v2),
            owner        : v0,
            target_maker : arg1,
            ratio        : arg2,
            pool_id      : arg3,
            timestamp    : v1,
        };
        0x2::event::emit<PositionCreated>(v4);
        v3
    }

    public fun created_at(arg0: &MirrorPosition) : u64 {
        arg0.created_at
    }

    public fun grant_capability(arg0: &MirrorPosition, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : MirrorCapability {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 2);
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = MirrorCapability{
            id                  : v0,
            position_id         : v1,
            authorized_operator : arg1,
            max_order_size      : arg2,
            expires_at          : arg3,
        };
        let v3 = CapabilityGranted{
            capability_id  : 0x2::object::uid_to_inner(&v0),
            position_id    : v1,
            operator       : arg1,
            max_order_size : arg2,
            expires_at     : arg3,
            timestamp      : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CapabilityGranted>(v3);
        v2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = ProtocolConfig{
            id              : 0x2::object::new(arg0),
            paused          : false,
            total_positions : 0,
            total_orders    : 0,
            version         : 1,
        };
        0x2::transfer::share_object<ProtocolConfig>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_active(arg0: &MirrorPosition) : bool {
        arg0.active
    }

    public fun owner(arg0: &MirrorPosition) : address {
        arg0.owner
    }

    public fun pool_id(arg0: &MirrorPosition) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun protocol_paused(arg0: &ProtocolConfig) : bool {
        arg0.paused
    }

    public fun protocol_version(arg0: &ProtocolConfig) : u64 {
        arg0.version
    }

    public fun ratio(arg0: &MirrorPosition) : u64 {
        arg0.ratio
    }

    public fun record_order(arg0: &mut ProtocolConfig, arg1: &mut MirrorPosition, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 2);
        assert!(!arg0.paused, 6);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        0x1::vector::push_back<u128>(&mut arg1.active_orders, arg2);
        arg1.total_orders_placed = arg1.total_orders_placed + 1;
        arg1.updated_at = v0;
        arg0.total_orders = arg0.total_orders + 1;
        let v1 = OrderRecorded{
            position_id : 0x2::object::uid_to_inner(&arg1.id),
            order_id    : arg2,
            timestamp   : v0,
        };
        0x2::event::emit<OrderRecorded>(v1);
    }

    public fun record_order_with_capability(arg0: &MirrorCapability, arg1: &mut ProtocolConfig, arg2: &mut MirrorPosition, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.authorized_operator, 8);
        assert!(arg0.position_id == 0x2::object::uid_to_inner(&arg2.id), 2);
        assert!(!arg1.paused, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (arg0.expires_at > 0) {
            assert!(v0 <= arg0.expires_at, 9);
        };
        0x1::vector::push_back<u128>(&mut arg2.active_orders, arg3);
        arg2.total_orders_placed = arg2.total_orders_placed + 1;
        arg2.updated_at = v0;
        arg1.total_orders = arg1.total_orders + 1;
        let v1 = OrderRecorded{
            position_id : 0x2::object::uid_to_inner(&arg2.id),
            order_id    : arg3,
            timestamp   : v0,
        };
        0x2::event::emit<OrderRecorded>(v1);
    }

    public fun remove_order(arg0: &mut MirrorPosition, arg1: u128, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        let (v0, v1) = 0x1::vector::index_of<u128>(&arg0.active_orders, &arg1);
        assert!(v0, 4);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        0x1::vector::remove<u128>(&mut arg0.active_orders, v1);
        arg0.updated_at = v2;
        let v3 = OrderRemoved{
            position_id : 0x2::object::uid_to_inner(&arg0.id),
            order_id    : arg1,
            timestamp   : v2,
        };
        0x2::event::emit<OrderRemoved>(v3);
    }

    public fun remove_order_with_capability(arg0: &MirrorCapability, arg1: &mut MirrorPosition, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.authorized_operator, 8);
        assert!(arg0.position_id == 0x2::object::uid_to_inner(&arg1.id), 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (arg0.expires_at > 0) {
            assert!(v0 <= arg0.expires_at, 9);
        };
        let (v1, v2) = 0x1::vector::index_of<u128>(&arg1.active_orders, &arg2);
        assert!(v1, 4);
        0x1::vector::remove<u128>(&mut arg1.active_orders, v2);
        arg1.updated_at = v0;
        let v3 = OrderRemoved{
            position_id : 0x2::object::uid_to_inner(&arg1.id),
            order_id    : arg2,
            timestamp   : v0,
        };
        0x2::event::emit<OrderRemoved>(v3);
    }

    public fun revoke_capability(arg0: MirrorCapability, arg1: &MirrorPosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 2);
        let v0 = CapabilityRevoked{
            capability_id : 0x2::object::uid_to_inner(&arg0.id),
            position_id   : arg0.position_id,
            operator      : arg0.authorized_operator,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CapabilityRevoked>(v0);
        let MirrorCapability {
            id                  : v1,
            position_id         : _,
            authorized_operator : _,
            max_order_size      : _,
            expires_at          : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: bool, arg3: &0x2::clock::Clock) {
        arg1.paused = arg2;
        let v0 = ProtocolPaused{
            paused    : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ProtocolPaused>(v0);
    }

    public fun set_version(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: u64) {
        arg1.version = arg2;
    }

    public fun target_maker(arg0: &MirrorPosition) : address {
        arg0.target_maker
    }

    public fun toggle_active(arg0: &mut MirrorPosition, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.active = !arg0.active;
        arg0.updated_at = v0;
        let v1 = PositionStatusChanged{
            position_id : 0x2::object::uid_to_inner(&arg0.id),
            active      : arg0.active,
            timestamp   : v0,
        };
        0x2::event::emit<PositionStatusChanged>(v1);
    }

    public fun total_orders(arg0: &ProtocolConfig) : u64 {
        arg0.total_orders
    }

    public fun total_orders_placed(arg0: &MirrorPosition) : u64 {
        arg0.total_orders_placed
    }

    public fun total_positions(arg0: &ProtocolConfig) : u64 {
        arg0.total_positions
    }

    public fun update_ratio(arg0: &mut MirrorPosition, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        assert!(arg1 >= 1 && arg1 <= 100, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.ratio = arg1;
        arg0.updated_at = v0;
        let v1 = PositionUpdated{
            position_id : 0x2::object::uid_to_inner(&arg0.id),
            old_ratio   : arg0.ratio,
            new_ratio   : arg1,
            timestamp   : v0,
        };
        0x2::event::emit<PositionUpdated>(v1);
    }

    public fun updated_at(arg0: &MirrorPosition) : u64 {
        arg0.updated_at
    }

    // decompiled from Move bytecode v6
}

