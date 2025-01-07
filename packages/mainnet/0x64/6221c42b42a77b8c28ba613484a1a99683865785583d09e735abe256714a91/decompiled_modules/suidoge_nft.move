module 0x646221c42b42a77b8c28ba613484a1a99683865785583d09e735abe256714a91::suidoge_nft {
    struct SUIDOGE_NFT has drop {
        dummy_field: bool,
    }

    struct SuiDogeNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct Counter has key {
        id: 0x2::object::UID,
        count: u64,
        userMaxCount: u64,
        maxCount: u64,
    }

    struct UserCounter has key {
        id: 0x2::object::UID,
    }

    public fun description(arg0: &SuiDogeNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun img_url(arg0: &SuiDogeNFT) : &0x2::url::Url {
        &arg0.img_url
    }

    fun init(arg0: SUIDOGE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        let v4 = Counter{
            id           : 0x2::object::new(arg1),
            count        : 0,
            userMaxCount : 2,
            maxCount     : 9999,
        };
        let v5 = 0x2::package::claim<SUIDOGE_NFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<SuiDogeNFT>(&v5, v0, v2, arg1);
        0x2::display::update_version<SuiDogeNFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuiDogeNFT>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Counter>(v4);
        let v7 = UserCounter{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<UserCounter>(v7);
    }

    public entry fun mint10(arg0: &mut UserCounter, arg1: &mut Counter, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.count <= arg1.maxCount, 0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = if (0x2::dynamic_field::exists_with_type<address, u64>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_field::remove<address, u64>(&mut arg0.id, v0);
            assert!(v2 <= arg1.userMaxCount, 1);
            v2
        } else {
            0
        };
        0x2::dynamic_field::add<address, u64>(&mut arg0.id, v0, v1 + 1);
        let v3 = SuiDogeNFT{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"SuiDoge"),
            description : 0x1::string::utf8(b"NFT is our Non-Fungible Token, equivalent to an pass card, and having an NFT owns half of SuiDoge's tokens. In the later stage, attributes such as pledge and voting governance will be developed. In short, his value is infinite, we take in the very beginning to realize him, which shows that he is very important"),
            img_url     : 0x2::url::new_unsafe_from_bytes(b"https://suidoge.dog/sui/suidogenft.png"),
        };
        let v4 = 0x2::tx_context::sender(arg2);
        let v5 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v3.id),
            creator   : v4,
            name      : v3.name,
        };
        0x2::event::emit<MintNFTEvent>(v5);
        0x2::transfer::public_transfer<SuiDogeNFT>(v3, v4);
        arg1.count = arg1.count + 1;
    }

    public fun name(arg0: &SuiDogeNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

