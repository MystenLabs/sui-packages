module 0x825c672f787bd95e5a3dc09adada006171b3743ac66190b12419f068bfc6a50e::stashed {
    struct Stashed has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct StashedMinted has copy, drop {
        object_id: address,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun get_stashed(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Stashed{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = StashedMinted{
            object_id : 0x2::object::uid_to_address(&v1.id),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<StashedMinted>(v2);
        0x2::transfer::public_transfer<Stashed>(v1, v0);
    }

    public entry fun stash_it(arg0: Stashed, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Stashed>(arg0, arg1);
    }

    public fun stashed_description(arg0: &Stashed) : &0x1::string::String {
        &arg0.description
    }

    public fun stashed_name(arg0: &Stashed) : &0x1::string::String {
        &arg0.name
    }

    public fun stashed_url(arg0: &Stashed) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun unstash(arg0: Stashed, arg1: &mut 0x2::tx_context::TxContext) {
        let Stashed {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun you_got_stashed(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Stashed{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v1 = StashedMinted{
            object_id : 0x2::object::uid_to_address(&v0.id),
            creator   : 0x2::tx_context::sender(arg4),
            name      : v0.name,
        };
        0x2::event::emit<StashedMinted>(v1);
        0x2::transfer::public_transfer<Stashed>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

