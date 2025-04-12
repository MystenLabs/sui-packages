module 0xc4d1fc1545dfb51d864ce96dfe673abf05f226dfe9c371213f0f72dfb3f1ea2f::distributor {
    struct DISTRIBUTOR has drop {
        dummy_field: bool,
    }

    struct Distributor has store, key {
        id: 0x2::object::UID,
        supply: u64,
        counter: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        registry: 0x2::table::Table<u64, 0x2::object::ID>,
        is_complete: bool,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        minter: address,
    }

    struct DistributorCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: DISTRIBUTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"external_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{collection_name} #{number}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmSmRKDsodqgUEEZf9sDGWTi1CPTCe56GmUfjAHRGTXAh4/{number}.json"));
        let v4 = 0x2::package::claim<DISTRIBUTOR>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<0xc4d1fc1545dfb51d864ce96dfe673abf05f226dfe9c371213f0f72dfb3f1ea2f::test_nft::TestNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<0xc4d1fc1545dfb51d864ce96dfe673abf05f226dfe9c371213f0f72dfb3f1ea2f::test_nft::TestNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xc4d1fc1545dfb51d864ce96dfe673abf05f226dfe9c371213f0f72dfb3f1ea2f::test_nft::TestNft>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Distributor{
            id          : 0x2::object::new(arg1),
            supply      : 9999,
            counter     : 0,
            name        : 0x1::string::utf8(b"Test NFT"),
            description : 0x1::string::utf8(b"Test NFT description."),
            registry    : 0x2::table::new<u64, 0x2::object::ID>(arg1),
            is_complete : false,
        };
        0x2::transfer::transfer<Distributor>(v6, 0x2::tx_context::sender(arg1));
        let v7 = DistributorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<DistributorCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_single(arg0: &DistributorCap, arg1: &mut Distributor, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_complete, 1);
        assert!(arg2 > 0, 3);
        assert!(arg2 <= arg1.supply, 3);
        arg1.counter = arg1.counter + 1;
        assert!(arg1.counter <= arg1.supply, 4);
        assert!(!0x2::table::contains<u64, 0x2::object::ID>(&arg1.registry, arg2), 2);
        let v0 = 0xc4d1fc1545dfb51d864ce96dfe673abf05f226dfe9c371213f0f72dfb3f1ea2f::test_nft::new(arg2, arg1.name, arg1.description, 0x1::option::some<0x1::string::String>(arg3), 0x1::option::some<0x1::string::String>(arg4), arg6);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg1.registry, arg2, 0x2::object::id<0xc4d1fc1545dfb51d864ce96dfe673abf05f226dfe9c371213f0f72dfb3f1ea2f::test_nft::TestNft>(&v0));
        let v1 = NFTMinted{
            nft_id : 0x2::object::id<0xc4d1fc1545dfb51d864ce96dfe673abf05f226dfe9c371213f0f72dfb3f1ea2f::test_nft::TestNft>(&v0),
            minter : arg5,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<0xc4d1fc1545dfb51d864ce96dfe673abf05f226dfe9c371213f0f72dfb3f1ea2f::test_nft::TestNft>(v0, arg5);
        if (arg1.counter == arg1.supply) {
            arg1.is_complete = true;
        };
    }

    // decompiled from Move bytecode v6
}

