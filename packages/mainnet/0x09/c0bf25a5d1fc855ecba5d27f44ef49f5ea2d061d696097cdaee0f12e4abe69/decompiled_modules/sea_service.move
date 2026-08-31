module 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::sea_service {
    struct CaptainProfile has key {
        id: 0x2::object::UID,
        holder: address,
        credential_hash: vector<u8>,
        profile_cid: 0x1::string::String,
        open_voyage: 0x1::option::Option<0x2::object::ID>,
        total_voyages: u64,
        created_at_ms: u64,
    }

    struct CrewCapability has store, key {
        id: 0x2::object::UID,
        vessel_id: 0x2::object::ID,
        captain: address,
        capacity: u8,
        valid_from_ms: u64,
        expires_at_ms: u64,
        revoked: bool,
    }

    struct VoyageLog has store, key {
        id: 0x2::object::UID,
        vessel_id: 0x2::object::ID,
        captain: address,
        crew_cap_id: 0x2::object::ID,
        capacity: u8,
        waters: u8,
        departed_at_ms: u64,
        arrived_at_ms: u64,
        underway_ms: u64,
        distance_nm_x10: u64,
        credited_days: u64,
        track_cid: 0x1::option::Option<0x1::string::String>,
        attested_digest: 0x1::option::Option<vector<u8>>,
        attested_by: 0x1::option::Option<address>,
        attested_at_ms: 0x1::option::Option<u64>,
        status: u8,
    }

    struct CaptainProfileCreated has copy, drop {
        profile_id: 0x2::object::ID,
        holder: address,
        timestamp_ms: u64,
    }

    struct CrewCapabilityMinted has copy, drop {
        capability_id: 0x2::object::ID,
        vessel_id: 0x2::object::ID,
        captain: address,
        capacity: u8,
        expires_at_ms: u64,
    }

    struct CrewCapabilityRevoked has copy, drop {
        capability_id: 0x2::object::ID,
        vessel_id: 0x2::object::ID,
    }

    struct VoyageStarted has copy, drop {
        voyage_id: 0x2::object::ID,
        vessel_id: 0x2::object::ID,
        captain: address,
        departed_at_ms: u64,
    }

    struct VoyageClosed has copy, drop {
        voyage_id: 0x2::object::ID,
        vessel_id: 0x2::object::ID,
        captain: address,
        underway_ms: u64,
        credited_days: u64,
        arrived_at_ms: u64,
    }

    struct VoyageAttested has copy, drop {
        voyage_id: 0x2::object::ID,
        vessel_id: 0x2::object::ID,
        captain: address,
        attested_by: address,
        credited_days: u64,
        digest: vector<u8>,
        timestamp_ms: u64,
    }

    fun assert_capacity(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 5
        };
        assert!(v0, 515);
    }

    fun assert_waters(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else {
            arg0 == 4
        };
        assert!(v0, 516);
    }

    public fun attest_voyage(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg2: &mut VoyageLog, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::owner_cap_vessel_id(arg0) == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 500);
        assert!(arg2.vessel_id == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 512);
        assert!(0x1::option::is_none<address>(&arg2.attested_by), 513);
        assert!(arg2.status == 1, 514);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        arg2.attested_digest = 0x1::option::some<vector<u8>>(arg3);
        arg2.attested_by = 0x1::option::some<address>(v1);
        arg2.attested_at_ms = 0x1::option::some<u64>(v0);
        arg2.status = 2;
        let v2 = VoyageAttested{
            voyage_id     : 0x2::object::id<VoyageLog>(arg2),
            vessel_id     : arg2.vessel_id,
            captain       : arg2.captain,
            attested_by   : v1,
            credited_days : arg2.credited_days,
            digest        : arg3,
            timestamp_ms  : v0,
        };
        0x2::event::emit<VoyageAttested>(v2);
    }

    public fun cap_capacity(arg0: &CrewCapability) : u8 {
        arg0.capacity
    }

    public fun cap_captain(arg0: &CrewCapability) : address {
        arg0.captain
    }

    public fun cap_is_active(arg0: &CrewCapability, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (!arg0.revoked) {
            if (v0 >= arg0.valid_from_ms) {
                v0 < arg0.expires_at_ms
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun cap_revoked(arg0: &CrewCapability) : bool {
        arg0.revoked
    }

    public fun cap_vessel_id(arg0: &CrewCapability) : 0x2::object::ID {
        arg0.vessel_id
    }

    public fun capacity_deckhand() : u8 {
        4
    }

    public fun capacity_master() : u8 {
        0
    }

    public fun capacity_mate() : u8 {
        1
    }

    public fun close_voyage(arg0: &mut CaptainProfile, arg1: &mut VoyageLog, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg0.holder == v0, 517);
        assert!(arg1.captain == v0, 504);
        assert!(arg1.status == 0, 508);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.open_voyage), 506);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.open_voyage) == 0x2::object::id<VoyageLog>(arg1), 507);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(v1 > arg1.departed_at_ms, 509);
        let v2 = v1 - arg1.departed_at_ms;
        assert!(arg2 <= v2, 510);
        assert!(arg4 <= v2 / 86400000 + 1, 511);
        arg1.arrived_at_ms = v1;
        arg1.underway_ms = arg2;
        arg1.distance_nm_x10 = arg3;
        arg1.credited_days = arg4;
        arg1.status = 1;
        if (!0x1::vector::is_empty<u8>(&arg5)) {
            arg1.track_cid = 0x1::option::some<0x1::string::String>(0x1::string::utf8(arg5));
        };
        arg0.open_voyage = 0x1::option::none<0x2::object::ID>();
        arg0.total_voyages = arg0.total_voyages + 1;
        let v3 = VoyageClosed{
            voyage_id     : 0x2::object::id<VoyageLog>(arg1),
            vessel_id     : arg1.vessel_id,
            captain       : v0,
            underway_ms   : arg2,
            credited_days : arg4,
            arrived_at_ms : v1,
        };
        0x2::event::emit<VoyageClosed>(v3);
    }

    public fun create_captain_profile(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = CaptainProfile{
            id              : 0x2::object::new(arg3),
            holder          : v1,
            credential_hash : arg0,
            profile_cid     : 0x1::string::utf8(arg1),
            open_voyage     : 0x1::option::none<0x2::object::ID>(),
            total_voyages   : 0,
            created_at_ms   : v0,
        };
        let v3 = CaptainProfileCreated{
            profile_id   : 0x2::object::id<CaptainProfile>(&v2),
            holder       : v1,
            timestamp_ms : v0,
        };
        0x2::event::emit<CaptainProfileCreated>(v3);
        0x2::transfer::transfer<CaptainProfile>(v2, v1);
    }

    public fun mint_crew_capability(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg2: address, arg3: u8, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : CrewCapability {
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::owner_cap_vessel_id(arg0) == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 500);
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::vessel_is_active(arg1), 518);
        assert_capacity(arg3);
        let v0 = CrewCapability{
            id            : 0x2::object::new(arg6),
            vessel_id     : 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1),
            captain       : arg2,
            capacity      : arg3,
            valid_from_ms : arg4,
            expires_at_ms : arg5,
            revoked       : false,
        };
        let v1 = CrewCapabilityMinted{
            capability_id : 0x2::object::id<CrewCapability>(&v0),
            vessel_id     : 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1),
            captain       : arg2,
            capacity      : arg3,
            expires_at_ms : arg5,
        };
        0x2::event::emit<CrewCapabilityMinted>(v1);
        v0
    }

    public fun profile_credential_hash(arg0: &CaptainProfile) : vector<u8> {
        arg0.credential_hash
    }

    public fun profile_has_open_voyage(arg0: &CaptainProfile) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.open_voyage)
    }

    public fun profile_holder(arg0: &CaptainProfile) : address {
        arg0.holder
    }

    public fun profile_total_voyages(arg0: &CaptainProfile) : u64 {
        arg0.total_voyages
    }

    public fun revoke_crew_capability(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg2: &mut CrewCapability) {
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::owner_cap_vessel_id(arg0) == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 500);
        assert!(arg2.vessel_id == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 500);
        arg2.revoked = true;
        let v0 = CrewCapabilityRevoked{
            capability_id : 0x2::object::id<CrewCapability>(arg2),
            vessel_id     : arg2.vessel_id,
        };
        0x2::event::emit<CrewCapabilityRevoked>(v0);
    }

    public fun start_voyage(arg0: &mut CaptainProfile, arg1: &CrewCapability, arg2: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : VoyageLog {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.holder == v0, 517);
        assert!(arg1.captain == v0, 504);
        assert!(arg1.vessel_id == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg2), 500);
        assert!(!arg1.revoked, 501);
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::vessel_is_active(arg2), 518);
        assert_waters(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 >= arg1.valid_from_ms, 503);
        assert!(v1 < arg1.expires_at_ms, 502);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.open_voyage), 505);
        let v2 = VoyageLog{
            id              : 0x2::object::new(arg5),
            vessel_id       : 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg2),
            captain         : v0,
            crew_cap_id     : 0x2::object::id<CrewCapability>(arg1),
            capacity        : arg1.capacity,
            waters          : arg3,
            departed_at_ms  : v1,
            arrived_at_ms   : 0,
            underway_ms     : 0,
            distance_nm_x10 : 0,
            credited_days   : 0,
            track_cid       : 0x1::option::none<0x1::string::String>(),
            attested_digest : 0x1::option::none<vector<u8>>(),
            attested_by     : 0x1::option::none<address>(),
            attested_at_ms  : 0x1::option::none<u64>(),
            status          : 0,
        };
        arg0.open_voyage = 0x1::option::some<0x2::object::ID>(0x2::object::id<VoyageLog>(&v2));
        let v3 = VoyageStarted{
            voyage_id      : 0x2::object::id<VoyageLog>(&v2),
            vessel_id      : 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg2),
            captain        : v0,
            departed_at_ms : v1,
        };
        0x2::event::emit<VoyageStarted>(v3);
        v2
    }

    public fun status_attested() : u8 {
        2
    }

    public fun status_closed() : u8 {
        1
    }

    public fun status_open() : u8 {
        0
    }

    public fun transfer_crew_capability(arg0: CrewCapability, arg1: address) {
        0x2::transfer::public_transfer<CrewCapability>(arg0, arg1);
    }

    public fun transfer_voyage(arg0: VoyageLog, arg1: address) {
        0x2::transfer::public_transfer<VoyageLog>(arg0, arg1);
    }

    public fun voyage_attested_by(arg0: &VoyageLog) : 0x1::option::Option<address> {
        arg0.attested_by
    }

    public fun voyage_capacity(arg0: &VoyageLog) : u8 {
        arg0.capacity
    }

    public fun voyage_captain(arg0: &VoyageLog) : address {
        arg0.captain
    }

    public fun voyage_credited_days(arg0: &VoyageLog) : u64 {
        arg0.credited_days
    }

    public fun voyage_distance_nm_x10(arg0: &VoyageLog) : u64 {
        arg0.distance_nm_x10
    }

    public fun voyage_is_attested(arg0: &VoyageLog) : bool {
        arg0.status == 2
    }

    public fun voyage_status(arg0: &VoyageLog) : u8 {
        arg0.status
    }

    public fun voyage_underway_ms(arg0: &VoyageLog) : u64 {
        arg0.underway_ms
    }

    public fun voyage_vessel_id(arg0: &VoyageLog) : 0x2::object::ID {
        arg0.vessel_id
    }

    public fun voyage_waters(arg0: &VoyageLog) : u8 {
        arg0.waters
    }

    public fun voyage_window(arg0: &VoyageLog) : (u64, u64) {
        (arg0.departed_at_ms, arg0.arrived_at_ms)
    }

    public fun waters_near_coastal() : u8 {
        1
    }

    public fun waters_ocean() : u8 {
        0
    }

    // decompiled from Move bytecode v7
}

