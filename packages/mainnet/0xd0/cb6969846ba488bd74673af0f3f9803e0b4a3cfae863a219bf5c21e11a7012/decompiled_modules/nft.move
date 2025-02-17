module 0xd0cb6969846ba488bd74673af0f3f9803e0b4a3cfae863a219bf5c21e11a7012::nft {
    struct TokenData has key {
        id: 0x2::object::UID,
        current_supply: u64,
        total_supply: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PubKey has store, key {
        id: 0x2::object::UID,
        walletAddress: address,
        pubkey_bytes: vector<u8>,
        pubkey_set: bool,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    struct TalentumNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        url: 0x1::string::String,
        price: u64,
    }

    struct SetKey has copy, drop {
        name: vector<u8>,
    }

    public fun transfer(arg0: TalentumNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!true, 1);
        0x2::transfer::public_transfer<TalentumNFT>(arg0, arg1);
    }

    public fun burn(arg0: TalentumNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let TalentumNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &TalentumNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenData{
            id             : 0x2::object::new(arg1),
            current_supply : 0,
            total_supply   : 0,
        };
        0x2::transfer::share_object<TokenData>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://talentum.id"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Talentum.id"));
        let v6 = 0x2::package::claim<NFT>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<TalentumNFT>(&v6, v2, v4, arg1);
        0x2::display::update_version<TalentumNFT>(&mut v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TalentumNFT>>(v7, 0x2::tx_context::sender(arg1));
        let v8 = PubKey{
            id            : 0x2::object::new(arg1),
            walletAddress : 0x2::tx_context::sender(arg1),
            pubkey_bytes  : x"02df497ab7f7548c41e20eb81ea4bbcb0c0e2aad2635ba01b2cd8102bd408919bf",
            pubkey_set    : true,
        };
        0x2::transfer::share_object<PubKey>(v8);
    }

    public fun mint(arg0: &PubKey, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut TokenData, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.pubkey_set, 2);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg5) / 1000, 500);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg9);
        0x1::vector::append<u8>(&mut arg6, arg7);
        0x1::vector::append<u8>(&mut arg6, arg8);
        0x1::vector::append<u8>(&mut arg6, 0x1::string::into_bytes(0x1::u64::to_string(arg4)));
        0x1::vector::append<u8>(&mut arg6, 0x1::string::into_bytes(0x1::u64::to_string(v0)));
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg2, &arg0.pubkey_bytes, &arg6, arg3), 3);
        let v1 = 0x2::tx_context::sender(arg11);
        if (arg10.total_supply > 0) {
            assert!(arg10.total_supply > arg10.current_supply, 501);
        };
        arg10.current_supply = arg10.current_supply + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg9, @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5);
        let v2 = TalentumNFT{
            id          : 0x2::object::new(arg11),
            name        : 0x1::string::utf8(arg6),
            description : 0x1::string::utf8(arg7),
            url         : 0x1::string::utf8(arg8),
        };
        let v3 = NFTMinted{
            object_id : 0x2::object::id<TalentumNFT>(&v2),
            creator   : v1,
            name      : v2.name,
            url       : v2.url,
            price     : v0,
        };
        0x2::event::emit<NFTMinted>(v3);
        0x2::transfer::public_transfer<TalentumNFT>(v2, v1);
    }

    public fun name(arg0: &TalentumNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun setKey(arg0: &AdminCap, arg1: &mut PubKey, arg2: vector<u8>) {
        arg1.pubkey_bytes = arg2;
        arg1.pubkey_set = true;
        let v0 = SetKey{name: arg2};
        0x2::event::emit<SetKey>(v0);
    }

    public fun update_description(arg0: &mut TalentumNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public fun url(arg0: &TalentumNFT) : &0x1::string::String {
        &arg0.url
    }

    // decompiled from Move bytecode v6
}

