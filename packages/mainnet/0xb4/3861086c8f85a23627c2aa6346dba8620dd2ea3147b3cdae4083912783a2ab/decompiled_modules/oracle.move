module 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::oracle {
    struct Oracle has key {
        id: 0x2::object::UID,
        nonce: u16,
        main: 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source,
        guard: 0x1::option::Option<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source>,
    }

    public(friend) fun create(arg0: &mut 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::registry::OracleRegistry, arg1: u16, arg2: 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source, arg3: 0x1::option::Option<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source>) : Oracle {
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::registry::bump_total_oracles(arg0);
        Oracle{
            id    : 0x2::derived_object::claim<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::keys::OracleKey>(0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::registry::uid_mut(arg0), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::keys::oracle_key(arg1)),
            nonce : arg1,
            main  : arg2,
            guard : arg3,
        }
    }

    public fun guard(arg0: &Oracle) : 0x1::option::Option<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source> {
        arg0.guard
    }

    public fun has_guard(arg0: &Oracle) : bool {
        0x1::option::is_some<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source>(&arg0.guard)
    }

    public fun main(arg0: &Oracle) : 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source {
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

