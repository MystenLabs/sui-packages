module 0x8a6ba355253a62720ce6ce6c873ff03511cd4d5f6d942a62a5160c75315e5cd8::walrus_presents {
    struct WALRUS_PRESENTS has drop {
        dummy_field: bool,
    }

    struct WalrusPresents has store, key {
        id: 0x2::object::UID,
        number: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct Counter has key {
        id: 0x2::object::UID,
        count: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Mint has copy, drop {
        pos0: 0x1::type_name::TypeName,
        pos1: u64,
    }

    public fun destroy_admin_cap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_counter(arg0: Counter) {
        let Counter {
            id    : v0,
            count : v1,
        } = arg0;
        assert!(v1 == 1000, 9223372444876668927);
        0x2::object::delete(v0);
    }

    fun init(arg0: WALRUS_PRESENTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Walrus Presents"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A commemorative NFT from Artizm, powered by Anima Labs."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<WALRUS_PRESENTS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<WalrusPresents>(&v4, v0, v2, arg1);
        0x2::display::update_version<WalrusPresents>(&mut v5);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        let v7 = Counter{
            id    : 0x2::object::new(arg1),
            count : 0,
        };
        let v8 = 0x2::tx_context::sender(arg1);
        0x2::transfer::share_object<Counter>(v7);
        0x2::transfer::public_transfer<0x2::display::Display<WalrusPresents>>(v5, v8);
        0x2::transfer::public_transfer<AdminCap>(v6, v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v8);
    }

    public fun mint(arg0: &mut Counter, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : WalrusPresents {
        let v0 = WalrusPresents{
            id          : 0x2::object::new(arg2),
            number      : arg0.count,
            name        : 0x1::string::utf8(b"Walrus Presents"),
            image_url   : 0x1::string::utf8(b"https://ipfs.io/ipfs/bafkreibijvt66lrwof7kvxrynldgxycwxj4wvkna6qrjoj7drqcmw6twjy"),
            description : 0x1::string::utf8(b"A commemorative NFT from Artizm, powered by Anima Labs."),
        };
        let v1 = Mint{
            pos0 : 0x1::type_name::get<WalrusPresents>(),
            pos1 : arg0.count,
        };
        0x2::event::emit<Mint>(v1);
        arg0.count = arg0.count + 1;
        v0
    }

    // decompiled from Move bytecode v6
}

