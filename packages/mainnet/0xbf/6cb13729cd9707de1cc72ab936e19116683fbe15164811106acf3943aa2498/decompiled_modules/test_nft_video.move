module 0xbf6cb13729cd9707de1cc72ab936e19116683fbe15164811106acf3943aa2498::test_nft_video {
    struct TEST_NFT_VIDEO has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct TestVideoNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct CollectionInfo has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        display: 0x2::display::Display<TestVideoNFT>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<TestVideoNFT>,
    }

    struct MintCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct MintEvent has copy, drop {
        nft: 0x2::object::ID,
    }

    fun init(arg0: TEST_NFT_VIDEO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<TEST_NFT_VIDEO>(arg0, arg1);
        let v2 = 0x2::display::new<TestVideoNFT>(&v1, arg1);
        0x2::display::add<TestVideoNFT>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<TestVideoNFT>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<TestVideoNFT>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::update_version<TestVideoNFT>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<TestVideoNFT>(&v1, arg1);
        let v5 = v4;
        let v6 = v3;
        0xbf6cb13729cd9707de1cc72ab936e19116683fbe15164811106acf3943aa2498::royalty_rule::add<TestVideoNFT>(&mut v6, &v5, 500, 100);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<TestVideoNFT>>(v6);
        let v7 = MintCap<TestVideoNFT>{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintCap<TestVideoNFT>>(v7, v0);
        let v8 = CollectionInfo{
            id         : 0x2::object::new(arg1),
            publisher  : v1,
            display    : v2,
            policy_cap : v5,
        };
        0x2::transfer::public_transfer<CollectionInfo>(v8, v0);
    }

    public entry fun mint_nft(arg0: &MintCap<TestVideoNFT>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = TestVideoNFT{
            id          : 0x2::object::new(arg4),
            name        : arg1,
            description : arg2,
            url         : arg3,
        };
        let v1 = MintEvent{nft: 0x2::object::id<TestVideoNFT>(&v0)};
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::public_transfer<TestVideoNFT>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

