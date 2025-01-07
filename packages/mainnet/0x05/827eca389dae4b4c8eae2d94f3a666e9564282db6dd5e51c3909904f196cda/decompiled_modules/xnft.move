module 0x5827eca389dae4b4c8eae2d94f3a666e9564282db6dd5e51c3909904f196cda::xnft {
    struct XNFT has drop {
        dummy_field: bool,
    }

    struct XcetusManager has key {
        id: 0x2::object::UID,
        nfts: 0x5827eca389dae4b4c8eae2d94f3a666e9564282db6dd5e51c3909904f196cda::linked_table::LinkedTable<0x2::object::ID, RewardNftInfo>,
    }

    struct RewardNftInfo has drop, store {
        id: 0x2::object::ID,
    }

    struct RewardNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    fun init(arg0: XNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Reward Pass"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://static.wixstatic.com/media/33e670_7511e661ade54a4f961a7855c1951ca7~mv2.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Support and Earn in our Sui Network."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://rwdsui.net"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Labs"));
        let v4 = 0x2::package::claim<XNFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<RewardNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<RewardNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<RewardNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = XcetusManager{
            id   : 0x2::object::new(arg1),
            nfts : 0x5827eca389dae4b4c8eae2d94f3a666e9564282db6dd5e51c3909904f196cda::linked_table::new<0x2::object::ID, RewardNftInfo>(arg1),
        };
        0x2::transfer::share_object<XcetusManager>(v6);
    }

    public fun mint(arg0: &mut XcetusManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = new_venft(arg2);
        let v1 = 0x2::object::id<RewardNFT>(&v0);
        let v2 = RewardNftInfo{id: v1};
        0x5827eca389dae4b4c8eae2d94f3a666e9564282db6dd5e51c3909904f196cda::linked_table::push_back<0x2::object::ID, RewardNftInfo>(&mut arg0.nfts, v1, v2);
        0x2::transfer::transfer<RewardNFT>(v0, arg1);
    }

    fun new_venft(arg0: &mut 0x2::tx_context::TxContext) : RewardNFT {
        RewardNFT{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"Sui Reward Pass"),
        }
    }

    public fun nfts(arg0: &XcetusManager) : &0x5827eca389dae4b4c8eae2d94f3a666e9564282db6dd5e51c3909904f196cda::linked_table::LinkedTable<0x2::object::ID, RewardNftInfo> {
        &arg0.nfts
    }

    // decompiled from Move bytecode v6
}

