module 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::studio {
    struct StudioCap has store, key {
        id: 0x2::object::UID,
        studio: 0x2::object::ID,
    }

    struct Studio has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x1::string::String,
        games: vector<0x2::object::ID>,
    }

    public(friend) fun add_game(arg0: &mut Studio, arg1: 0x2::object::ID) {
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.games) < 512, 303);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.games, arg1);
    }

    public(friend) fun assert_cap(arg0: &Studio, arg1: &StudioCap) {
        assert!(arg1.studio == 0x2::object::id<Studio>(arg0), 301);
    }

    public fun cap_studio(arg0: &StudioCap) : 0x2::object::ID {
        arg0.studio
    }

    fun check(arg0: &0x1::string::String, arg1: &0x1::string::String) {
        assert!(0x1::string::length(arg0) > 0, 304);
        assert!(0x1::string::length(arg0) <= 64 && 0x1::string::length(arg1) <= 512, 302);
    }

    public fun games(arg0: &Studio) : vector<0x2::object::ID> {
        arg0.games
    }

    public fun name(arg0: &Studio) : 0x1::string::String {
        arg0.name
    }

    public fun register(arg0: &mut 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::Store, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : StudioCap {
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::assert_live(arg0);
        check(&arg1, &arg2);
        let v0 = Studio{
            id    : 0x2::object::new(arg3),
            name  : arg1,
            url   : arg2,
            games : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v1 = 0x2::object::id<Studio>(&v0);
        let v2 = StudioCap{
            id     : 0x2::object::new(arg3),
            studio : v1,
        };
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::studio_registered(v1, 0x2::object::id<StudioCap>(&v2), v0.name, 0x2::tx_context::sender(arg3));
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::count_studio(arg0);
        0x2::transfer::share_object<Studio>(v0);
        v2
    }

    public fun set_profile(arg0: &StudioCap, arg1: &mut Studio, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert_cap(arg1, arg0);
        check(&arg2, &arg3);
        arg1.name = arg2;
        arg1.url = arg3;
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::studio_updated(0x2::object::id<Studio>(arg1), arg2, arg3);
    }

    public fun url(arg0: &Studio) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v7
}

