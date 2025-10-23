module 0xd130a47e89e60bcb6f21a59f9a292c50f26412b12e0385b8601c3ddd9413b097::test_helpers {
    struct TestNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        number: u64,
    }

    struct TEST_HELPERS has drop {
        dummy_field: bool,
    }

    public entry fun create_kiosk_with_multiple_nfts(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0;
        while (v4 < arg0) {
            let v5 = mint_test_nft(b"Wackbid Test NFT", b"Test NFT for auctions", b"https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/So11111111111111111111111111111111111111112/logo.png", v4 + 1, arg1);
            0x2::kiosk::place<TestNFT>(&mut v3, &v2, v5);
            v4 = v4 + 1;
        };
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun create_kiosk_with_test_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg4);
        let v2 = v1;
        let v3 = v0;
        let v4 = mint_test_nft(arg0, arg1, arg2, arg3, arg4);
        0x2::kiosk::place<TestNFT>(&mut v3, &v2, v4);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg4));
    }

    public entry fun create_test_kiosk_quick(arg0: &mut 0x2::tx_context::TxContext) {
        create_kiosk_with_test_nft(b"Wackbid Test NFT", b"A test NFT for auction testing on Wackbid platform", b"https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/So11111111111111111111111111111111111111112/logo.png", 1, arg0);
    }

    public fun get_description(arg0: &TestNFT) : 0x1::string::String {
        arg0.description
    }

    public fun get_image_url(arg0: &TestNFT) : 0x1::string::String {
        arg0.image_url
    }

    public fun get_name(arg0: &TestNFT) : 0x1::string::String {
        arg0.name
    }

    public fun get_number(arg0: &TestNFT) : u64 {
        arg0.number
    }

    fun init(arg0: TEST_HELPERS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"number"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"#{number}"));
        let v4 = 0x2::package::claim<TEST_HELPERS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TestNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<TestNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TestNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_and_transfer(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_test_nft(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<TestNFT>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun mint_test_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : TestNFT {
        TestNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x1::string::utf8(arg2),
            number      : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

