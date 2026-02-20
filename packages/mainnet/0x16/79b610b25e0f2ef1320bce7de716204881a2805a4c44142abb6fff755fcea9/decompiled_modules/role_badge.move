module 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::role_badge {
    struct ROLE_BADGE has drop {
        dummy_field: bool,
    }

    struct RoleBadge<phantom T0> has store, key {
        id: 0x2::object::UID,
        club_id: 0x2::object::ID,
        term: u64,
        recipient: address,
        issued_at_ms: u64,
        img_url: 0x1::string::String,
    }

    struct President {
        dummy_field: bool,
    }

    struct VicePresident {
        dummy_field: bool,
    }

    struct Treasurer {
        dummy_field: bool,
    }

    struct PlanningTeam {
        dummy_field: bool,
    }

    struct MarketingTeam {
        dummy_field: bool,
    }

    struct ProjectLeader {
        dummy_field: bool,
    }

    struct GeneralMemberSenior {
        dummy_field: bool,
    }

    struct GeneralMemberJunior {
        dummy_field: bool,
    }

    struct RoleBadgeIssued has copy, drop, store {
        club_id: 0x2::object::ID,
        term: u64,
        recipient: address,
        role_name: 0x1::string::String,
    }

    fun build_image_url(arg0: vector<u8>) : 0x1::string::String {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, b"https://vuhaopuyxmqlpkpeqvaf.supabase.co/storage/v1/object/public/role_badge/");
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::string::utf8(v0)
    }

    fun create_badge_display<T0>(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, arg1);
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BlockBlock role record badge for each completed term"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        let v4 = 0x2::display::new_with_fields<RoleBadge<T0>>(arg0, v0, v2, arg2);
        0x2::display::update_version<RoleBadge<T0>>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<RoleBadge<T0>>>(v4, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: ROLE_BADGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ROLE_BADGE>(arg0, arg1);
        create_badge_display<President>(&v0, 0x1::string::utf8(b"BlockBlock Role Badge - President"), arg1);
        create_badge_display<VicePresident>(&v0, 0x1::string::utf8(b"BlockBlock Role Badge - Vice President"), arg1);
        create_badge_display<Treasurer>(&v0, 0x1::string::utf8(b"BlockBlock Role Badge - Treasurer"), arg1);
        create_badge_display<PlanningTeam>(&v0, 0x1::string::utf8(b"BlockBlock Role Badge - Planning Team"), arg1);
        create_badge_display<MarketingTeam>(&v0, 0x1::string::utf8(b"BlockBlock Role Badge - Marketing Team"), arg1);
        create_badge_display<ProjectLeader>(&v0, 0x1::string::utf8(b"BlockBlock Role Badge - Project Leader"), arg1);
        create_badge_display<GeneralMemberSenior>(&v0, 0x1::string::utf8(b"BlockBlock Role Badge - General Member (Senior)"), arg1);
        create_badge_display<GeneralMemberJunior>(&v0, 0x1::string::utf8(b"BlockBlock Role Badge - General Member (Junior)"), arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint_general_member_junior_badge(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        mint_role_badge<GeneralMemberJunior>(arg0, arg1, arg2, 0x1::string::utf8(b"General Member (Junior)"), b"Blockblock_Role_Badge_GJ.png", arg3);
    }

    public(friend) fun mint_general_member_senior_badge(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        mint_role_badge<GeneralMemberSenior>(arg0, arg1, arg2, 0x1::string::utf8(b"General Member (Senior)"), b"Blockblock_Role_Badge_GS.png", arg3);
    }

    public(friend) fun mint_marketing_team_badge(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        mint_role_badge<MarketingTeam>(arg0, arg1, arg2, 0x1::string::utf8(b"Marketing Team"), b"Blockblock_Role_Badge_MK.png", arg3);
    }

    public(friend) fun mint_planning_team_badge(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        mint_role_badge<PlanningTeam>(arg0, arg1, arg2, 0x1::string::utf8(b"Planning Team"), b"Blockblock_Role_Badge_PL.png", arg3);
    }

    public(friend) fun mint_president_badge(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        mint_role_badge<President>(arg0, arg1, arg2, 0x1::string::utf8(b"President"), b"Blockblock_Role_Badge_P.png", arg3);
    }

    public(friend) fun mint_project_leader_badge(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        mint_role_badge<ProjectLeader>(arg0, arg1, arg2, 0x1::string::utf8(b"Project Leader"), b"Blockblock_Role_Badge_PJ.png", arg3);
    }

    fun mint_role_badge<T0>(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = RoleBadge<T0>{
            id           : 0x2::object::new(arg5),
            club_id      : arg1,
            term         : arg2,
            recipient    : arg0,
            issued_at_ms : 0x2::tx_context::epoch_timestamp_ms(arg5),
            img_url      : build_image_url(arg4),
        };
        let v1 = RoleBadgeIssued{
            club_id   : arg1,
            term      : arg2,
            recipient : arg0,
            role_name : arg3,
        };
        0x2::event::emit<RoleBadgeIssued>(v1);
        0x2::transfer::transfer<RoleBadge<T0>>(v0, arg0);
    }

    public(friend) fun mint_treasurer_badge(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        mint_role_badge<Treasurer>(arg0, arg1, arg2, 0x1::string::utf8(b"Treasurer"), b"Blockblock_Role_Badge_T.png", arg3);
    }

    public(friend) fun mint_vice_president_badge(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        mint_role_badge<VicePresident>(arg0, arg1, arg2, 0x1::string::utf8(b"Vice President"), b"Blockblock_Role_Badge_VP.png", arg3);
    }

    // decompiled from Move bytecode v6
}

