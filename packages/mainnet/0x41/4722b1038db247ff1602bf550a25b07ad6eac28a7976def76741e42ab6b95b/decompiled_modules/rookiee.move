module 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::rookiee {
    struct ROOKIEE has drop {
        dummy_field: bool,
    }

    struct Rookiex has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        link: 0x2::url::Url,
        image_url: 0x2::url::Url,
        creator: 0x1::string::String,
        xid: u128,
        type: u8,
        rare: u16,
    }

    struct RKAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        display: 0x1::option::Option<0x2::display::Display<Rookiex>>,
    }

    fun burn(arg0: Rookiex) : (u128, u8, u16) {
        let Rookiex {
            id        : v0,
            name      : _,
            link      : _,
            image_url : _,
            creator   : _,
            xid       : v5,
            type      : v6,
            rare      : v7,
        } = arg0;
        0x2::object::delete(v0);
        (v5, v6, v7)
    }

    fun init(arg0: ROOKIEE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ROOKIEE>(arg0, arg1);
        let v1 = setupNft(&v0, arg1);
        let v2 = Vault{
            id      : 0x2::object::new(arg1),
            display : 0x1::option::some<0x2::display::Display<Rookiex>>(v1),
        };
        let v3 = RKAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<Vault>(v2);
        0x2::transfer::public_transfer<RKAdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mintTo(arg0: &RKAdminCap, arg1: address, arg2: u128, arg3: u8, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Rookiex{
            id        : 0x2::object::new(arg5),
            name      : 0x1::string::utf8(b"Default Nft"),
            link      : 0x2::url::new_unsafe_from_bytes(b"https://bird.io/worm/{id}"),
            image_url : 0x2::url::new_unsafe_from_bytes(b"ipfs://{img_url}"),
            creator   : 0x1::string::utf8(b"Bird Labs"),
            xid       : arg2,
            type      : arg3,
            rare      : arg4,
        };
        0x2::transfer::public_transfer<Rookiex>(v0, arg1);
    }

    fun setupNft(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<Rookiex> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rare"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{link}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{xid}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{type}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{rare}"));
        let v4 = 0x2::display::new_with_fields<Rookiex>(arg0, v0, v2, arg1);
        0x2::display::update_version<Rookiex>(&mut v4);
        v4
    }

    // decompiled from Move bytecode v6
}

