module 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle {
    struct Oracle has key {
        id: 0x2::object::UID,
        nonce: u16,
        main: 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source,
        guard: 0x1::option::Option<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source>,
    }

    public(friend) fun create(arg0: &mut 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::OracleRegistry, arg1: u16, arg2: 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source, arg3: 0x1::option::Option<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source>) : Oracle {
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::bump_total_oracles(arg0);
        Oracle{
            id    : 0x2::derived_object::claim<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::keys::OracleKey>(0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::uid_mut(arg0), 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::keys::oracle_key(arg1)),
            nonce : arg1,
            main  : arg2,
            guard : arg3,
        }
    }

    public fun guard(arg0: &Oracle) : 0x1::option::Option<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source> {
        arg0.guard
    }

    public fun has_guard(arg0: &Oracle) : bool {
        0x1::option::is_some<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source>(&arg0.guard)
    }

    public fun main(arg0: &Oracle) : 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source {
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

