module 0x8ef4cc70e7d5f846330126bc48cca809adde298322cadd9ae316145a3540860::my_nft {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct MY_NFT has drop {
        dummy_field: bool,
    }

    struct NFTFaucet has key {
        id: 0x2::object::UID,
        minter: u256,
        ntf_to_owner: 0x2::table::Table<vector<u8>, u256>,
    }

    struct NFTMintEvent has copy, drop {
        owner: address,
        nft: address,
    }

    struct NFTBurnEvent has copy, drop {
        nft: address,
        owner: address,
    }

    public entry fun transfer(arg0: &mut NFTFaucet, arg1: MyNFT, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_bytes(&arg1.id);
        assert!(0x2::table::contains<vector<u8>, u256>(&arg0.ntf_to_owner, v0), 5);
        let v1 = 0x2::address::to_u256(0x2::tx_context::sender(arg3));
        assert!(0x2::table::borrow<vector<u8>, u256>(&arg0.ntf_to_owner, v0) == &v1, 4);
        0x2::table::remove<vector<u8>, u256>(&mut arg0.ntf_to_owner, v0);
        0x2::table::add<vector<u8>, u256>(&mut arg0.ntf_to_owner, v0, 0x2::address::to_u256(arg2));
        0x2::transfer::public_transfer<MyNFT>(arg1, arg2);
    }

    public entry fun burn(arg0: &mut NFTFaucet, arg1: MyNFT, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_bytes(&arg1.id);
        assert!(0x2::table::contains<vector<u8>, u256>(&arg0.ntf_to_owner, v0), 5);
        let v1 = 0x2::table::borrow<vector<u8>, u256>(&arg0.ntf_to_owner, v0);
        let v2 = 0x2::address::to_u256(0x2::tx_context::sender(arg2));
        assert!(v1 == &v2, 4);
        let v3 = NFTBurnEvent{
            nft   : 0x2::address::from_bytes(v0),
            owner : 0x2::address::from_u256(*v1),
        };
        0x2::event::emit<NFTBurnEvent>(v3);
        0x2::table::remove<vector<u8>, u256>(&mut arg0.ntf_to_owner, v0);
        let MyNFT {
            id          : v4,
            name        : _,
            description : _,
            url         : _,
        } = arg1;
        0x2::object::delete(v4);
    }

    fun init(arg0: MY_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        let v4 = 0x2::package::claim<MY_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MyNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<MyNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<MyNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        let v6 = NFTFaucet{
            id           : 0x2::object::new(arg1),
            minter       : 0x2::address::to_u256(0x2::tx_context::sender(arg1)),
            ntf_to_owner : 0x2::table::new<vector<u8>, u256>(arg1),
        };
        0x2::transfer::share_object<NFTFaucet>(v6);
    }

    public entry fun mint(arg0: &mut NFTFaucet, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minter == 0x2::address::to_u256(0x2::tx_context::sender(arg5)), 4);
        let v0 = 0x1::string::try_utf8(arg1);
        let v1 = 0x1::string::try_utf8(arg2);
        let v2 = 0x1::string::try_utf8(arg3);
        assert!(0x1::option::is_some<0x1::string::String>(&v0), 1);
        assert!(0x1::option::is_some<0x1::string::String>(&v1), 2);
        assert!(0x1::option::is_some<0x1::string::String>(&v2), 3);
        let v3 = 0x2::object::new(arg5);
        0x2::table::add<vector<u8>, u256>(&mut arg0.ntf_to_owner, 0x2::object::uid_to_bytes(&v3), 0x2::address::to_u256(arg4));
        let v4 = NFTMintEvent{
            owner : arg4,
            nft   : 0x2::object::uid_to_address(&v3),
        };
        0x2::event::emit<NFTMintEvent>(v4);
        let v5 = MyNFT{
            id          : v3,
            name        : 0x1::option::extract<0x1::string::String>(&mut v0),
            description : 0x1::option::extract<0x1::string::String>(&mut v1),
            url         : 0x1::option::extract<0x1::string::String>(&mut v2),
        };
        0x2::transfer::public_transfer<MyNFT>(v5, arg4);
    }

    // decompiled from Move bytecode v6
}

