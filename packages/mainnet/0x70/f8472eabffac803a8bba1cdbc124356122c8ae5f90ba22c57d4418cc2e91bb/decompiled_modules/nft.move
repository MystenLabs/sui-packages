module 0x70f8472eabffac803a8bba1cdbc124356122c8ae5f90ba22c57d4418cc2e91bb::nft {
    struct TrenchBuddyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        image: 0x2::url::Url,
        animation_url: 0x1::option::Option<0x2::url::Url>,
        external_url: 0x2::url::Url,
        collection_id: 0x2::object::ID,
        symbol: 0x1::string::String,
        attribute_keys: vector<0x1::string::String>,
        attribute_values: vector<0x1::string::String>,
        properties: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
    }

    public entry fun burn_nft(arg0: TrenchBuddyNFT) {
        let TrenchBuddyNFT {
            id               : v0,
            name             : _,
            description      : _,
            url              : _,
            image            : _,
            animation_url    : _,
            external_url     : _,
            collection_id    : _,
            symbol           : _,
            attribute_keys   : _,
            attribute_values : _,
            properties       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_animation_url(arg0: &TrenchBuddyNFT) : &0x1::option::Option<0x2::url::Url> {
        &arg0.animation_url
    }

    public fun get_collection_id(arg0: &TrenchBuddyNFT) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun get_description(arg0: &TrenchBuddyNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun get_name(arg0: &TrenchBuddyNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun get_symbol(arg0: &TrenchBuddyNFT) : &0x1::string::String {
        &arg0.symbol
    }

    public fun get_url(arg0: &TrenchBuddyNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun mint_nft(arg0: &0x70f8472eabffac803a8bba1cdbc124356122c8ae5f90ba22c57d4418cc2e91bb::collection::AdminCap, arg1: &mut 0x70f8472eabffac803a8bba1cdbc124356122c8ae5f90ba22c57d4418cc2e91bb::collection::TrenchBuddyNftCollectionMeta, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: 0x1::option::Option<0x1::string::String>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x70f8472eabffac803a8bba1cdbc124356122c8ae5f90ba22c57d4418cc2e91bb::collection::get_remaining(arg1);
        assert!(v0 == 0 || v0 > 0, 1);
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"metadata_uri"), arg6);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"minted_by"), 0x1::string::utf8(b"TrenchBuddy"));
        let v2 = if (0x1::option::is_some<0x1::string::String>(&arg10)) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(0x1::option::borrow<0x1::string::String>(&arg10)))))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let v3 = TrenchBuddyNFT{
            id               : 0x2::object::new(arg11),
            name             : arg3,
            description      : arg4,
            url              : 0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(&arg5))),
            image            : 0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(&arg5))),
            animation_url    : v2,
            external_url     : 0x2::url::new_unsafe(0x1::ascii::string(b"https://trenchbuddy.io/trenchgpt")),
            collection_id    : 0x2::object::id<0x70f8472eabffac803a8bba1cdbc124356122c8ae5f90ba22c57d4418cc2e91bb::collection::TrenchBuddyNftCollectionMeta>(arg1),
            symbol           : arg7,
            attribute_keys   : arg8,
            attribute_values : arg9,
            properties       : v1,
        };
        let v4 = 0x2::object::id<TrenchBuddyNFT>(&v3);
        0x70f8472eabffac803a8bba1cdbc124356122c8ae5f90ba22c57d4418cc2e91bb::collection::increment_minted(arg1, v4);
        let v5 = NFTMinted{
            nft_id        : v4,
            collection_id : 0x2::object::id<0x70f8472eabffac803a8bba1cdbc124356122c8ae5f90ba22c57d4418cc2e91bb::collection::TrenchBuddyNftCollectionMeta>(arg1),
            owner         : arg2,
            name          : v3.name,
        };
        0x2::event::emit<NFTMinted>(v5);
        0x2::transfer::public_transfer<TrenchBuddyNFT>(v3, arg2);
    }

    public entry fun mint_standalone_nft(arg0: &0x70f8472eabffac803a8bba1cdbc124356122c8ae5f90ba22c57d4418cc2e91bb::collection::AdminCap, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>, arg9: 0x1::option::Option<0x1::string::String>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"metadata_uri"), arg5);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"minted_by"), 0x1::string::utf8(b"TrenchBuddy"));
        let v1 = if (0x1::option::is_some<0x1::string::String>(&arg9)) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(0x1::option::borrow<0x1::string::String>(&arg9)))))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let v2 = TrenchBuddyNFT{
            id               : 0x2::object::new(arg10),
            name             : arg2,
            description      : arg3,
            url              : 0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(&arg4))),
            image            : 0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(&arg4))),
            animation_url    : v1,
            external_url     : 0x2::url::new_unsafe(0x1::ascii::string(b"https://trenchbuddy.io/trenchgpt")),
            collection_id    : 0x2::object::id_from_address(@0x0),
            symbol           : arg6,
            attribute_keys   : arg7,
            attribute_values : arg8,
            properties       : v0,
        };
        let v3 = NFTMinted{
            nft_id        : 0x2::object::id<TrenchBuddyNFT>(&v2),
            collection_id : 0x2::object::id_from_address(@0x0),
            owner         : arg1,
            name          : v2.name,
        };
        0x2::event::emit<NFTMinted>(v3);
        0x2::transfer::public_transfer<TrenchBuddyNFT>(v2, arg1);
    }

    public entry fun transfer_nft(arg0: TrenchBuddyNFT, arg1: address) {
        0x2::transfer::public_transfer<TrenchBuddyNFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

