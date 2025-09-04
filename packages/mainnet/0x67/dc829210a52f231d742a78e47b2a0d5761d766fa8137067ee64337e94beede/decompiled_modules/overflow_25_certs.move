module 0x67dc829210a52f231d742a78e47b2a0d5761d766fa8137067ee64337e94beede::overflow_25_certs {
    struct OVERFLOW_25_CERTS has drop {
        dummy_field: bool,
    }

    struct Certificate has key {
        id: 0x2::object::UID,
        project_name: 0x1::string::String,
        participant_names: 0x1::string::String,
        event_name: 0x1::string::String,
        achievement: 0x1::string::String,
        achievement_rank: u8,
        achievement_track: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CertificateMinted has copy, drop {
        certificate_id: 0x2::object::ID,
        project_name: 0x1::string::String,
        participant_names: 0x1::string::String,
        event_name: 0x1::string::String,
        achievement: 0x1::string::String,
        achievement_track: 0x1::string::String,
        achievement_rank: u8,
        image_url: 0x1::string::String,
        winner_address: address,
        issued_by: address,
    }

    struct AdminCapTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    public fun achievement(arg0: &Certificate) : &0x1::string::String {
        &arg0.achievement
    }

    public fun achievement_rank(arg0: &Certificate) : u8 {
        arg0.achievement_rank
    }

    public fun achievement_track(arg0: &Certificate) : &0x1::string::String {
        &arg0.achievement_track
    }

    public fun burn_certificate(arg0: Certificate, arg1: &mut 0x2::tx_context::TxContext) {
        let Certificate {
            id                : v0,
            project_name      : _,
            participant_names : _,
            event_name        : _,
            achievement       : _,
            achievement_rank  : _,
            achievement_track : _,
            image_url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun event_name(arg0: &Certificate) : &0x1::string::String {
        &arg0.event_name
    }

    public fun image_url(arg0: &Certificate) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: OVERFLOW_25_CERTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<OVERFLOW_25_CERTS>(arg0, arg1);
        let v1 = 0x2::display::new<Certificate>(&v0, arg1);
        0x2::display::add<Certificate>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{achievement} - {project_name}"));
        0x2::display::add<Certificate>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Certificate for {achievement} at {event_name} - Team: {participant_names}"));
        0x2::display::add<Certificate>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Certificate>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b""));
        0x2::display::add<Certificate>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://sui.io/overflow"));
        0x2::display::add<Certificate>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Sui Foundation"));
        0x2::display::add<Certificate>(&mut v1, 0x1::string::utf8(b"achievement_rank"), 0x1::string::utf8(b"{achievement_rank}"));
        0x2::display::add<Certificate>(&mut v1, 0x1::string::utf8(b"achievement_track"), 0x1::string::utf8(b"{achievement_track}"));
        0x2::display::update_version<Certificate>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Certificate>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint_certificate(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 1);
        assert!(!0x1::vector::is_empty<u8>(&arg3), 2);
        let v0 = 0x2::object::new(arg9);
        let v1 = Certificate{
            id                : v0,
            project_name      : 0x1::string::utf8(arg1),
            participant_names : 0x1::string::utf8(arg2),
            event_name        : 0x1::string::utf8(arg3),
            achievement       : 0x1::string::utf8(arg4),
            achievement_rank  : arg5,
            achievement_track : 0x1::string::utf8(arg6),
            image_url         : 0x1::string::utf8(arg7),
        };
        let v2 = CertificateMinted{
            certificate_id    : 0x2::object::uid_to_inner(&v0),
            project_name      : v1.project_name,
            participant_names : v1.participant_names,
            event_name        : v1.event_name,
            achievement       : v1.achievement,
            achievement_track : v1.achievement_track,
            achievement_rank  : v1.achievement_rank,
            image_url         : v1.image_url,
            winner_address    : arg8,
            issued_by         : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<CertificateMinted>(v2);
        0x2::transfer::transfer<Certificate>(v1, arg8);
    }

    public fun participant_names(arg0: &Certificate) : &0x1::string::String {
        &arg0.participant_names
    }

    public fun project_name(arg0: &Certificate) : &0x1::string::String {
        &arg0.project_name
    }

    public fun transfer_admin(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCapTransferred{
            old_admin : 0x2::tx_context::sender(arg2),
            new_admin : arg1,
        };
        0x2::event::emit<AdminCapTransferred>(v0);
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

