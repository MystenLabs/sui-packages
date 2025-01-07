module 0x5ef5c2b2a6e5de44a9a3c72e8f583fb614ffaa8b6c79140c5881189abd32ef5e::suidex_nft {
    struct SUIDEX_NFT has drop {
        dummy_field: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct NFTManager has store, key {
        id: 0x2::object::UID,
        open_enable: bool,
        mint_enable: bool,
        minted: u64,
        mint_fee: u64,
        supply: u64,
        owner: address,
        public_time: u64,
        start_time: u64,
        whitelist: vector<address>,
    }

    struct TicketStore has key {
        id: 0x2::object::UID,
    }

    struct DOF has store, key {
        id: 0x2::object::UID,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    entry fun add_users(arg0: &mut NFTManager, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2) || 0x2::tx_context::sender(arg2) == @0x9d808f9076b8cfb108221367240a5a5e1bd831090716db464c45fc15a3087a0c, 7);
        0x1::vector::append<address>(&mut arg0.whitelist, arg1);
    }

    fun assert_whitelist(arg0: u64, arg1: &mut NFTManager, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0 < arg1.public_time) {
            let v0 = 0x2::tx_context::sender(arg2);
            let (v1, _) = 0x1::vector::index_of<address>(&arg1.whitelist, &v0);
            assert!(v1, 6);
        };
    }

    fun init(arg0: SUIDEX_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"The first AMM (Automated Market Maker) on the SUI blockchain, created to enable safe and decentralized token swaps. The protocol uses smart contracts developed by our team, written in the MOVE"));
        let v4 = 0x2::package::claim<SUIDEX_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = NFTManager{
            id          : 0x2::object::new(arg1),
            open_enable : false,
            mint_enable : true,
            minted      : 0,
            mint_fee    : 5000000000,
            supply      : 600,
            owner       : 0x2::tx_context::sender(arg1),
            public_time : 1683640800000,
            start_time  : 1683637200000,
            whitelist   : 0x1::vector::empty<address>(),
        };
        0x2::transfer::public_share_object<NFTManager>(v6);
    }

    public entry fun mint(arg0: &0x2::clock::Clock, arg1: &mut NFTManager, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert_whitelist(v0, arg1, arg3);
        assert!(v0 > arg1.start_time, 9);
        assert!(arg1.mint_enable, 2);
        assert!(!0x2::dynamic_object_field::exists_<address>(&arg1.id, 0x2::tx_context::sender(arg3)), 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg1.mint_fee, 1);
        assert!(arg1.minted < arg1.supply, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x9d808f9076b8cfb108221367240a5a5e1bd831090716db464c45fc15a3087a0c);
        let v1 = b"https://suidex.io/metadata/";
        let v2 = v1;
        0x1::vector::append<u8>(&mut v2, b"chest.png");
        let v3 = NFT{
            id        : 0x2::object::new(arg3),
            name      : 0x1::string::utf8(b"SuiDex Treasure"),
            image_url : 0x2::url::new_unsafe_from_bytes(v2),
        };
        let v4 = DOF{id: 0x2::object::new(arg3)};
        0x2::dynamic_object_field::add<address, DOF>(&mut arg1.id, 0x2::tx_context::sender(arg3), v4);
        let v5 = 0x2::tx_context::sender(arg3);
        let v6 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v3.id),
            creator   : v5,
            name      : v3.name,
        };
        0x2::event::emit<MintNFTEvent>(v6);
        0x2::transfer::public_transfer<NFT>(v3, v5);
        arg1.minted = arg1.minted + 1;
    }

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun open(arg0: &mut NFT, arg1: &NFTManager) {
        assert!(arg1.open_enable, 3);
        let v0 = b"https://suidex.io/metadata/";
        let v1 = v0;
        0x1::vector::append<u8>(&mut v1, 0x2::hex::encode(0x2::object::uid_to_bytes(&arg0.id)));
        arg0.image_url = 0x2::url::new_unsafe_from_bytes(v1);
    }

    entry fun remove_users(arg0: &mut NFTManager, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2) || 0x2::tx_context::sender(arg2) == @0x9d808f9076b8cfb108221367240a5a5e1bd831090716db464c45fc15a3087a0c, 7);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let (v1, v2) = 0x1::vector::index_of<address>(&arg0.whitelist, 0x1::vector::borrow<address>(&arg1, v0));
            if (v1) {
                0x1::vector::remove<address>(&mut arg0.whitelist, v2);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun set_mint_fee(arg0: &mut NFTManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner || 0x2::tx_context::sender(arg2) == @0x9d808f9076b8cfb108221367240a5a5e1bd831090716db464c45fc15a3087a0c, 4);
        arg0.mint_fee = arg1;
    }

    public entry fun set_public_time(arg0: &mut NFTManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner || 0x2::tx_context::sender(arg2) == @0x9d808f9076b8cfb108221367240a5a5e1bd831090716db464c45fc15a3087a0c, 4);
        arg0.public_time = arg1;
    }

    public entry fun settings(arg0: &mut NFTManager, arg1: bool, arg2: bool, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner || 0x2::tx_context::sender(arg5) == @0x9d808f9076b8cfb108221367240a5a5e1bd831090716db464c45fc15a3087a0c, 4);
        arg0.open_enable = arg2;
        arg0.mint_enable = arg1;
        arg0.start_time = arg3;
        arg0.supply = arg4;
    }

    public fun url_url(arg0: &NFT) : &0x2::url::Url {
        &arg0.image_url
    }

    // decompiled from Move bytecode v6
}

