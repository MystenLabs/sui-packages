module 0xaf993a42b895851a4ec353c44d1e9e75855c1ad01e00f8ea4732ea2c9dd621d9::mintify {
    struct MintNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        alt: 0x1::string::String,
        image_url: 0x2::url::Url,
        mintor: address,
    }

    struct MINTIFY has drop {
        dummy_field: bool,
    }

    struct Mint has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun alt(arg0: &MintNft) : &0x1::string::String {
        &arg0.alt
    }

    public fun burn(arg0: MintNft, arg1: &mut 0x2::tx_context::TxContext) {
        let MintNft {
            id        : v0,
            name      : _,
            alt       : _,
            image_url : _,
            mintor    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun image_url(arg0: &MintNft) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: MINTIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Infinit Custom Minted NFTs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://mintify.wal.app"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"McXross / Sui Network UG"));
        let v4 = 0x2::package::claim<MINTIFY>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MintNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<MintNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MintNft>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0xaf993a42b895851a4ec353c44d1e9e75855c1ad01e00f8ea4732ea2c9dd621d9::fees::Fees, arg5: &mut 0x2::tx_context::TxContext) : (MintNft, 0x2::coin::Coin<0x2::sui::SUI>) {
        0xaf993a42b895851a4ec353c44d1e9e75855c1ad01e00f8ea4732ea2c9dd621d9::fees::collect(arg4, &mut arg3, arg5);
        let v0 = MintNft{
            id        : 0x2::object::new(arg5),
            name      : arg0,
            alt       : arg1,
            image_url : 0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(arg2)),
            mintor    : 0x2::tx_context::sender(arg5),
        };
        let v1 = Mint{
            object_id : 0x2::object::id<MintNft>(&v0),
            creator   : 0x2::tx_context::sender(arg5),
            name      : v0.name,
        };
        0x2::event::emit<Mint>(v1);
        (v0, arg3)
    }

    public fun mintor(arg0: &MintNft) : &address {
        &arg0.mintor
    }

    public fun name(arg0: &MintNft) : &0x1::string::String {
        &arg0.name
    }

    public fun update_alt(arg0: &mut MintNft, arg1: 0x1::string::String) {
        arg0.alt = arg1;
    }

    public fun update_image_url(arg0: &mut MintNft, arg1: 0x1::string::String) {
        arg0.image_url = 0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(arg1));
    }

    public fun update_name(arg0: &mut MintNft, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    // decompiled from Move bytecode v6
}

