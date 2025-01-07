module 0xce2df00f6d9288699a0613fdfe866d4bb9e26ab174c38c68e402be237f23164f::egg {
    struct Genesis has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        egg_type: 0x1::string::String,
        rarity: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct Normal has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        egg_type: 0x1::string::String,
        rarity: 0x1::string::String,
        url: 0x1::string::String,
    }

    public fun mint_genesis(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : Genesis {
        Genesis{
            id       : 0x2::object::new(arg4),
            name     : arg0,
            egg_type : arg1,
            rarity   : arg2,
            url      : arg3,
        }
    }

    public fun mint_normal(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : Normal {
        Normal{
            id       : 0x2::object::new(arg4),
            name     : arg0,
            egg_type : arg1,
            rarity   : arg2,
            url      : arg3,
        }
    }

    public fun name_genesis(arg0: &Genesis) : 0x1::string::String {
        arg0.name
    }

    public fun name_normal(arg0: &Normal) : 0x1::string::String {
        arg0.name
    }

    public fun set_url_genesis(arg0: &mut Genesis, arg1: 0x1::string::String) {
        arg0.url = arg1;
    }

    public fun set_url_normal(arg0: &mut Normal, arg1: 0x1::string::String) {
        arg0.url = arg1;
    }

    public fun url_genesis(arg0: &Genesis) : 0x1::string::String {
        arg0.url
    }

    public fun url_normal(arg0: &Normal) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

