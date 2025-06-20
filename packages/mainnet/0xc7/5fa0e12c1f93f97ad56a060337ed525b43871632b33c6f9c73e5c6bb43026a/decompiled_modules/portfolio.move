module 0xc75fa0e12c1f93f97ad56a060337ed525b43871632b33c6f9c73e5c6bb43026a::portfolio {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        manager_id: 0x2::object::ID,
    }

    struct ManagerCap has store, key {
        id: 0x2::object::UID,
        manager_id: 0x2::object::ID,
    }

    struct PositionManager has store, key {
        id: 0x2::object::UID,
        owner: address,
        initialized: bool,
        settings: PositionSettings,
    }

    struct PositionSettings has drop, store {
        auto_compound: bool,
        auto_harvest: bool,
        auto_exit: bool,
    }

    struct HighFiPosition<phantom T0, phantom T1> has drop, store {
        pool_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        fee_growth_inside_a: u128,
        fee_growth_inside_b: u128,
        tokens_owed_a: u64,
        tokens_owed_b: u64,
    }

    struct PositionKey has copy, drop, store {
        pool_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct PositionManagerCreated has copy, drop {
        manager_id: 0x2::object::ID,
        owner: address,
    }

    struct PositionOpened has copy, drop {
        manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct ManagerCapMinted has copy, drop {
        manager_id: 0x2::object::ID,
        recipient: address,
    }

    struct RewardsHarvested has copy, drop {
        manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        harvester: address,
    }

    public fun add_dof_manager<T0: store + key>(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: T0) {
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, arg1, arg2);
    }

    public fun create_manager_share_object(arg0: PositionManager) {
        0x2::transfer::public_share_object<PositionManager>(arg0);
    }

    public fun create_position_manager(arg0: &mut 0x2::tx_context::TxContext) : (OwnerCap, PositionManager) {
        let v0 = PositionSettings{
            auto_compound : false,
            auto_harvest  : false,
            auto_exit     : false,
        };
        let v1 = PositionManager{
            id          : 0x2::object::new(arg0),
            owner       : 0x2::tx_context::sender(arg0),
            initialized : true,
            settings    : v0,
        };
        let v2 = OwnerCap{
            id         : 0x2::object::new(arg0),
            manager_id : 0x2::object::id<PositionManager>(&v1),
        };
        let v3 = PositionManagerCreated{
            manager_id : 0x2::object::id<PositionManager>(&v1),
            owner      : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<PositionManagerCreated>(v3);
        (v2, v1)
    }

    public fun disable_auto_compound(arg0: &mut PositionManager) {
        arg0.settings.auto_compound = false;
    }

    public fun disable_auto_exit(arg0: &mut PositionManager) {
        arg0.settings.auto_exit = false;
    }

    public fun disable_auto_harvest(arg0: &mut PositionManager) {
        arg0.settings.auto_harvest = false;
    }

    public fun enable_auto_compund(arg0: &mut PositionManager) {
        arg0.settings.auto_compound = true;
    }

    public fun enable_auto_exit(arg0: &mut PositionManager) {
        arg0.settings.auto_exit = true;
    }

    public fun enable_auto_harvest(arg0: &mut PositionManager) {
        arg0.settings.auto_harvest = true;
    }

    public fun get_manager_owner(arg0: &PositionManager) : address {
        arg0.owner
    }

    public fun get_position_info<T0, T1>(arg0: &PositionManager, arg1: 0x2::object::ID, arg2: u32, arg3: u32) : (u128, u64, u64) {
        let v0 = PositionKey{
            pool_id    : arg1,
            tick_lower : arg2,
            tick_upper : arg3,
        };
        assert!(0x2::dynamic_field::exists_<PositionKey>(&arg0.id, v0), 2);
        let v1 = 0x2::dynamic_field::borrow<PositionKey, HighFiPosition<T0, T1>>(&arg0.id, v0);
        (0, v1.tokens_owed_a, v1.tokens_owed_b)
    }

    public fun harvest_rewards<T0, T1>(arg0: &mut PositionManager, arg1: &ManagerCap, arg2: 0x2::object::ID, arg3: u32, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.manager_id, 1);
        let v0 = PositionKey{
            pool_id    : arg2,
            tick_lower : arg3,
            tick_upper : arg4,
        };
        assert!(0x2::dynamic_field::exists_<PositionKey>(&arg0.id, v0), 2);
        let v1 = 0x2::dynamic_field::borrow_mut<PositionKey, HighFiPosition<T0, T1>>(&mut arg0.id, v0);
        let v2 = v1.tokens_owed_a;
        let v3 = v1.tokens_owed_b;
        v1.tokens_owed_a = 0;
        v1.tokens_owed_b = 0;
        let v4 = RewardsHarvested{
            manager_id : 0x2::object::uid_to_inner(&arg0.id),
            pool_id    : arg2,
            amount_a   : v2,
            amount_b   : v3,
            harvester  : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<RewardsHarvested>(v4);
        (v2, v3)
    }

    public fun is_enable_auto_compound(arg0: &PositionManager) : bool {
        arg0.settings.auto_compound
    }

    public fun is_enable_auto_exit(arg0: &PositionManager) : bool {
        arg0.settings.auto_exit
    }

    public fun is_enable_auto_harvest(arg0: &PositionManager) : bool {
        arg0.settings.auto_harvest
    }

    public fun mint_manager_cap(arg0: &PositionManager, arg1: &OwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.manager_id, 1);
        let v0 = ManagerCap{
            id         : 0x2::object::new(arg3),
            manager_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        let v1 = ManagerCapMinted{
            manager_id : 0x2::object::uid_to_inner(&arg0.id),
            recipient  : arg2,
        };
        0x2::event::emit<ManagerCapMinted>(v1);
        0x2::transfer::public_transfer<ManagerCap>(v0, arg2);
    }

    public fun open_position<T0, T1>(arg0: &mut PositionManager, arg1: &OwnerCap, arg2: 0x2::object::ID, arg3: u32, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<PositionManager>(arg0) == arg1.manager_id, 1);
        assert!(arg0.initialized, 3);
        let v0 = PositionKey{
            pool_id    : arg2,
            tick_lower : arg3,
            tick_upper : arg4,
        };
        assert!(!0x2::dynamic_field::exists_<PositionKey>(&arg0.id, v0), 3);
        let v1 = HighFiPosition<T0, T1>{
            pool_id             : arg2,
            tick_lower          : arg3,
            tick_upper          : arg4,
            fee_growth_inside_a : 0,
            fee_growth_inside_b : 0,
            tokens_owed_a       : 0,
            tokens_owed_b       : 0,
        };
        0x2::dynamic_field::add<PositionKey, HighFiPosition<T0, T1>>(&mut arg0.id, v0, v1);
        let v2 = PositionOpened{
            manager_id : 0x2::object::uid_to_inner(&arg0.id),
            pool_id    : arg2,
            tick_lower : arg3,
            tick_upper : arg4,
        };
        0x2::event::emit<PositionOpened>(v2);
    }

    public fun position_exists<T0, T1>(arg0: &PositionManager, arg1: 0x2::object::ID, arg2: u32, arg3: u32) : bool {
        let v0 = PositionKey{
            pool_id    : arg1,
            tick_lower : arg2,
            tick_upper : arg3,
        };
        0x2::dynamic_field::exists_<PositionKey>(&arg0.id, v0)
    }

    public fun remove_df_position<T0, T1>(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u32, arg3: u32) : HighFiPosition<T0, T1> {
        assert!(position_exists<T0, T1>(arg0, arg1, arg2, arg3), 2);
        let v0 = PositionKey{
            pool_id    : arg1,
            tick_lower : arg2,
            tick_upper : arg3,
        };
        0x2::dynamic_field::remove<PositionKey, HighFiPosition<T0, T1>>(&mut arg0.id, v0)
    }

    public fun remove_dof_position<T0: store + key>(arg0: &mut PositionManager, arg1: 0x2::object::ID) : T0 {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 5);
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1)
    }

    public fun send_manager_cap(arg0: ManagerCap, arg1: address) {
        0x2::transfer::public_transfer<ManagerCap>(arg0, arg1);
    }

    public fun update_position_rewards<T0, T1>(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u32, arg3: u32, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = PositionKey{
            pool_id    : arg1,
            tick_lower : arg2,
            tick_upper : arg3,
        };
        assert!(0x2::dynamic_field::exists_<PositionKey>(&arg0.id, v0), 2);
        let v1 = 0x2::dynamic_field::borrow_mut<PositionKey, HighFiPosition<T0, T1>>(&mut arg0.id, v0);
        v1.tokens_owed_a = v1.tokens_owed_a + arg4;
        v1.tokens_owed_b = v1.tokens_owed_b + arg5;
    }

    public fun verify_manager_cap(arg0: &PositionManager, arg1: &ManagerCap) : bool {
        0x2::object::uid_to_inner(&arg0.id) == arg1.manager_id
    }

    public fun verify_owner_cap(arg0: &PositionManager, arg1: &OwnerCap) : bool {
        0x2::object::uid_to_inner(&arg0.id) == arg1.manager_id
    }

    // decompiled from Move bytecode v6
}

