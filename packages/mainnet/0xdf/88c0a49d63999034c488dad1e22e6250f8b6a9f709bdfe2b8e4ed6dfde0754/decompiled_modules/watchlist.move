module 0xdf88c0a49d63999034c488dad1e22e6250f8b6a9f709bdfe2b8e4ed6dfde0754::watchlist {
    struct Watchlist has store, key {
        id: 0x2::object::UID,
        names: vector<0x1::string::String>,
    }

    struct Watched has copy, drop {
        watcher: address,
        name: 0x1::string::String,
    }

    struct Unwatched has copy, drop {
        watcher: address,
        name: 0x1::string::String,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Watchlist{
            id    : 0x2::object::new(arg0),
            names : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::transfer<Watchlist>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_watching(arg0: &Watchlist, arg1: &0x1::string::String) : bool {
        0x1::vector::contains<0x1::string::String>(&arg0.names, arg1)
    }

    public fun names(arg0: &Watchlist) : &vector<0x1::string::String> {
        &arg0.names
    }

    public fun unwatch(arg0: &mut Watchlist, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0.names)) {
            if (0x1::vector::borrow<0x1::string::String>(&arg0.names, v0) == &arg1) {
                0x1::vector::remove<0x1::string::String>(&mut arg0.names, v0);
                let v1 = Unwatched{
                    watcher : 0x2::tx_context::sender(arg2),
                    name    : arg1,
                };
                0x2::event::emit<Unwatched>(v1);
                return
            };
            v0 = v0 + 1;
        };
    }

    public fun watch(arg0: &mut Watchlist, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0.names)) {
            if (0x1::vector::borrow<0x1::string::String>(&arg0.names, v0) == &arg1) {
                return
            };
            v0 = v0 + 1;
        };
        0x1::vector::push_back<0x1::string::String>(&mut arg0.names, arg1);
        let v1 = Watched{
            watcher : 0x2::tx_context::sender(arg2),
            name    : arg1,
        };
        0x2::event::emit<Watched>(v1);
    }

    // decompiled from Move bytecode v6
}

