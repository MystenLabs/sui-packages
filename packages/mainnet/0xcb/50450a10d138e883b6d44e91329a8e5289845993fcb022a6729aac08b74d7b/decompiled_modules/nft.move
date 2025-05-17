module 0xcb50450a10d138e883b6d44e91329a8e5289845993fcb022a6729aac08b74d7b::nft {
    struct SUIMINT has drop {
        dummy_field: bool,
    }

    struct SuiMintNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        price: u64,
    }

    struct MintEvent has copy, drop {
        name: 0x1::string::String,
        price: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiMintNFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"SuiMint NFT"),
            description : 0x1::string::utf8(b"A unique NFT minted on Sui"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://suimint.com/nft.png"),
            price       : 100000,
        };
        0x2::transfer::share_object<SuiMintNFT>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 100000;
        assert!(v0 > 0, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, v0, arg1), @0x51a06bb22d345907fce4cd86db094eaf170aef957423fbb39ef1801373b92685);
        let v1 = SuiMintNFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"SuiMint NFT"),
            description : 0x1::string::utf8(b"A unique NFT minted on Sui"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://suimint.com/nft.png"),
            price       : v0,
        };
        0x2::transfer::transfer<SuiMintNFT>(v1, 0x2::tx_context::sender(arg1));
        let v2 = MintEvent{
            name  : 0x1::string::utf8(b"SuiMint NFT"),
            price : v0,
        };
        0x2::event::emit<MintEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

