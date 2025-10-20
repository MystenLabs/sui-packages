module 0x18681a15a167c8f42ce7c4ba8a8ae684aeaef473b3b3747c516833ad6a30c889::LoreHub {
    struct Lore has store, key {
        id: 0x2::object::UID,
        title: vector<u8>,
        genre: vector<u8>,
        file_url: vector<u8>,
        author: address,
    }

    struct LoreRegistry has store, key {
        id: 0x2::object::UID,
        lores: vector<Lore>,
    }

    public fun get_lores(arg0: &LoreRegistry) : &vector<Lore> {
        &arg0.lores
    }

    public entry fun init_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LoreRegistry{
            id    : 0x2::object::new(arg0),
            lores : 0x1::vector::empty<Lore>(),
        };
        0x2::transfer::share_object<LoreRegistry>(v0);
    }

    public entry fun publish_lore(arg0: &mut LoreRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Lore{
            id       : 0x2::object::new(arg4),
            title    : arg1,
            genre    : arg2,
            file_url : arg3,
            author   : 0x2::tx_context::sender(arg4),
        };
        0x1::vector::push_back<Lore>(&mut arg0.lores, v0);
    }

    // decompiled from Move bytecode v6
}

