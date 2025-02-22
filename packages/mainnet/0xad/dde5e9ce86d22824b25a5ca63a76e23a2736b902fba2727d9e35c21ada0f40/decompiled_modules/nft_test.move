module 0xaddde5e9ce86d22824b25a5ca63a76e23a2736b902fba2727d9e35c21ada0f40::nft_test {
    struct TestnetNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: TestnetNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<TestnetNFT>(arg0, arg1);
    }

    public fun url(arg0: &TestnetNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: TestnetNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let TestnetNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &TestnetNFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint_to_sender(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v1, b"https://i.etsystatic.com/26144034/r/il/4b2747/2893024997/il_570xN.2893024997_hxfx.jpg");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"https://cdn.pixabay.com/photo/2024/02/28/07/42/european-shorthair-8601492_640.jpg");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"https://t3.ftcdn.net/jpg/02/36/99/22/360_F_236992283_sNOxCVQeFLd5pdqaKGh8DRGMZy7P4XKm.jpg");
        let v2 = 0x2::tx_context::sender(arg1);
        let v3 = TestnetNFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"random cat"),
            description : 0x1::string::utf8(b"Meow meow meow"),
            url         : 0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&v1, 0x2::random::generate_u64_in_range(&mut v0, 0, 2))),
        };
        let v4 = NFTMinted{
            object_id : 0x2::object::id<TestnetNFT>(&v3),
            creator   : v2,
            name      : v3.name,
        };
        0x2::event::emit<NFTMinted>(v4);
        0x2::transfer::public_transfer<TestnetNFT>(v3, v2);
    }

    public fun name(arg0: &TestnetNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

