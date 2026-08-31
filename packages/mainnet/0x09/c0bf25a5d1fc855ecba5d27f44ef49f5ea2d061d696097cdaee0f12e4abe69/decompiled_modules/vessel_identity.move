module 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity {
    struct VesselIdentity has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        hin: 0x1::string::String,
        registration_state: 0x1::string::String,
        vessel_type: 0x1::string::String,
        loa_ft: u64,
        metadata_walrus_cid: 0x1::string::String,
        photo_walrus_cid: 0x1::string::String,
        persona_walrus_cid: 0x1::option::Option<0x1::string::String>,
        ticket_art_cid: 0x1::option::Option<0x1::string::String>,
        created_at_ms: u64,
        is_active: bool,
    }

    struct OwnerCapability has store, key {
        id: 0x2::object::UID,
        vessel_id: 0x2::object::ID,
    }

    struct VesselMinted has copy, drop {
        vessel_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        hin: 0x1::string::String,
        metadata_walrus_cid: 0x1::string::String,
        created_at_ms: u64,
    }

    struct VesselMetadataUpdated has copy, drop {
        vessel_id: 0x2::object::ID,
        new_metadata_cid: 0x1::string::String,
        new_photo_cid: 0x1::string::String,
    }

    struct VesselPersonaUpdated has copy, drop {
        vessel_id: 0x2::object::ID,
        persona_cid: 0x1::string::String,
    }

    struct TicketArtUpdated has copy, drop {
        vessel_id: 0x2::object::ID,
        cid: 0x1::string::String,
    }

    struct VesselDeactivated has copy, drop {
        vessel_id: 0x2::object::ID,
    }

    public fun deactivate_vessel(arg0: &OwnerCapability, arg1: &mut VesselIdentity) {
        assert!(arg0.vessel_id == 0x2::object::id<VesselIdentity>(arg1), 100);
        arg1.is_active = false;
        let v0 = VesselDeactivated{vessel_id: 0x2::object::id<VesselIdentity>(arg1)};
        0x2::event::emit<VesselDeactivated>(v0);
    }

    public fun mint_vessel_identity(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::admin::AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let v1 = VesselIdentity{
            id                  : 0x2::object::new(arg10),
            owner               : arg8,
            name                : 0x1::string::utf8(arg1),
            hin                 : 0x1::string::utf8(arg2),
            registration_state  : 0x1::string::utf8(arg3),
            vessel_type         : 0x1::string::utf8(arg4),
            loa_ft              : arg5,
            metadata_walrus_cid : 0x1::string::utf8(arg6),
            photo_walrus_cid    : 0x1::string::utf8(arg7),
            persona_walrus_cid  : 0x1::option::none<0x1::string::String>(),
            ticket_art_cid      : 0x1::option::none<0x1::string::String>(),
            created_at_ms       : v0,
            is_active           : true,
        };
        let v2 = 0x2::object::id<VesselIdentity>(&v1);
        let v3 = OwnerCapability{
            id        : 0x2::object::new(arg10),
            vessel_id : v2,
        };
        let v4 = VesselMinted{
            vessel_id           : v2,
            owner               : arg8,
            name                : v1.name,
            hin                 : v1.hin,
            metadata_walrus_cid : v1.metadata_walrus_cid,
            created_at_ms       : v0,
        };
        0x2::event::emit<VesselMinted>(v4);
        0x2::transfer::public_share_object<VesselIdentity>(v1);
        0x2::transfer::public_transfer<OwnerCapability>(v3, arg8);
    }

    public fun owner_cap_vessel_id(arg0: &OwnerCapability) : 0x2::object::ID {
        arg0.vessel_id
    }

    public fun set_persona_cid(arg0: &OwnerCapability, arg1: &mut VesselIdentity, arg2: vector<u8>) {
        assert!(arg0.vessel_id == 0x2::object::id<VesselIdentity>(arg1), 100);
        assert!(arg1.is_active, 101);
        arg1.persona_walrus_cid = 0x1::option::some<0x1::string::String>(0x1::string::utf8(arg2));
        let v0 = VesselPersonaUpdated{
            vessel_id   : 0x2::object::id<VesselIdentity>(arg1),
            persona_cid : *0x1::option::borrow<0x1::string::String>(&arg1.persona_walrus_cid),
        };
        0x2::event::emit<VesselPersonaUpdated>(v0);
    }

    public fun set_ticket_art_cid(arg0: &OwnerCapability, arg1: &mut VesselIdentity, arg2: vector<u8>) {
        assert!(arg0.vessel_id == 0x2::object::id<VesselIdentity>(arg1), 100);
        assert!(arg1.is_active, 101);
        arg1.ticket_art_cid = 0x1::option::some<0x1::string::String>(0x1::string::utf8(arg2));
        let v0 = TicketArtUpdated{
            vessel_id : 0x2::object::id<VesselIdentity>(arg1),
            cid       : *0x1::option::borrow<0x1::string::String>(&arg1.ticket_art_cid),
        };
        0x2::event::emit<TicketArtUpdated>(v0);
    }

    public fun update_metadata(arg0: &OwnerCapability, arg1: &mut VesselIdentity, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(arg0.vessel_id == 0x2::object::id<VesselIdentity>(arg1), 100);
        assert!(arg1.is_active, 101);
        arg1.metadata_walrus_cid = 0x1::string::utf8(arg2);
        arg1.photo_walrus_cid = 0x1::string::utf8(arg3);
        let v0 = VesselMetadataUpdated{
            vessel_id        : 0x2::object::id<VesselIdentity>(arg1),
            new_metadata_cid : arg1.metadata_walrus_cid,
            new_photo_cid    : arg1.photo_walrus_cid,
        };
        0x2::event::emit<VesselMetadataUpdated>(v0);
    }

    public fun vessel_created_at_ms(arg0: &VesselIdentity) : u64 {
        arg0.created_at_ms
    }

    public fun vessel_hin(arg0: &VesselIdentity) : 0x1::string::String {
        arg0.hin
    }

    public fun vessel_id_of_cap(arg0: &OwnerCapability) : 0x2::object::ID {
        arg0.vessel_id
    }

    public fun vessel_is_active(arg0: &VesselIdentity) : bool {
        arg0.is_active
    }

    public fun vessel_loa_ft(arg0: &VesselIdentity) : u64 {
        arg0.loa_ft
    }

    public fun vessel_metadata_cid(arg0: &VesselIdentity) : 0x1::string::String {
        arg0.metadata_walrus_cid
    }

    public fun vessel_name(arg0: &VesselIdentity) : 0x1::string::String {
        arg0.name
    }

    public fun vessel_owner(arg0: &VesselIdentity) : address {
        arg0.owner
    }

    public fun vessel_persona_cid(arg0: &VesselIdentity) : 0x1::option::Option<0x1::string::String> {
        arg0.persona_walrus_cid
    }

    public fun vessel_photo_cid(arg0: &VesselIdentity) : 0x1::string::String {
        arg0.photo_walrus_cid
    }

    public fun vessel_registration_state(arg0: &VesselIdentity) : 0x1::string::String {
        arg0.registration_state
    }

    public fun vessel_ticket_art_cid(arg0: &VesselIdentity) : 0x1::option::Option<0x1::string::String> {
        arg0.ticket_art_cid
    }

    public fun vessel_type(arg0: &VesselIdentity) : 0x1::string::String {
        arg0.vessel_type
    }

    // decompiled from Move bytecode v7
}

