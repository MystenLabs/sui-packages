module 0x82d8d4cfe4149ad1595e17609f1cefe05f42da2790aaae95fbaa010eb2de605d::welcome_nft {
    struct WELCOME_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintRecord has store {
        minters: 0x2::table::Table<address, bool>,
        total_passes: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        mint_record: MintRecord,
        sequence_number: u128,
    }

    struct WelcomeNFT has key {
        id: 0x2::object::UID,
        owner: address,
        minted_by: address,
        created_at_ms: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct WelcomeNFTMintedEvent has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        minted_by: address,
        created_at_ms: u64,
    }

    public fun has_nft(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.mint_record.minters, arg1)
    }

    fun init(arg0: WELCOME_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MintRecord{
            minters      : 0x2::table::new<address, bool>(arg1),
            total_passes : 0,
        };
        let v1 = Registry{
            id              : 0x2::object::new(arg1),
            version         : 1,
            mint_record     : v0,
            sequence_number : 1,
        };
        0x2::transfer::share_object<Registry>(v1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        let v6 = 0x2::package::claim<WELCOME_NFT>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<WelcomeNFT>(&v6, v2, v4, arg1);
        0x2::display::update_version<WelcomeNFT>(&mut v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WelcomeNFT>>(v7, 0x2::tx_context::sender(arg1));
        let v8 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v8, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft(arg0: &mut Registry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.version == 1, 7);
        assert!(!0x2::table::contains<address, bool>(&arg0.mint_record.minters, v0), 0);
        0x2::table::add<address, bool>(&mut arg0.mint_record.minters, v0, true);
        arg0.mint_record.total_passes = arg0.mint_record.total_passes + 1;
        let v1 = 0x1::string::utf8(b"Welcome NFT #");
        0x1::string::append(&mut v1, 0x1::u128::to_string(arg0.sequence_number));
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = WelcomeNFT{
            id            : 0x2::object::new(arg2),
            owner         : v0,
            minted_by     : v0,
            created_at_ms : v2,
            name          : v1,
            image_url     : 0x1::string::utf8(b"https://citizen-pass.s3.ap-northeast-1.amazonaws.com/citizen.jpg"),
        };
        arg0.sequence_number = arg0.sequence_number + 1;
        0x2::transfer::transfer<WelcomeNFT>(v3, v0);
        let v4 = WelcomeNFTMintedEvent{
            nft_id        : 0x2::object::id<WelcomeNFT>(&v3),
            owner         : v0,
            minted_by     : v0,
            created_at_ms : v2,
        };
        0x2::event::emit<WelcomeNFTMintedEvent>(v4);
    }

    public fun total_nfts(arg0: &Registry) : u64 {
        arg0.mint_record.total_passes
    }

    // decompiled from Move bytecode v6
}

