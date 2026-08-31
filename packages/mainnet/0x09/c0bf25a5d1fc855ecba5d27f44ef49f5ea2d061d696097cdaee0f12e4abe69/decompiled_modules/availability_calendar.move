module 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar {
    struct AvailabilityCalendar has store, key {
        id: 0x2::object::UID,
        vessel_id: 0x2::object::ID,
        slots: 0x2::table::Table<u64, CalendarSlot>,
        pricing: 0x2::table::Table<u8, u64>,
        default_capacity: u8,
        early_bird_days: u64,
        early_bird_bps: u64,
        group_discount_threshold: u8,
        group_discount_bps: u64,
    }

    struct CalendarSlot has store {
        date_key_ms: u64,
        status: u8,
        available_tiers: vector<u8>,
        passes_sold: u64,
        capacity: u8,
    }

    struct CalendarCreated has copy, drop {
        calendar_id: 0x2::object::ID,
        vessel_id: 0x2::object::ID,
        default_capacity: u8,
    }

    struct SlotUpdated has copy, drop {
        calendar_id: 0x2::object::ID,
        date_key_ms: u64,
        status: u8,
        capacity: u8,
        passes_sold: u64,
    }

    struct PricingUpdated has copy, drop {
        calendar_id: 0x2::object::ID,
        tier: u8,
        price_usdc: u64,
    }

    struct EarlyBirdConfigUpdated has copy, drop {
        calendar_id: 0x2::object::ID,
        days: u64,
        bps: u64,
    }

    struct GroupDiscountConfigUpdated has copy, drop {
        calendar_id: 0x2::object::ID,
        threshold: u8,
        bps: u64,
    }

    public fun block_slot(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg2: &mut AvailabilityCalendar, arg3: u64) {
        set_slot(arg0, arg1, arg2, arg3, 1, 0x1::vector::empty<u8>(), 0);
    }

    public fun calendar_default_capacity(arg0: &AvailabilityCalendar) : u8 {
        arg0.default_capacity
    }

    public fun calendar_vessel_id(arg0: &AvailabilityCalendar) : 0x2::object::ID {
        arg0.vessel_id
    }

    public fun compute_auto_discount(arg0: &AvailabilityCalendar, arg1: u64, arg2: u8, arg3: u64, arg4: u64) : u64 {
        let v0 = if (arg0.early_bird_days > 0) {
            if (arg0.early_bird_bps > 0) {
                if (arg4 < arg3) {
                    arg3 - arg4 >= arg0.early_bird_days * 86400000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v1 = if (v0) {
            arg1 * arg0.early_bird_bps / 10000
        } else {
            0
        };
        let v2 = if (arg0.group_discount_threshold > 0) {
            if (arg0.group_discount_bps > 0) {
                arg2 >= arg0.group_discount_threshold
            } else {
                false
            }
        } else {
            false
        };
        let v3 = if (v2) {
            arg1 * arg0.group_discount_bps / 10000
        } else {
            0
        };
        if (v1 >= v3) {
            v1
        } else {
            v3
        }
    }

    public fun create_calendar(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : AvailabilityCalendar {
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::owner_cap_vessel_id(arg0) == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 200);
        let v0 = AvailabilityCalendar{
            id                       : 0x2::object::new(arg3),
            vessel_id                : 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1),
            slots                    : 0x2::table::new<u64, CalendarSlot>(arg3),
            pricing                  : 0x2::table::new<u8, u64>(arg3),
            default_capacity         : arg2,
            early_bird_days          : 0,
            early_bird_bps           : 0,
            group_discount_threshold : 0,
            group_discount_bps       : 0,
        };
        let v1 = CalendarCreated{
            calendar_id      : 0x2::object::id<AvailabilityCalendar>(&v0),
            vessel_id        : 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1),
            default_capacity : arg2,
        };
        0x2::event::emit<CalendarCreated>(v1);
        v0
    }

    public fun early_bird_bps(arg0: &AvailabilityCalendar) : u64 {
        arg0.early_bird_bps
    }

    public fun early_bird_days(arg0: &AvailabilityCalendar) : u64 {
        arg0.early_bird_days
    }

    public fun get_slot(arg0: &AvailabilityCalendar, arg1: u64) : (u8, vector<u8>, u64, u8) {
        assert!(0x2::table::contains<u64, CalendarSlot>(&arg0.slots, arg1), 201);
        let v0 = 0x2::table::borrow<u64, CalendarSlot>(&arg0.slots, arg1);
        (v0.status, v0.available_tiers, v0.passes_sold, v0.capacity)
    }

    public fun get_tier_price(arg0: &AvailabilityCalendar, arg1: u8) : u64 {
        assert!(0x2::table::contains<u8, u64>(&arg0.pricing, arg1), 205);
        *0x2::table::borrow<u8, u64>(&arg0.pricing, arg1)
    }

    public fun group_discount_bps(arg0: &AvailabilityCalendar) : u64 {
        arg0.group_discount_bps
    }

    public fun group_discount_threshold(arg0: &AvailabilityCalendar) : u8 {
        arg0.group_discount_threshold
    }

    public fun record_purchase(arg0: &mut AvailabilityCalendar, arg1: u64, arg2: u8) {
        assert!(0x2::table::contains<u64, CalendarSlot>(&arg0.slots, arg1), 201);
        let v0 = 0x2::table::borrow_mut<u64, CalendarSlot>(&mut arg0.slots, arg1);
        assert!(v0.status == 0, 202);
        assert!(0x1::vector::contains<u8>(&v0.available_tiers, &arg2), 203);
        assert!(v0.passes_sold < (v0.capacity as u64), 204);
        v0.passes_sold = v0.passes_sold + 1;
        if (v0.passes_sold == (v0.capacity as u64)) {
            v0.status = 2;
        };
        let v1 = SlotUpdated{
            calendar_id : 0x2::object::id<AvailabilityCalendar>(arg0),
            date_key_ms : arg1,
            status      : v0.status,
            capacity    : v0.capacity,
            passes_sold : v0.passes_sold,
        };
        0x2::event::emit<SlotUpdated>(v1);
    }

    public fun record_refund(arg0: &mut AvailabilityCalendar, arg1: u64) {
        assert!(0x2::table::contains<u64, CalendarSlot>(&arg0.slots, arg1), 201);
        let v0 = 0x2::table::borrow_mut<u64, CalendarSlot>(&mut arg0.slots, arg1);
        assert!(v0.passes_sold > 0, 208);
        v0.passes_sold = v0.passes_sold - 1;
        if (v0.status == 2) {
            v0.status = 0;
        };
        let v1 = SlotUpdated{
            calendar_id : 0x2::object::id<AvailabilityCalendar>(arg0),
            date_key_ms : arg1,
            status      : v0.status,
            capacity    : v0.capacity,
            passes_sold : v0.passes_sold,
        };
        0x2::event::emit<SlotUpdated>(v1);
    }

    public fun set_early_bird(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg2: &mut AvailabilityCalendar, arg3: u64, arg4: u64) {
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::owner_cap_vessel_id(arg0) == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 200);
        assert!(arg2.vessel_id == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 200);
        assert!(arg4 <= 10000, 207);
        arg2.early_bird_days = arg3;
        arg2.early_bird_bps = arg4;
        let v0 = EarlyBirdConfigUpdated{
            calendar_id : 0x2::object::id<AvailabilityCalendar>(arg2),
            days        : arg3,
            bps         : arg4,
        };
        0x2::event::emit<EarlyBirdConfigUpdated>(v0);
    }

    public fun set_group_discount(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg2: &mut AvailabilityCalendar, arg3: u8, arg4: u64) {
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::owner_cap_vessel_id(arg0) == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 200);
        assert!(arg2.vessel_id == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 200);
        assert!(arg4 <= 10000, 207);
        arg2.group_discount_threshold = arg3;
        arg2.group_discount_bps = arg4;
        let v0 = GroupDiscountConfigUpdated{
            calendar_id : 0x2::object::id<AvailabilityCalendar>(arg2),
            threshold   : arg3,
            bps         : arg4,
        };
        0x2::event::emit<GroupDiscountConfigUpdated>(v0);
    }

    public fun set_slot(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg2: &mut AvailabilityCalendar, arg3: u64, arg4: u8, arg5: vector<u8>, arg6: u8) {
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::owner_cap_vessel_id(arg0) == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 200);
        assert!(arg2.vessel_id == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 200);
        let v0 = if (arg4 == 0) {
            true
        } else if (arg4 == 1) {
            true
        } else {
            arg4 == 2
        };
        assert!(v0, 206);
        if (0x2::table::contains<u64, CalendarSlot>(&arg2.slots, arg3)) {
            let CalendarSlot {
                date_key_ms     : _,
                status          : _,
                available_tiers : _,
                passes_sold     : _,
                capacity        : _,
            } = 0x2::table::remove<u64, CalendarSlot>(&mut arg2.slots, arg3);
        };
        let v6 = CalendarSlot{
            date_key_ms     : arg3,
            status          : arg4,
            available_tiers : arg5,
            passes_sold     : 0,
            capacity        : arg6,
        };
        0x2::table::add<u64, CalendarSlot>(&mut arg2.slots, arg3, v6);
        let v7 = SlotUpdated{
            calendar_id : 0x2::object::id<AvailabilityCalendar>(arg2),
            date_key_ms : arg3,
            status      : arg4,
            capacity    : arg6,
            passes_sold : 0,
        };
        0x2::event::emit<SlotUpdated>(v7);
    }

    public fun set_tier_price(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg2: &mut AvailabilityCalendar, arg3: u8, arg4: u64) {
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::owner_cap_vessel_id(arg0) == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 200);
        assert!(arg2.vessel_id == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 200);
        let v0 = if (arg3 == 0) {
            true
        } else if (arg3 == 1) {
            true
        } else {
            arg3 == 2
        };
        assert!(v0, 205);
        if (0x2::table::contains<u8, u64>(&arg2.pricing, arg3)) {
            0x2::table::remove<u8, u64>(&mut arg2.pricing, arg3);
        };
        0x2::table::add<u8, u64>(&mut arg2.pricing, arg3, arg4);
        let v1 = PricingUpdated{
            calendar_id : 0x2::object::id<AvailabilityCalendar>(arg2),
            tier        : arg3,
            price_usdc  : arg4,
        };
        0x2::event::emit<PricingUpdated>(v1);
    }

    public fun slot_exists(arg0: &AvailabilityCalendar, arg1: u64) : bool {
        0x2::table::contains<u64, CalendarSlot>(&arg0.slots, arg1)
    }

    public fun status_blocked() : u8 {
        1
    }

    public fun status_open() : u8 {
        0
    }

    public fun status_sold_out() : u8 {
        2
    }

    public fun tier_day_pass() : u8 {
        0
    }

    public fun tier_half_day() : u8 {
        1
    }

    public fun tier_sunset_cruise() : u8 {
        2
    }

    // decompiled from Move bytecode v7
}

