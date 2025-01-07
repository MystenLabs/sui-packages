module 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::certificate {
    struct InvestmentCertificate has key {
        id: 0x2::object::UID,
        project: 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::project::ProjectInfo,
        event_name: 0x1::string::String,
        token_type: 0x1::string::String,
        issue_date: u64,
        vesting_id: 0x2::object::ID,
        description: 0x1::string::String,
    }

    struct CERTIFICATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CERTIFICATE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CERTIFICATE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"YouSUI x {project.name} <> {event_name} <> Certificate"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{project.link_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://files.yousui.io/IDO/releap.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{project.website}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"YouSUI Creator"));
        let v5 = 0x2::display::new_with_fields<InvestmentCertificate>(&v0, v1, v3, arg1);
        0x2::display::update_version<InvestmentCertificate>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<InvestmentCertificate>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun issue_investment_certificate(arg0: u64, arg1: 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::project::ProjectInfo, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = InvestmentCertificate{
            id          : 0x2::object::new(arg5),
            project     : arg1,
            event_name  : arg2,
            token_type  : arg3,
            issue_date  : arg0,
            vesting_id  : arg4,
            description : 0x1::string::utf8(b"The investment certificate, published by YouSUI, is a document providing proof of your token investment in a crypto project. It verifies your ownership, including the number of tokens purchased, and grants you certain rights and benefits within the project. The certificate ensures transparency and credibility, protecting your interests and allowing you to participate in project-related decisions. It serves as a valuable record of your investment, issued by YouSUI, in the crypto project."),
        };
        0x2::transfer::transfer<InvestmentCertificate>(v0, 0x2::tx_context::sender(arg5));
    }

    public(friend) fun issue_investment_certificate_with_user(arg0: u64, arg1: 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::project::ProjectInfo, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::object::ID, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = InvestmentCertificate{
            id          : 0x2::object::new(arg6),
            project     : arg1,
            event_name  : arg2,
            token_type  : arg3,
            issue_date  : arg0,
            vesting_id  : arg4,
            description : 0x1::string::utf8(b"The investment certificate, published by YouSUI, is a document providing proof of your token investment in a crypto project. It verifies your ownership, including the number of tokens purchased, and grants you certain rights and benefits within the project. The certificate ensures transparency and credibility, protecting your interests and allowing you to participate in project-related decisions. It serves as a valuable record of your investment, issued by YouSUI, in the crypto project."),
        };
        0x2::transfer::transfer<InvestmentCertificate>(v0, arg5);
    }

    // decompiled from Move bytecode v6
}

