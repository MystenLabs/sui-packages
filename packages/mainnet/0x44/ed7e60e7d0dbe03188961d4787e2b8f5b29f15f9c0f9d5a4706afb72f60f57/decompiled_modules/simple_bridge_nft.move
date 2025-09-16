module 0x44ed7e60e7d0dbe03188961d4787e2b8f5b29f15f9c0f9d5a4706afb72f60f57::simple_bridge_nft {
    struct SimpleBridgeNFT has key {
        id: 0x2::object::UID,
        bridged_token: u64,
        user_address: address,
    }

    struct BridgeMintCap has store, key {
        id: 0x2::object::UID,
    }

    struct SIMPLE_BRIDGE_NFT has drop {
        dummy_field: bool,
    }

    struct BridgeReceiptMinted has copy, drop {
        nft_id: 0x2::object::ID,
        recipient: address,
        bridged_amount: u64,
    }

    public fun add_metadata(arg0: &mut 0x2::display::Display<SimpleBridgeNFT>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::display::add<SimpleBridgeNFT>(arg0, 0x1::string::utf8(arg1), 0x1::string::utf8(arg2));
        0x2::display::update_version<SimpleBridgeNFT>(arg0);
    }

    public fun batch_mint_receipts(arg0: &BridgeMintCap, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 0);
        let v1 = 0;
        while (v1 < v0) {
            mint_bridge_receipt(arg0, *0x1::vector::borrow<address>(&arg1, v1), *0x1::vector::borrow<u64>(&arg2, v1), arg3);
            v1 = v1 + 1;
        };
    }

    public fun bridged_amount(arg0: &SimpleBridgeNFT) : u64 {
        arg0.bridged_token
    }

    public fun burn_nft(arg0: SimpleBridgeNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let SimpleBridgeNFT {
            id            : v0,
            bridged_token : _,
            user_address  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_collection_name(arg0: &SimpleBridgeNFT) : 0x1::string::String {
        0x1::string::utf8(b"Bruno Legacy Bonus")
    }

    public fun get_creator(arg0: &SimpleBridgeNFT) : 0x1::string::String {
        0x1::string::utf8(b"Bruno")
    }

    public fun get_display_metadata(arg0: &SimpleBridgeNFT) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        let v0 = 0x1::string::utf8(b"Soulbound proof of ");
        0x1::string::append(&mut v0, u64_to_string(arg0.bridged_token));
        0x1::string::append(&mut v0, 0x1::string::utf8(b" tokens bridged to SUI"));
        (0x1::string::utf8(b"Bridge Receipt NFT"), v0, 0x1::string::utf8(b"https://agg.test.walrus.eosusa.io/v1/blobs/LhoFqoZxkG-qsv36NA8FF5s3hpHjmcD3R0SesV6K-Hs"), u64_to_string(arg0.bridged_token), 0x1::string::utf8(b"Bruno Legacy Bonus"), 0x1::string::utf8(b"Bruno"))
    }

    public fun get_nft_name(arg0: &SimpleBridgeNFT) : 0x1::string::String {
        0x1::string::utf8(b"Bridge Receipt NFT")
    }

    fun init(arg0: SIMPLE_BRIDGE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<SIMPLE_BRIDGE_NFT>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"bridged_amount"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"collection_name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Bridge Receipt NFT"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Soulbound proof of {bridged_token} tokens bridged to SUI"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://agg.test.walrus.eosusa.io/v1/blobs/LhoFqoZxkG-qsv36NA8FF5s3hpHjmcD3R0SesV6K-Hs"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{bridged_token}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Bruno Legacy Bonus"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Bruno"));
        let v6 = 0x2::display::new_with_fields<SimpleBridgeNFT>(&v1, v2, v4, arg1);
        0x2::display::update_version<SimpleBridgeNFT>(&mut v6);
        let v7 = BridgeMintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<BridgeMintCap>(v7, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<SimpleBridgeNFT>>(v6, v0);
    }

    public fun mint_bridge_receipt(arg0: &BridgeMintCap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 2);
        let v0 = SimpleBridgeNFT{
            id            : 0x2::object::new(arg3),
            bridged_token : arg2,
            user_address  : arg1,
        };
        let v1 = BridgeReceiptMinted{
            nft_id         : 0x2::object::id<SimpleBridgeNFT>(&v0),
            recipient      : arg1,
            bridged_amount : arg2,
        };
        0x2::event::emit<BridgeReceiptMinted>(v1);
        0x2::transfer::transfer<SimpleBridgeNFT>(v0, arg1);
    }

    public fun remove_metadata(arg0: &mut 0x2::display::Display<SimpleBridgeNFT>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::display::remove<SimpleBridgeNFT>(arg0, 0x1::string::utf8(arg1));
        0x2::display::update_version<SimpleBridgeNFT>(arg0);
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun update_bridged_amount(arg0: &BridgeMintCap, arg1: &mut SimpleBridgeNFT, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 2);
        arg1.bridged_token = arg1.bridged_token + arg2;
        let v0 = BridgeReceiptMinted{
            nft_id         : 0x2::object::id<SimpleBridgeNFT>(arg1),
            recipient      : arg1.user_address,
            bridged_amount : arg1.bridged_token,
        };
        0x2::event::emit<BridgeReceiptMinted>(v0);
    }

    public fun update_metadata(arg0: &mut 0x2::display::Display<SimpleBridgeNFT>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::display::edit<SimpleBridgeNFT>(arg0, 0x1::string::utf8(arg1), 0x1::string::utf8(arg2));
        0x2::display::update_version<SimpleBridgeNFT>(arg0);
    }

    public fun user_address(arg0: &SimpleBridgeNFT) : address {
        arg0.user_address
    }

    // decompiled from Move bytecode v6
}

