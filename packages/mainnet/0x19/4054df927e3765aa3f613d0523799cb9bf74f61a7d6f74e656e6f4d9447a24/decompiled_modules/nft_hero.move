module 0x194054df927e3765aa3f613d0523799cb9bf74f61a7d6f74e656e6f4d9447a24::nft_hero {
    struct NFT_HERO has drop {
        dummy_field: bool,
    }

    struct MyHero has key {
        id: 0x2::object::UID,
        tokenId: u64,
        hp: u64,
        mp: u64,
        xp: u64,
        level: u64,
        createTime: u64,
    }

    struct State has key {
        id: 0x2::object::UID,
        count: u64,
    }

    fun init(arg0: NFT_HERO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"hp"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"mp"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"xp"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"level"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bityoume NFT HERO #{tokenId}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://QmZo2QH4dtav6HQUqztQz81sifqrp3jCcdc5jQ8axyurna"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{hp}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{mp}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{xp}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{level}"));
        let v4 = 0x2::package::claim<NFT_HERO>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MyHero>(&v4, v0, v2, arg1);
        0x2::display::update_version<MyHero>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MyHero>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = State{
            id    : 0x2::object::new(arg1),
            count : 0,
        };
        0x2::transfer::share_object<State>(v6);
    }

    public entry fun mint(arg0: &mut State, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.count = arg0.count + 1;
        let v0 = MyHero{
            id         : 0x2::object::new(arg2),
            tokenId    : arg0.count,
            hp         : 100,
            mp         : 10,
            xp         : 0,
            level      : 1,
            createTime : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::transfer::transfer<MyHero>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun update_hero(arg0: &mut MyHero, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.xp = arg0.xp + 1;
        if (arg0.xp >= arg0.level * 10) {
            arg0.level = arg0.level + 1;
        };
    }

    // decompiled from Move bytecode v6
}

