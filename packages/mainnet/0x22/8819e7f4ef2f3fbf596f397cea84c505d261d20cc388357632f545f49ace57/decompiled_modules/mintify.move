module 0x228819e7f4ef2f3fbf596f397cea84c505d261d20cc388357632f545f49ace57::mintify {
    struct Mint has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct Minted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct MINTIFY has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: Mint, arg1: &mut 0x2::tx_context::TxContext) {
        let Mint {
            id        : v0,
            name      : _,
            image_url : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: MINTIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-heroes.io/hero/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A true Hero of the Sui ecosystem!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-heroes.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Unknown Sui Fan"));
        let v4 = 0x2::package::claim<MINTIFY>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Mint>(&v4, v0, v2, arg1);
        0x2::display::update_version<Mint>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Mint>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : Mint {
        let v0 = Mint{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            image_url : arg1,
        };
        let v1 = Minted{
            object_id : 0x2::object::id<Mint>(&v0),
            creator   : 0x2::tx_context::sender(arg2),
            name      : v0.name,
        };
        0x2::event::emit<Minted>(v1);
        v0
    }

    public fun name(arg0: &Mint) : &0x1::string::String {
        &arg0.name
    }

    public fun update_name(arg0: &mut Mint, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    public fun update_url(arg0: &mut Mint, arg1: 0x1::string::String) {
        arg0.image_url = arg1;
    }

    // decompiled from Move bytecode v6
}

