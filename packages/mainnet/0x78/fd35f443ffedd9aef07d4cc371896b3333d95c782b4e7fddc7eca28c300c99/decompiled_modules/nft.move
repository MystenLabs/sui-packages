module 0x78fd35f443ffedd9aef07d4cc371896b3333d95c782b4e7fddc7eca28c300c99::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct RoyaltyRule has drop, store {
        amount_bp: u16,
    }

    struct KioskLockRule has drop, store {
        dummy_field: bool,
    }

    struct BlueMonster has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: vector<0x1::string::String>,
        collection: 0x1::string::String,
        creator: 0x1::string::String,
        creator_url: 0x1::string::String,
        website_url: 0x1::string::String,
    }

    struct CollectionInfo has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: 0x1::string::String,
        creator_url: 0x1::string::String,
        website_url: 0x1::string::String,
        discord_url: 0x1::string::String,
        twitter_url: 0x1::string::String,
        banner_url: 0x1::string::String,
        logo_url: 0x1::string::String,
        total_supply: u64,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
        remaining_supply: u64,
        mint_price: u64,
        collection_owner: address,
    }

    struct TransferPolicyCap has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    fun get_image_hash(arg0: u64) : vector<u8> {
        if (arg0 == 1) {
            b"bafkreiezlhpezzmm3o6biop3gjpqgmiqxazrimkcdgqa7ylf4tjdxvnac4"
        } else if (arg0 == 2) {
            b"bafkreif3gsdmqe66vrrvyocuipv47bozmqdk3naa3qppe3ffzf3l24pdwa"
        } else {
            b"bafkreiezlhpezzmm3o6biop3gjpqgmiqxazrimkcdgqa7ylf4tjdxvnac4"
        }
    }

    fun get_image_url(arg0: u64) : vector<u8> {
        let v0 = b"https://gateway.lighthouse.storage/ipfs/";
        0x1::vector::append<u8>(&mut v0, get_image_hash(arg0));
        v0
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = CollectionInfo{
            id           : 0x2::object::new(arg1),
            name         : 0x1::string::utf8(b"Blue Monsters"),
            description  : 0x1::string::utf8(x"486f6c64206f6e746f20796f757220686174732c20626563617573652074686520424c5545204d4f4e53544552532061726520636f6d696e672120f09f91b9205468697320446563656d6265722c2077696c6c20696e76616465205355492c20616e642074686579277265206272696e67696e6720612077686f6c65206c6f74206f66206368616f732028696e2074686520626573742077617920706f737369626c652921"),
            creator      : 0x1::string::utf8(b"Teraki"),
            creator_url  : 0x1::string::utf8(b"https://x.com/terakiart"),
            website_url  : 0x1::string::utf8(b"https://wwww.teraki.art"),
            discord_url  : 0x1::string::utf8(b""),
            twitter_url  : 0x1::string::utf8(b"https://x.com/terakiart"),
            banner_url   : 0x1::string::utf8(b"https://forsite.ro/bb.png"),
            logo_url     : 0x1::string::utf8(b"https://forsite.ro/bb2.png"),
            total_supply : 929,
        };
        let v2 = MintCap{
            id               : 0x2::object::new(arg1),
            remaining_supply : 929,
            mint_price       : 1000000000,
            collection_owner : 0x2::tx_context::sender(arg1),
        };
        let (v3, v4) = 0x2::transfer_policy::new<BlueMonster>(&v0, arg1);
        let v5 = v4;
        let v6 = v3;
        let v7 = RoyaltyRule{amount_bp: (500 as u16)};
        let v8 = RoyaltyRule{amount_bp: (500 as u16)};
        0x2::transfer_policy::add_rule<BlueMonster, RoyaltyRule, RoyaltyRule>(v7, &mut v6, &v5, v8);
        let v9 = KioskLockRule{dummy_field: false};
        let v10 = KioskLockRule{dummy_field: false};
        0x2::transfer_policy::add_rule<BlueMonster, KioskLockRule, KioskLockRule>(v9, &mut v6, &v5, v10);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<BlueMonster>>(v6);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<BlueMonster>>(v5, 0x2::tx_context::sender(arg1));
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"creator_url"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"external_url"));
        let v13 = 0x1::vector::empty<0x1::string::String>();
        let v14 = &mut v13;
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{attributes}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"Blue Monsters"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{website_url}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{creator_url}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{website_url}"));
        let v15 = 0x2::display::new_with_fields<BlueMonster>(&v0, v11, v13, arg1);
        0x2::display::update_version<BlueMonster>(&mut v15);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BlueMonster>>(v15, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MintCap>(v2);
        0x2::transfer::share_object<CollectionInfo>(v1);
    }

    public entry fun mint(arg0: &mut MintCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.remaining_supply > 0, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.mint_price, 1);
        let v0 = 929 - arg0.remaining_supply + 1;
        let v1 = 0x1::vector::empty<u8>();
        while (v0 > 0) {
            0x1::vector::push_back<u8>(&mut v1, ((v0 % 10) as u8) + 48);
            v0 = v0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v1);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, b"Blue Monster #");
        0x1::vector::append<u8>(&mut v2, v1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"token_id"));
        0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(v1));
        0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"common"));
        0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"series"));
        0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"genesis"));
        let v4 = BlueMonster{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(v2),
            description : 0x1::string::utf8(x"486f6c64206f6e746f20796f757220686174732c20626563617573652074686520424c5545204d4f4e53544552532061726520636f6d696e672120f09f91b9205468697320446563656d6265722c2077696c6c20696e76616465205355492c20616e642074686579277265206272696e67696e6720612077686f6c65206c6f74206f66206368616f732028696e2074686520626573742077617920706f737369626c652921"),
            image_url   : 0x2::url::new_unsafe_from_bytes(get_image_url(v0)),
            attributes  : v3,
            collection  : 0x1::string::utf8(b"Blue Monsters"),
            creator     : 0x1::string::utf8(b"Teraki"),
            creator_url : 0x1::string::utf8(b"https://x.com/terakiart"),
            website_url : 0x1::string::utf8(b"https://wwww.teraki.art"),
        };
        let (v5, v6) = 0x2::kiosk::new(arg2);
        let v7 = v6;
        let v8 = v5;
        0x2::kiosk::place<BlueMonster>(&mut v8, &v7, v4);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v8);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v7, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.collection_owner);
        arg0.remaining_supply = arg0.remaining_supply - 1;
    }

    public fun mint_price(arg0: &MintCap) : u64 {
        arg0.mint_price
    }

    public entry fun public_mint(arg0: &mut MintCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        mint(arg0, arg1, arg2);
    }

    public fun remaining_supply(arg0: &MintCap) : u64 {
        arg0.remaining_supply
    }

    // decompiled from Move bytecode v6
}

