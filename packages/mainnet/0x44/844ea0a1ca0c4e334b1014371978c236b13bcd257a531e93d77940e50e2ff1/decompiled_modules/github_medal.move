module 0x44844ea0a1ca0c4e334b1014371978c236b13bcd257a531e93d77940e50e2ff1::github_medal {
    struct GithubMedal has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        email: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct EventMint has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun transfer(arg0: GithubMedal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<GithubMedal>(arg0, arg1);
    }

    public fun url(arg0: &GithubMedal) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: GithubMedal, arg1: &mut 0x2::tx_context::TxContext) {
        let GithubMedal {
            id          : v0,
            name        : _,
            email       : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &GithubMedal) : &0x1::string::String {
        &arg0.description
    }

    public fun email(arg0: &GithubMedal) : &0x1::string::String {
        &arg0.email
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = GithubMedal{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            email       : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v2 = EventMint{
            object_id : 0x2::object::id<GithubMedal>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<EventMint>(v2);
        0x2::transfer::public_transfer<GithubMedal>(v1, v0);
    }

    public fun name(arg0: &GithubMedal) : &0x1::string::String {
        &arg0.name
    }

    public fun set_description(arg0: &mut GithubMedal, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public fun set_email(arg0: &mut GithubMedal, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.email = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

