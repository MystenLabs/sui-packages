module 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::global_buffs {
    struct ActiveBuff has drop, store {
        buff_type: u8,
        start_time: u64,
        end_time: u64,
        strength: u64,
    }

    struct GlobalBuffs has key {
        id: 0x2::object::UID,
        active_buffs: vector<ActiveBuff>,
    }

    public fun active_buff_end_time(arg0: &ActiveBuff) : u64 {
        arg0.end_time
    }

    public fun active_buff_start_time(arg0: &ActiveBuff) : u64 {
        arg0.start_time
    }

    public fun active_buff_strength(arg0: &ActiveBuff) : u64 {
        arg0.strength
    }

    public fun active_buff_type(arg0: &ActiveBuff) : u8 {
        arg0.buff_type
    }

    public entry fun add_buff(arg0: &0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::admin_cap::AdminCap, arg1: &mut GlobalBuffs, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        cleanup_expired_buffs(arg1, arg6);
        remove_buff_by_type(arg1, arg2);
        0x1::vector::push_back<ActiveBuff>(&mut arg1.active_buffs, new_active_buff(arg2, arg3, arg4, arg5));
    }

    public fun buff_type_drop_rate() : u8 {
        1
    }

    public fun buff_type_experience() : u8 {
        2
    }

    public fun buff_type_police_disabled() : u8 {
        5
    }

    public fun buff_type_stamina_regen() : u8 {
        3
    }

    public fun buff_type_wanted_reduction() : u8 {
        4
    }

    fun cleanup_expired_buffs(arg0: &mut GlobalBuffs, arg1: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ActiveBuff>(&arg0.active_buffs)) {
            if (0x2::clock::timestamp_ms(arg1) >= 0x1::vector::borrow<ActiveBuff>(&arg0.active_buffs, v0).end_time) {
                0x1::vector::remove<ActiveBuff>(&mut arg0.active_buffs, v0);
                continue
            };
            v0 = v0 + 1;
        };
    }

    public entry fun clear_all_buffs(arg0: &0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::admin_cap::AdminCap, arg1: &mut GlobalBuffs) {
        arg1.active_buffs = 0x1::vector::empty<ActiveBuff>();
    }

    public fun get_buff_strength(arg0: &GlobalBuffs, arg1: u8, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0;
        let v2 = &arg0.active_buffs;
        while (v1 < 0x1::vector::length<ActiveBuff>(v2)) {
            let v3 = 0x1::vector::borrow<ActiveBuff>(v2, v1);
            let v4 = if (v3.buff_type == arg1) {
                if (v0 >= v3.start_time) {
                    v0 < v3.end_time
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                return v3.strength
            };
            v1 = v1 + 1;
        };
        0
    }

    public fun global_buffs_active_buffs(arg0: &GlobalBuffs) : &vector<ActiveBuff> {
        &arg0.active_buffs
    }

    public fun init_global_buffs(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalBuffs{
            id           : 0x2::object::new(arg0),
            active_buffs : 0x1::vector::empty<ActiveBuff>(),
        };
        0x2::transfer::share_object<GlobalBuffs>(v0);
    }

    public fun is_buff_active(arg0: &GlobalBuffs, arg1: u8, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0;
        let v2 = &arg0.active_buffs;
        while (v1 < 0x1::vector::length<ActiveBuff>(v2)) {
            let v3 = 0x1::vector::borrow<ActiveBuff>(v2, v1);
            let v4 = if (v3.buff_type == arg1) {
                if (v0 >= v3.start_time) {
                    v0 < v3.end_time
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun new_active_buff(arg0: u8, arg1: u64, arg2: u64, arg3: u64) : ActiveBuff {
        ActiveBuff{
            buff_type  : arg0,
            start_time : arg1,
            end_time   : arg2,
            strength   : arg3,
        }
    }

    public entry fun remove_buff(arg0: &0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::admin_cap::AdminCap, arg1: &mut GlobalBuffs, arg2: u8, arg3: &0x2::clock::Clock) {
        cleanup_expired_buffs(arg1, arg3);
        remove_buff_by_type(arg1, arg2);
    }

    fun remove_buff_by_type(arg0: &mut GlobalBuffs, arg1: u8) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ActiveBuff>(&arg0.active_buffs)) {
            if (0x1::vector::borrow<ActiveBuff>(&arg0.active_buffs, v0).buff_type == arg1) {
                0x1::vector::remove<ActiveBuff>(&mut arg0.active_buffs, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

