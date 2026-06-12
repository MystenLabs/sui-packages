module 0x5021d0ad7de99ee231ba4a0fdfbaca091535acf824bf3a80aa82f11dbe859e09::syndicate_nft {
    struct SYNDICATE_NFT has drop {
        dummy_field: bool,
    }

    struct SyndicateNFT has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct MintRegistry has key {
        id: 0x2::object::UID,
        total_minted: u64,
        minted_wallets: 0x2::table::Table<address, bool>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        token_id: u64,
        recipient: address,
    }

    public fun admin_mint(arg0: &AdminCap, arg1: &mut MintRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.total_minted < 100, 1);
        let v0 = arg1.total_minted + 1;
        let v1 = make_nft(v0, arg3);
        arg1.total_minted = arg1.total_minted + 1;
        let v2 = MintEvent{
            nft_id    : 0x2::object::id<SyndicateNFT>(&v1),
            token_id  : v0,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v2);
        0x2::transfer::public_transfer<SyndicateNFT>(v1, arg2);
    }

    public fun has_minted(arg0: &MintRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.minted_wallets, arg1)
    }

    fun init(arg0: SYNDICATE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<SYNDICATE_NFT>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://thesyndicatenft.io"));
        let v6 = 0x2::display::new_with_fields<SyndicateNFT>(&v1, v2, v4, arg1);
        0x2::display::update_version<SyndicateNFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<SyndicateNFT>>(v6, v0);
        let (v7, v8) = 0x2::transfer_policy::new<SyndicateNFT>(&v1, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SyndicateNFT>>(v7);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SyndicateNFT>>(v8, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        let v9 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v9, v0);
        let v10 = MintRegistry{
            id             : 0x2::object::new(arg1),
            total_minted   : 0,
            minted_wallets : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<MintRegistry>(v10);
    }

    fun make_nft(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : SyndicateNFT {
        let v0 = b"ipfs://bafybeigdspmgdiyriigkn2dlgftaeeua5wg2tqcyqagoddp57ho24o74ka/";
        0x1::vector::append<u8>(&mut v0, u64_to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, b".png");
        let v1 = 0x1::string::utf8(b"The Syndicate #");
        0x1::string::append(&mut v1, 0x1::string::utf8(u64_to_bytes(arg0)));
        SyndicateNFT{
            id          : 0x2::object::new(arg1),
            token_id    : arg0,
            name        : v1,
            description : 0x1::string::utf8(b"The Syndicate - 100 unique frog NFTs on the SUI blockchain. An exclusive alpha and trading group."),
            image_url   : 0x2::url::new_unsafe_from_bytes(v0),
        }
    }

    public fun mint(arg0: &mut MintRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.total_minted < 100, 1);
        assert!(!0x2::table::contains<address, bool>(&arg0.minted_wallets, v0), 0);
        let v1 = arg0.total_minted + 1;
        let v2 = make_nft(v1, arg1);
        0x2::table::add<address, bool>(&mut arg0.minted_wallets, v0, true);
        arg0.total_minted = arg0.total_minted + 1;
        let v3 = MintEvent{
            nft_id    : 0x2::object::id<SyndicateNFT>(&v2),
            token_id  : v1,
            recipient : v0,
        };
        0x2::event::emit<MintEvent>(v3);
        0x2::transfer::public_transfer<SyndicateNFT>(v2, v0);
    }

    public fun supply_remaining(arg0: &MintRegistry) : u64 {
        100 - arg0.total_minted
    }

    public fun total_minted(arg0: &MintRegistry) : u64 {
        arg0.total_minted
    }

    fun u64_to_bytes(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v7
}

