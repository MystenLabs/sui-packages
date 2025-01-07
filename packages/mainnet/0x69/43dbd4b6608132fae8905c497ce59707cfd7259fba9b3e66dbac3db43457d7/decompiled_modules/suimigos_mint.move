module 0x6943dbd4b6608132fae8905c497ce59707cfd7259fba9b3e66dbac3db43457d7::suimigos_mint {
    struct Suimigos has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct Counter has key {
        id: 0x2::object::UID,
        owner: address,
        value: u64,
    }

    struct SUIMIGOS_MINT has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: Suimigos, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Suimigos>(arg0, arg1);
    }

    public fun url(arg0: &Suimigos) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: Suimigos, arg1: &mut 0x2::tx_context::TxContext) {
        let Suimigos {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun counter_value(arg0: &Counter) : &u64 {
        &arg0.value
    }

    public fun description(arg0: &Suimigos) : &0x1::string::String {
        &arg0.description
    }

    public fun increment(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    fun init(arg0: SUIMIGOS_MINT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Suizzle"));
        let v4 = 0x2::package::claim<SUIMIGOS_MINT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Suimigos>(&v4, v0, v2, arg1);
        0x2::display::update_version<Suimigos>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Suimigos>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Counter{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
            value : 0,
        };
        0x2::transfer::share_object<Counter>(v6);
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : Suimigos {
        let v0 = Suimigos{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<Suimigos>(&v0),
            creator   : 0x2::tx_context::sender(arg3),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        v0
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut Counter, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.value < 4269, 0);
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<Suimigos>(mint(arg0, arg1, arg2, arg4), v0);
        arg3.value = arg3.value + 1;
    }

    public fun name(arg0: &Suimigos) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut Suimigos, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

