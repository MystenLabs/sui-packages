module 0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::hub {
    struct Hub has key {
        id: 0x2::object::UID,
        owner: address,
        pending_owner: 0x1::option::Option<address>,
        treasury: address,
        creation_fee: u64,
        platform_bps: u16,
        graduation_bounty: u64,
        tick_spacing: u32,
        pads: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        pads_count: u64,
    }

    struct HubCreated has copy, drop {
        hub: 0x2::object::ID,
        owner: address,
        treasury: address,
    }

    struct TreasuryUpdated has copy, drop {
        hub: 0x2::object::ID,
        treasury: address,
    }

    struct CreationFeeUpdated has copy, drop {
        hub: 0x2::object::ID,
        fee: u64,
    }

    struct PlatformBpsUpdated has copy, drop {
        hub: 0x2::object::ID,
        bps: u16,
    }

    struct GraduationBountyUpdated has copy, drop {
        hub: 0x2::object::ID,
        bounty: u64,
    }

    struct TickSpacingUpdated has copy, drop {
        hub: 0x2::object::ID,
        tick_spacing: u32,
    }

    struct HubOwnershipOffered has copy, drop {
        hub: 0x2::object::ID,
        new_owner: address,
    }

    struct HubOwnerUpdated has copy, drop {
        hub: 0x2::object::ID,
        new_owner: address,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : Hub {
        let v0 = Hub{
            id                : 0x2::object::new(arg0),
            owner             : 0x2::tx_context::sender(arg0),
            pending_owner     : 0x1::option::none<address>(),
            treasury          : 0x2::tx_context::sender(arg0),
            creation_fee      : 0,
            platform_bps      : 2000,
            graduation_bounty : 250000000,
            tick_spacing      : 200,
            pads              : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
            pads_count        : 0,
        };
        let v1 = HubCreated{
            hub      : 0x2::object::id<Hub>(&v0),
            owner    : v0.owner,
            treasury : v0.treasury,
        };
        0x2::event::emit<HubCreated>(v1);
        v0
    }

    public fun accept_ownership(arg0: &mut Hub, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.pending_owner == 0x1::option::some<address>(0x2::tx_context::sender(arg1)), 13906835102056710151);
        arg0.owner = 0x2::tx_context::sender(arg1);
        arg0.pending_owner = 0x1::option::none<address>();
        let v0 = HubOwnerUpdated{
            hub       : 0x2::object::id<Hub>(arg0),
            new_owner : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<HubOwnerUpdated>(v0);
    }

    fun assert_owner(arg0: &Hub, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 13906835132121350149);
    }

    public fun creation_fee(arg0: &Hub) : u64 {
        arg0.creation_fee
    }

    public fun graduation_bounty(arg0: &Hub) : u64 {
        arg0.graduation_bounty
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Hub>(new(arg0));
    }

    public fun max_platform_bps() : u16 {
        5000
    }

    public fun owner(arg0: &Hub) : address {
        arg0.owner
    }

    public fun pad_by_slug(arg0: &Hub, arg1: 0x1::string::String) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.pads, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.pads, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun pads_count(arg0: &Hub) : u64 {
        arg0.pads_count
    }

    public fun pending_owner(arg0: &Hub) : 0x1::option::Option<address> {
        arg0.pending_owner
    }

    public fun platform_bps(arg0: &Hub) : u16 {
        arg0.platform_bps
    }

    public(friend) fun register_pad(arg0: &mut Hub, arg1: 0x1::string::String, arg2: 0x2::object::ID) : u64 {
        assert!(valid_slug(&arg1), 13906834788524359691);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.pads, arg1), 13906834792819458061);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.pads, arg1, arg2);
        let v0 = arg0.pads_count;
        arg0.pads_count = v0 + 1;
        v0
    }

    public fun set_creation_fee(arg0: &mut Hub, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        arg0.creation_fee = arg1;
        let v0 = CreationFeeUpdated{
            hub : 0x2::object::id<Hub>(arg0),
            fee : arg1,
        };
        0x2::event::emit<CreationFeeUpdated>(v0);
    }

    public fun set_graduation_bounty(arg0: &mut Hub, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        arg0.graduation_bounty = arg1;
        let v0 = GraduationBountyUpdated{
            hub    : 0x2::object::id<Hub>(arg0),
            bounty : arg1,
        };
        0x2::event::emit<GraduationBountyUpdated>(v0);
    }

    public fun set_platform_bps(arg0: &mut Hub, arg1: u16, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 <= 5000, 13906834977502789641);
        arg0.platform_bps = arg1;
        let v0 = PlatformBpsUpdated{
            hub : 0x2::object::id<Hub>(arg0),
            bps : arg1,
        };
        0x2::event::emit<PlatformBpsUpdated>(v0);
    }

    public fun set_tick_spacing(arg0: &mut Hub, arg1: u32, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 > 0, 13906835041927299081);
        arg0.tick_spacing = arg1;
        let v0 = TickSpacingUpdated{
            hub          : 0x2::object::id<Hub>(arg0),
            tick_spacing : arg1,
        };
        0x2::event::emit<TickSpacingUpdated>(v0);
    }

    public fun set_treasury(arg0: &mut Hub, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 != @0x0, 13906834917373247497);
        arg0.treasury = arg1;
        let v0 = TreasuryUpdated{
            hub      : 0x2::object::id<Hub>(arg0),
            treasury : arg1,
        };
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    public fun slug_available(arg0: &Hub, arg1: 0x1::string::String) : bool {
        valid_slug(&arg1) && !0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.pads, arg1)
    }

    public fun tick_spacing(arg0: &Hub) : u32 {
        arg0.tick_spacing
    }

    public fun transfer_ownership(arg0: &mut Hub, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 != @0x0, 13906835076287037449);
        arg0.pending_owner = 0x1::option::some<address>(arg1);
        let v0 = HubOwnershipOffered{
            hub       : 0x2::object::id<Hub>(arg0),
            new_owner : arg1,
        };
        0x2::event::emit<HubOwnershipOffered>(v0);
    }

    public fun treasury(arg0: &Hub) : address {
        arg0.treasury
    }

    public fun valid_slug(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 < 3 || v1 > 32) {
            return false
        };
        if (*0x1::vector::borrow<u8>(v0, 0) == 45 || *0x1::vector::borrow<u8>(v0, v1 - 1) == 45) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            let v4 = if (v3 >= 97 && v3 <= 122) {
                true
            } else if (v3 >= 48 && v3 <= 57) {
                true
            } else {
                v3 == 45
            };
            if (!v4) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    // decompiled from Move bytecode v7
}

