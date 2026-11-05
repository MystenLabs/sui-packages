module 0x264d957234e9198f72ec5e3d261c43940734058e3cdcaf1419dc35286f41a3b4::builder_card {
    struct BuilderCard has store, key {
        id: 0x2::object::UID,
        builder_no: u64,
        name: 0x1::string::String,
        role: 0x1::string::String,
        course: 0x1::string::String,
        country: 0x1::string::String,
        specialization: 0x1::string::String,
        year: 0x1::string::String,
        category: 0x1::string::String,
        institution: 0x1::string::String,
        skills: 0x1::string::String,
        completion_date: 0x1::string::String,
        reflection: 0x1::string::String,
        website: 0x1::string::String,
    }

    public entry fun create_builder_card(arg0: &mut 0x24c722f3ddac40d511ef390d052fe09a46a9949fdc8eca480780de99ec526114::builder_registry::BuilderRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = BuilderCard{
            id              : 0x2::object::new(arg13),
            builder_no      : 0x24c722f3ddac40d511ef390d052fe09a46a9949fdc8eca480780de99ec526114::builder_registry::claim_builder_number(arg0),
            name            : arg1,
            role            : arg2,
            course          : arg3,
            country         : arg4,
            specialization  : arg5,
            year            : arg6,
            category        : arg7,
            institution     : arg8,
            skills          : arg9,
            completion_date : arg10,
            reflection      : arg11,
            website         : arg12,
        };
        0x2::transfer::public_transfer<BuilderCard>(v0, 0x2::tx_context::sender(arg13));
    }

    // decompiled from Move bytecode v7
}

