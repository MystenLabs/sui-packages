module 0x8c139ac63c01fe9e0085dd213e741c13b3e530034a9105d7195826c91871adb3::camel_nft {
    struct CAMEL_NFT has drop {
        dummy_field: bool,
    }

    struct Camel has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        traits: vector<0x1::string::String>,
        url: 0x1::string::String,
    }

    struct CamelMinted has copy, drop {
        camel_id: 0x2::object::ID,
        minted_by: address,
    }

    entry fun add_trait(arg0: &mut Camel, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.traits, arg1);
    }

    entry fun destroy(arg0: Camel) {
        let Camel {
            id     : v0,
            name   : _,
            traits : _,
            url    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: CAMEL_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"traits"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{traits}"));
        let v4 = 0x2::package::claim<CAMEL_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Camel>(&v4, v0, v2, arg1);
        0x2::display::update_version<Camel>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Camel>>(v5, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = CamelMinted{
            camel_id  : 0x2::object::uid_to_inner(&v0),
            minted_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<CamelMinted>(v1);
        let v2 = Camel{
            id     : v0,
            name   : arg0,
            traits : 0x1::vector::empty<0x1::string::String>(),
            url    : arg1,
        };
        0x2::transfer::public_transfer<Camel>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun name(arg0: &Camel) : 0x1::string::String {
        arg0.name
    }

    entry fun set_url(arg0: &mut Camel, arg1: 0x1::string::String) {
        arg0.url = arg1;
    }

    public fun traits(arg0: &Camel) : &vector<0x1::string::String> {
        &arg0.traits
    }

    public fun url(arg0: &Camel) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

