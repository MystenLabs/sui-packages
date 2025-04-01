module 0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world {
    struct NFT has store, key {
        id: 0x2::object::UID,
        number: u64,
        image_url: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct HELLO_WORLD has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: NFT) {
        let NFT {
            id        : v0,
            number    : _,
            image_url : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: HELLO_WORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x2::package::claim<HELLO_WORLD>(arg0, arg1);
        let v2 = 0x2::display::new<NFT>(&v1, arg1);
        0x2::display::add<NFT>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Test NFT"));
        0x2::display::add<NFT>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"This is test NFT"));
        0x2::display::add<NFT>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://picsum.photos/id/237/250"));
        let (v3, v4) = 0x2::transfer_policy::new<NFT>(&v1, arg1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT>>(v3);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &AdminCap, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : NFT {
        NFT{
            id        : 0x2::object::new(arg3),
            number    : arg1,
            image_url : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

