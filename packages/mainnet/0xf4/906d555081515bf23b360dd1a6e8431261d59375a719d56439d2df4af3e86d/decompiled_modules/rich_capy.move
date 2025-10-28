module 0xf4906d555081515bf23b360dd1a6e8431261d59375a719d56439d2df4af3e86d::rich_capy {
    struct RichCapy has store, key {
        id: 0x2::object::UID,
        no: u64,
        name: 0x1::string::String,
    }

    struct Config has key {
        id: 0x2::object::UID,
        supply: u64,
    }

    struct RICH_CAPY has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: RichCapy) {
        let RichCapy {
            id   : v0,
            no   : _,
            name : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: RICH_CAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeibphcnj3p2p5gnp5z2vcfjcukx4jzapylugrmypmk5v3ou6mrkgrm/{no}.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Week4: NFT Demo"));
        let v4 = 0x2::package::claim<RICH_CAPY>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<RichCapy>(&v4, v0, v2, arg1);
        0x2::display::update_version<RichCapy>(&mut v5);
        let v6 = Config{
            id     : 0x2::object::new(arg1),
            supply : 0,
        };
        0x2::transfer::share_object<Config>(v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<RichCapy>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut Config, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RichCapy{
            id   : 0x2::object::new(arg2),
            no   : arg0.supply,
            name : arg1,
        };
        arg0.supply = arg0.supply + 1;
        0x2::transfer::public_transfer<RichCapy>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

