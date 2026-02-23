module 0x6ce0a9cf94a987030af7feb7ba4e8d398a2bbe84f14694948f8f7c3147c642b5::portfolio {
    struct Portfolio has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        course: 0x1::string::String,
        school: 0x1::string::String,
        about: 0x1::string::String,
        linkedin_url: 0x1::string::String,
        github_url: 0x1::string::String,
        skills: 0x1::string::String,
    }

    public fun create_portfolio(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Portfolio{
            id           : 0x2::object::new(arg8),
            name         : arg1,
            course       : arg2,
            school       : arg3,
            about        : arg4,
            linkedin_url : arg5,
            github_url   : arg6,
            skills       : arg7,
        };
        0x2::transfer::transfer<Portfolio>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

