module 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::oracle {
    struct Oracle has key {
        id: 0x2::object::UID,
        nonce: u16,
        main: 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Source,
        guard: 0x1::option::Option<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Source>,
    }

    public(friend) fun create(arg0: &mut 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::registry::OracleRegistry, arg1: u16, arg2: 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Source, arg3: 0x1::option::Option<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Source>) : Oracle {
        0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::registry::bump_total_oracles(arg0);
        Oracle{
            id    : 0x2::derived_object::claim<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::keys::OracleKey>(0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::registry::uid_mut(arg0), 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::keys::oracle_key(arg1)),
            nonce : arg1,
            main  : arg2,
            guard : arg3,
        }
    }

    public fun guard(arg0: &Oracle) : 0x1::option::Option<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Source> {
        arg0.guard
    }

    public fun has_guard(arg0: &Oracle) : bool {
        0x1::option::is_some<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Source>(&arg0.guard)
    }

    public fun main(arg0: &Oracle) : 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Source {
        arg0.main
    }

    public fun nonce(arg0: &Oracle) : u16 {
        arg0.nonce
    }

    public(friend) fun share(arg0: Oracle) {
        0x2::transfer::share_object<Oracle>(arg0);
    }

    // decompiled from Move bytecode v7
}

