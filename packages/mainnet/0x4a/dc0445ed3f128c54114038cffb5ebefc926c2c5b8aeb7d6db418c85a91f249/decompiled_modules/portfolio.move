module 0x4adc0445ed3f128c54114038cffb5ebefc926c2c5b8aeb7d6db418c85a91f249::portfolio {
    struct Portfolio has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        course: 0x1::string::String,
        school: 0x1::string::String,
        about: 0x1::string::String,
        linkedin_url: 0x1::string::String,
        github_url: 0x1::string::String,
        skills: vector<0x1::string::String>,
        profile_photo_object_id: 0x1::string::String,
    }

    public fun create_portfolio(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<0x1::string::String>, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = Portfolio{
            id                      : 0x2::object::new(arg9),
            name                    : arg1,
            course                  : arg2,
            school                  : arg3,
            about                   : arg4,
            linkedin_url            : arg5,
            github_url              : arg6,
            skills                  : arg7,
            profile_photo_object_id : arg8,
        };
        0x2::transfer::transfer<Portfolio>(v0, arg0);
    }

    public entry fun update_profile_photo(arg0: &mut Portfolio, arg1: 0x1::string::String) {
        arg0.profile_photo_object_id = arg1;
    }

    // decompiled from Move bytecode v6
}

