module 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence {
    struct Licence has key {
        id: 0x2::object::UID,
        game: 0x2::object::ID,
        slug: 0x1::string::String,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        edition: u64,
        version: u64,
        sha256: vector<vector<u8>>,
        purchased_at_ms: u64,
        number: u64,
    }

    struct ResaleLicence has store, key {
        id: 0x2::object::UID,
        game: 0x2::object::ID,
        slug: 0x1::string::String,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        edition: u64,
        version: u64,
        sha256: vector<vector<u8>>,
        purchased_at_ms: u64,
        number: u64,
        held_since_ms: u64,
        origin: 0x2::object::ID,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: vector<vector<u8>>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : Licence {
        Licence{
            id              : 0x2::object::new(arg9),
            game            : arg0,
            slug            : arg1,
            name            : arg2,
            image_url       : arg3,
            edition         : arg4,
            version         : arg5,
            sha256          : arg6,
            purchased_at_ms : arg7,
            number          : arg8,
        }
    }

    public(friend) fun burn(arg0: Licence) {
        let Licence {
            id              : v0,
            game            : _,
            slug            : _,
            name            : _,
            image_url       : _,
            edition         : _,
            version         : _,
            sha256          : _,
            purchased_at_ms : _,
            number          : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun edition(arg0: &Licence) : u64 {
        arg0.edition
    }

    public fun game(arg0: &Licence) : 0x2::object::ID {
        arg0.game
    }

    public fun held_since_ms(arg0: &ResaleLicence) : u64 {
        arg0.held_since_ms
    }

    public(friend) fun into_resale(arg0: Licence, arg1: &mut 0x2::tx_context::TxContext) : ResaleLicence {
        let Licence {
            id              : v0,
            game            : v1,
            slug            : v2,
            name            : v3,
            image_url       : v4,
            edition         : v5,
            version         : v6,
            sha256          : v7,
            purchased_at_ms : v8,
            number          : v9,
        } = arg0;
        0x2::object::delete(v0);
        ResaleLicence{
            id              : 0x2::object::new(arg1),
            game            : v1,
            slug            : v2,
            name            : v3,
            image_url       : v4,
            edition         : v5,
            version         : v6,
            sha256          : v7,
            purchased_at_ms : v8,
            number          : v9,
            held_since_ms   : v8,
            origin          : 0x2::object::id<Licence>(&arg0),
        }
    }

    public fun number(arg0: &Licence) : u64 {
        arg0.number
    }

    public fun origin(arg0: &ResaleLicence) : 0x2::object::ID {
        arg0.origin
    }

    public fun purchased_at_ms(arg0: &Licence) : u64 {
        arg0.purchased_at_ms
    }

    public fun resale_edition(arg0: &ResaleLicence) : u64 {
        arg0.edition
    }

    public fun resale_game(arg0: &ResaleLicence) : 0x2::object::ID {
        arg0.game
    }

    public fun resale_number(arg0: &ResaleLicence) : u64 {
        arg0.number
    }

    public fun resale_purchased_at_ms(arg0: &ResaleLicence) : u64 {
        arg0.purchased_at_ms
    }

    public fun resale_sha256(arg0: &ResaleLicence) : vector<vector<u8>> {
        arg0.sha256
    }

    public fun resale_slug(arg0: &ResaleLicence) : 0x1::string::String {
        arg0.slug
    }

    public fun resale_version(arg0: &ResaleLicence) : u64 {
        arg0.version
    }

    public(friend) fun send(arg0: Licence, arg1: address) {
        0x2::transfer::transfer<Licence>(arg0, arg1);
    }

    public(friend) fun set_held_since(arg0: &mut ResaleLicence, arg1: u64) {
        arg0.held_since_ms = arg1;
    }

    public fun sha256(arg0: &Licence) : vector<vector<u8>> {
        arg0.sha256
    }

    public fun slug(arg0: &Licence) : 0x1::string::String {
        arg0.slug
    }

    public fun version(arg0: &Licence) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

