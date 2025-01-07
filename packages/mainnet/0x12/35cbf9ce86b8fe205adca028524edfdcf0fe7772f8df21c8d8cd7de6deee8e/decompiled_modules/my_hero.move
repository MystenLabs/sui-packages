module 0x1235cbf9ce86b8fe205adca028524edfdcf0fe7772f8df21c8d8cd7de6deee8e::my_hero {
    struct Hero has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct MY_HERO has drop {
        dummy_field: bool,
    }

    public fun admin(arg0: &mut 0x2::tx_context::TxContext, arg1: u64, arg2: u64, arg3: address) {
        while (arg1 < arg2 + arg1) {
            let v0 = Hero{
                id   : 0x2::object::new(arg0),
                name : to_string(arg1),
            };
            0x2::transfer::public_transfer<Hero>(v0, arg3);
            arg1 = arg1 + 1;
        };
    }

    public entry fun admin1(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(@0xf1371339d1c9bc4b16b792ef6cb73fa31682203e1124e224fdd57a2ce391a4d6 == 0x2::tx_context::sender(arg0), 0);
        let v0 = 0x2::tx_context::sender(arg0);
        admin(arg0, 0, 200, v0);
    }

    public entry fun admin10(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xbabe2a2e4e210772337354996e709df7ea59eb1fb2afd3413d9980e77abd00d1;
        assert!(v0 == 0x2::tx_context::sender(arg0), 0);
        admin(arg0, 1800, 200, v0);
    }

    public entry fun admin2(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x6a9fe79297969ea78b082296500e4c1e898bf684473abd8cc7a18f1efbfd0e3e;
        assert!(v0 == 0x2::tx_context::sender(arg0), 0);
        admin(arg0, 200, 200, v0);
    }

    public entry fun admin3(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x171b5d2b640cd98ca1826e16711515867bfc44625277cc3baf195550044996ea;
        assert!(v0 == 0x2::tx_context::sender(arg0), 0);
        admin(arg0, 400, 200, v0);
    }

    public entry fun admin4(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xd40253436e44fd5c451f476a0397aea4c203181823778727c9c11b086124df17;
        assert!(v0 == 0x2::tx_context::sender(arg0), 0);
        admin(arg0, 600, 200, v0);
    }

    public entry fun admin5(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x1275f7c92d74de259936fef0865a2883716b9c0f140697133caaf5b7f2223b5e;
        assert!(v0 == 0x2::tx_context::sender(arg0), 0);
        admin(arg0, 800, 200, v0);
    }

    public entry fun admin6(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x3f108a2f6b1fa1c713d839fb7fefaa7778ff5cf61731ddece14bae1bfda766f5;
        assert!(v0 == 0x2::tx_context::sender(arg0), 0);
        admin(arg0, 1000, 200, v0);
    }

    public entry fun admin7(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x9fd14b1e343b540ff402dabf72f0edc7724c89898dfdd35f3b7535113cbf631d;
        assert!(v0 == 0x2::tx_context::sender(arg0), 0);
        admin(arg0, 1200, 200, v0);
    }

    public entry fun admin8(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x49810609b28cc99a5e20cad3638a1ff14c15c644c1d246eb2d01827da318398e;
        assert!(v0 == 0x2::tx_context::sender(arg0), 0);
        admin(arg0, 1400, 200, v0);
    }

    public entry fun admin9(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xc792f96ef5dc6b59ae4e4716556735eca6b80717180541f3b064a0bcd4885d80;
        assert!(v0 == 0x2::tx_context::sender(arg0), 0);
        admin(arg0, 1600, 200, v0);
    }

    fun init(arg0: MY_HERO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Broken Apes Yacht Club #{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmeFgEuoXjtbJgXhSi2ibek2t8HD1B25pfFBmWp5doBoRm/{name}.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmeFgEuoXjtbJgXhSi2ibek2t8HD1B25pfFBmWp5doBoRm/{name}.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"2000 AI-generated collection inspired by Bored Apes Yacht Club"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Unknown Sui Fan"));
        let v4 = 0x2::package::claim<MY_HERO>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Hero>(&v4, v0, v2, arg1);
        0x2::display::update_version<Hero>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Hero>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

