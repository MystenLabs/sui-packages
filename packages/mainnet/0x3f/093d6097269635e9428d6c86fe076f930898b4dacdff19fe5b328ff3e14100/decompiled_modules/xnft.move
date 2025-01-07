module 0x3f093d6097269635e9428d6c86fe076f930898b4dacdff19fe5b328ff3e14100::xnft {
    struct XNFT has drop {
        dummy_field: bool,
    }

    struct XcetusManager has key {
        id: 0x2::object::UID,
        nfts: 0x3f093d6097269635e9428d6c86fe076f930898b4dacdff19fe5b328ff3e14100::linked_table::LinkedTable<0x2::object::ID, RewardNftInfo>,
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
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Navi Reward Pass"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://static.wixstatic.com/media/33e670_67fea55863fd49548021097e6ad5b51b~mv2.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Support and Earn in our Navi Protocol."));
        let v4 = 0x2::package::claim<XNFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<RewardNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<RewardNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<RewardNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = XcetusManager{
            id   : 0x2::object::new(arg1),
            nfts : 0x3f093d6097269635e9428d6c86fe076f930898b4dacdff19fe5b328ff3e14100::linked_table::new<0x2::object::ID, RewardNftInfo>(arg1),
        };
        0x2::transfer::share_object<XcetusManager>(v6);
    }

    public fun mint(arg0: &mut XcetusManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = new_venft(arg2);
        let v1 = 0x2::object::id<RewardNFT>(&v0);
        let v2 = RewardNftInfo{id: v1};
        0x3f093d6097269635e9428d6c86fe076f930898b4dacdff19fe5b328ff3e14100::linked_table::push_back<0x2::object::ID, RewardNftInfo>(&mut arg0.nfts, v1, v2);
        0x2::transfer::transfer<RewardNFT>(v0, arg1);
    }

    fun new_venft(arg0: &mut 0x2::tx_context::TxContext) : RewardNFT {
        RewardNFT{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"Sui Reward Pass"),
        }
    }

    public fun nfts(arg0: &XcetusManager) : &0x3f093d6097269635e9428d6c86fe076f930898b4dacdff19fe5b328ff3e14100::linked_table::LinkedTable<0x2::object::ID, RewardNftInfo> {
        &arg0.nfts
    }

    // decompiled from Move bytecode v6
}

