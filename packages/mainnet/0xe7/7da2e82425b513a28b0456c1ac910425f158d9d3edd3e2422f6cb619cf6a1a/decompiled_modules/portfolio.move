module 0xe77da2e82425b513a28b0456c1ac910425f158d9d3edd3e2422f6cb619cf6a1a::portfolio {
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

    public fun create_portfolio(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) {
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

