module 0xd0ea90d7a0bbfd6a7f3e15f3a3846956c8f6bcf85e3eeae55e5905b3f7912ec6::portfolio {
    struct Portfolio has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        course: 0x1::string::String,
        school: 0x1::string::String,
        about: 0x1::string::String,
        linkedin_url: 0x1::string::String,
        github_url: 0x1::string::String,
        skills: vector<0x1::string::String>,
    }

    public fun create_portfolio(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Graphic Design"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"UI / UX Design"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Project Management"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Full Stack Development"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Web & App Development"));
        let v2 = Portfolio{
            id           : 0x2::object::new(arg0),
            name         : 0x1::string::utf8(b"LADY DIANE BAUZON CASILANG"),
            course       : 0x1::string::utf8(b"BS in Information Technology"),
            school       : 0x1::string::utf8(b"FEU Institute of Technology"),
            about        : 0x1::string::utf8(b"I am a fourth-year IT student and freelance designer who integrates technical troubleshooting with creative insight to deliver innovative, efficient solutions."),
            linkedin_url : 0x1::string::utf8(b"https://www.linkedin.com/in/ldcasilang/"),
            github_url   : 0x1::string::utf8(b"https://github.com/ldcasilang"),
            skills       : v0,
        };
        0x2::transfer::share_object<Portfolio>(v2);
    }

    // decompiled from Move bytecode v6
}

