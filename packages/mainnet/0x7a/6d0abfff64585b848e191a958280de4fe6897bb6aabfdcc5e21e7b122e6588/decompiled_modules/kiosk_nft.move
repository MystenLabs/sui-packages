module 0x7a6d0abfff64585b848e191a958280de4fe6897bb6aabfdcc5e21e7b122e6588::kiosk_nft {
    struct KioskNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        token_id: u64,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
        next_id: u64,
        treasury: address,
    }

    public fun image_url(arg0: &KioskNFT) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{
            id       : 0x2::object::new(arg0),
            next_id  : 1,
            treasury : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<MintCap>(v0);
    }

    public entry fun mint(arg0: &mut MintCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 100000000, 0);
        assert!(arg0.next_id <= 666, 1);
        let v0 = KioskNFT{
            id        : 0x2::object::new(arg4),
            name      : 0x1::string::utf8(arg2),
            image_url : 0x1::string::utf8(arg3),
            token_id  : arg0.next_id,
        };
        arg0.next_id = arg0.next_id + 1;
        0x2::transfer::public_transfer<KioskNFT>(v0, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
    }

    public fun name(arg0: &KioskNFT) : 0x1::string::String {
        arg0.name
    }

    public fun token_id(arg0: &KioskNFT) : u64 {
        arg0.token_id
    }

    // decompiled from Move bytecode v7
}

