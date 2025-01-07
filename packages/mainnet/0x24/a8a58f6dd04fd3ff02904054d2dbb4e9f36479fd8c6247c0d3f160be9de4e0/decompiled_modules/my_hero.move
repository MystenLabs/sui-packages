module 0x24a8a58f6dd04fd3ff02904054d2dbb4e9f36479fd8c6247c0d3f160be9de4e0::my_hero {
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
        assert!(@0xfab5b29ad356b38284ef90663493d9bf689150c079a06f0a21088eaa22cd362b == 0x2::tx_context::sender(arg0), 0);
        let v0 = 0x2::tx_context::sender(arg0);
        admin(arg0, 0, 200, v0);
    }

    public entry fun admin10(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x27e6bd74a695d3552a545fb48e2a98902565ab67120991ad67e3eab0e798af6f;
        assert!(v0 == 0x2::tx_context::sender(arg0), 0);
        admin(arg0, 1800, 2000, v0);
    }

    public entry fun admin2(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x6a9fe79297969ea78b082296500e4c1e898bf684473abd8cc7a18f1efbfd0e3e;
        assert!(v0 == 0x2::tx_context::sender(arg0), 0);
        admin(arg0, 200, 400, v0);
    }

    public entry fun admin3(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x171b5d2b640cd98ca1826e16711515867bfc44625277cc3baf195550044996ea;
        assert!(v0 == 0x2::tx_context::sender(arg0), 0);
        admin(arg0, 400, 600, v0);
    }

    public entry fun admin4(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xd40253436e44fd5c451f476a0397aea4c203181823778727c9c11b086124df17;
        assert!(v0 == 0x2::tx_context::sender(arg0), 0);
        admin(arg0, 600, 800, v0);
    }

    public entry fun admin5(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xfab5b29ad356b38284ef90663493d9bf689150c079a06f0a21088eaa22cd362b;
        assert!(v0 == 0x2::tx_context::sender(arg0), 0);
        admin(arg0, 800, 1000, v0);
    }

    public entry fun admin6(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x6a9fe79297969ea78b082296500e4c1e898bf684473abd8cc7a18f1efbfd0e3e;
        assert!(v0 == 0x2::tx_context::sender(arg0), 0);
        admin(arg0, 1000, 1200, v0);
    }

    public entry fun admin7(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x74cafb27c824ee54f78e82db497f3877bb0fcfeb809b94e2dfa6cf313de0295a;
        assert!(v0 == 0x2::tx_context::sender(arg0), 0);
        admin(arg0, 1200, 1400, v0);
    }

    public entry fun admin8(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xde8f033826fca49670bf9cab49bd74f55167ddf7263ba53ee989c60d9c76739c;
        assert!(v0 == 0x2::tx_context::sender(arg0), 0);
        admin(arg0, 1400, 1600, v0);
    }

    public entry fun admin9(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x35e4ad36264526a8591251afc4cd36baec0ae19462acc59951e8b70dce848ac0;
        assert!(v0 == 0x2::tx_context::sender(arg0), 0);
        admin(arg0, 1600, 1800, v0);
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

