module 0x2f1e6b2dae3c2fcd7a5783a8c73a1dbc2640edcb4f65ff2d278d634cf78e0a2a::test_nft {
    struct TEST_NFT has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct TestNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct CollectionInfo has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        display: 0x2::display::Display<TestNFT>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<TestNFT>,
    }

    struct MintCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct MintEvent has copy, drop {
        nft: 0x2::object::ID,
    }

    public fun finalize_nft(arg0: &MintCap<TestNFT>, arg1: TestNFT, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<TestNFT>(arg1, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: TEST_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<TEST_NFT>(arg0, arg1);
        let v2 = 0x2::display::new<TestNFT>(&v1, arg1);
        0x2::display::add<TestNFT>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<TestNFT>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<TestNFT>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::update_version<TestNFT>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<TestNFT>(&v1, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2f1e6b2dae3c2fcd7a5783a8c73a1dbc2640edcb4f65ff2d278d634cf78e0a2a::royalty_rule::add<TestNFT>(&mut v6, &v5, 500, 100);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<TestNFT>>(v6);
        let v7 = MintCap<TestNFT>{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintCap<TestNFT>>(v7, v0);
        let v8 = CollectionInfo{
            id         : 0x2::object::new(arg1),
            publisher  : v1,
            display    : v2,
            policy_cap : v5,
        };
        0x2::transfer::public_transfer<CollectionInfo>(v8, v0);
    }

    public entry fun mint_nft(arg0: &MintCap<TestNFT>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = TestNFT{
            id          : 0x2::object::new(arg4),
            name        : arg1,
            description : arg2,
            url         : arg3,
        };
        let v1 = MintEvent{nft: 0x2::object::id<TestNFT>(&v0)};
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::public_transfer<TestNFT>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun put_all_nfts_into_kiosk(arg0: &MintCap<TestNFT>, arg1: vector<TestNFT>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg2);
        let v2 = v1;
        let v3 = v0;
        while (0x1::vector::length<TestNFT>(&arg1) > 0) {
            0x2::kiosk::place<TestNFT>(&mut v3, &v2, 0x1::vector::pop_back<TestNFT>(&mut arg1));
        };
        0x1::vector::destroy_empty<TestNFT>(arg1);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
    }

    // decompiled from Move bytecode v6
}

