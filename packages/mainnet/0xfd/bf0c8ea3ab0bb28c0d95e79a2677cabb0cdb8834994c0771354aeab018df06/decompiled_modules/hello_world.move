module 0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::hello_world {
    struct NFT has store, key {
        id: 0x2::object::UID,
        number: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct HELLO_WORLD has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: NFT) {
        let NFT {
            id     : v0,
            number : _,
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
        let (v3, v4) = 0x2::transfer_policy::new<NFT>(&v1, arg1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT>>(v3);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : NFT {
        NFT{
            id     : 0x2::object::new(arg2),
            number : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

