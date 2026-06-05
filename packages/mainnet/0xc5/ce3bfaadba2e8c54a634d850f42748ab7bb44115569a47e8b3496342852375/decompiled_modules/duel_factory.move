module 0xc5ce3bfaadba2e8c54a634d850f42748ab7bb44115569a47e8b3496342852375::duel_factory {
    struct DuelRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        duels: 0x2::vec_map::VecMap<0x2::object::ID, DuelMeta>,
        total_created: u64,
        platform_fee_bps: u64,
    }

    struct DuelMeta has copy, drop, store {
        duel_id: 0x2::object::ID,
        creator: address,
        entry_amount: u64,
        duration_ms: u64,
        status: u8,
        created_at: u64,
        creator_blob_id: 0x1::string::String,
    }

    struct DuelRegistered has copy, drop {
        duel_id: 0x2::object::ID,
        creator: address,
        entry_amount: u64,
    }

    struct DuelStatusUpdated has copy, drop {
        duel_id: 0x2::object::ID,
        new_status: u8,
    }

    public fun duel_count(arg0: &DuelRegistry) : u64 {
        0x2::vec_map::length<0x2::object::ID, DuelMeta>(&arg0.duels)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DuelRegistry{
            id               : 0x2::object::new(arg0),
            admin            : 0x2::tx_context::sender(arg0),
            duels            : 0x2::vec_map::empty<0x2::object::ID, DuelMeta>(),
            total_created    : 0,
            platform_fee_bps : 200,
        };
        0x2::transfer::share_object<DuelRegistry>(v0);
    }

    public fun is_registered(arg0: &DuelRegistry, arg1: &0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, DuelMeta>(&arg0.duels, arg1)
    }

    public fun platform_fee_bps(arg0: &DuelRegistry) : u64 {
        arg0.platform_fee_bps
    }

    public entry fun register_duel(arg0: &mut DuelRegistry, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(!0x2::vec_map::contains<0x2::object::ID, DuelMeta>(&arg0.duels, &arg1), 1);
        let v0 = DuelMeta{
            duel_id         : arg1,
            creator         : arg2,
            entry_amount    : arg3,
            duration_ms     : arg4,
            status          : 0,
            created_at      : 0x2::clock::timestamp_ms(arg6),
            creator_blob_id : arg5,
        };
        0x2::vec_map::insert<0x2::object::ID, DuelMeta>(&mut arg0.duels, arg1, v0);
        arg0.total_created = arg0.total_created + 1;
        let v1 = DuelRegistered{
            duel_id      : arg1,
            creator      : arg2,
            entry_amount : arg3,
        };
        0x2::event::emit<DuelRegistered>(v1);
    }

    public entry fun set_platform_fee(arg0: &mut DuelRegistry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.platform_fee_bps = arg1;
    }

    public fun total_created(arg0: &DuelRegistry) : u64 {
        arg0.total_created
    }

    public entry fun update_duel_status(arg0: &mut DuelRegistry, arg1: 0x2::object::ID, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(0x2::vec_map::contains<0x2::object::ID, DuelMeta>(&arg0.duels, &arg1), 2);
        0x2::vec_map::get_mut<0x2::object::ID, DuelMeta>(&mut arg0.duels, &arg1).status = arg2;
        let v0 = DuelStatusUpdated{
            duel_id    : arg1,
            new_status : arg2,
        };
        0x2::event::emit<DuelStatusUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

