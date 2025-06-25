module 0x6f32cb2af65ab156c26eb9f0980463a4d6ce28a0be7e5b64125b8e2cf8a4a4af::ai_nft_module {
    struct YourNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        rarity: 0x1::string::String,
    }

    fun get_rarity_price(arg0: &0x1::string::String) : u64 {
        let v0 = b"Common";
        if (0x1::string::as_bytes(arg0) == &v0) {
            250000000
        } else {
            let v2 = b"Uncommon";
            if (0x1::string::as_bytes(arg0) == &v2) {
                500000000
            } else {
                let v3 = b"Rare";
                if (0x1::string::as_bytes(arg0) == &v3) {
                    1000000000
                } else {
                    let v4 = b"Epic";
                    if (0x1::string::as_bytes(arg0) == &v4) {
                        1500000000
                    } else {
                        let v5 = b"Legendary";
                        if (0x1::string::as_bytes(arg0) == &v5) {
                            5000000000
                        } else {
                            let v6 = b"Mythical";
                            assert!(0x1::string::as_bytes(arg0) == &v6, 1);
                            10000000000
                        }
                    }
                }
            }
        }
    }

    public entry fun mint_with_payment(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= get_rarity_price(&v0), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, @0x406d8cbd9ae92891362051b898e83f0093786c3728926193a96b876499cb623a);
        let v1 = YourNFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            rarity      : v0,
        };
        0x2::transfer::public_transfer<YourNFT>(v1, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

