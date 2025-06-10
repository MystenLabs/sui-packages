module 0x885de627ea4b5f57326b282001d6e60bdd945628fcb9c8c364beb08b50db9051::kiosk_nft {
    struct KIOSK_NFT has drop {
        dummy_field: bool,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        mint_number: u64,
        rarity: 0x1::string::String,
        attributes: 0x885de627ea4b5f57326b282001d6e60bdd945628fcb9c8c364beb08b50db9051::nft_attributes::NftAttributes,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        version: u64,
        mint_supply: u64,
        minted: u64,
        creator: address,
    }

    public fun create_collection(arg0: &0x2::package::Publisher, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Collection {
        Collection{
            id          : 0x2::object::new(arg2),
            version     : 1,
            mint_supply : arg1,
            minted      : 0,
            creator     : 0x2::tx_context::sender(arg2),
        }
    }

    public fun get_minted_count(arg0: &Collection) : u64 {
        arg0.minted
    }

    fun init(arg0: KIOSK_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<KIOSK_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{mint_number}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<Nft>(&mut v1);
        0x2::transfer::public_share_object<0x2::display::Display<Nft>>(v1);
        let (v2, v3) = 0x2::transfer_policy::new<Nft>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) : Nft {
        assert!(arg0.version == 1, 0);
        assert!(arg0.minted < arg0.mint_supply, 2);
        assert!(arg0.creator == 0x2::tx_context::sender(arg7), 3);
        arg0.minted = arg0.minted + 1;
        Nft{
            id          : 0x2::object::new(arg7),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            creator     : arg0.creator,
            mint_number : arg0.minted,
            rarity      : arg4,
            attributes  : 0x885de627ea4b5f57326b282001d6e60bdd945628fcb9c8c364beb08b50db9051::nft_attributes::create(arg5, arg6, arg7),
        }
    }

    public fun update_mint_supply(arg0: &mut Collection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 3);
        assert!(arg0.minted <= arg1, 2);
        arg0.mint_supply = arg1;
    }

    // decompiled from Move bytecode v6
}

