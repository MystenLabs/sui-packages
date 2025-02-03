module 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::warehouse {
    struct Warehouse<phantom T0> has store {
        collection_info: 0x1::option::Option<CollectionContent>,
        nft_content: 0x2::table::Table<u64, NFTContent>,
    }

    struct CollectionContent has drop, store {
        name: 0x1::string::String,
        url: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::option::Option<0x1::string::String>,
        creators: vector<address>,
        is_used: bool,
    }

    struct NFTContent has drop, store {
        name: 0x1::string::String,
        url: 0x1::string::String,
        symbol: 0x1::option::Option<0x1::string::String>,
        attribute_keys: vector<0x1::string::String>,
        attribute_values: vector<0x1::string::String>,
        is_used: bool,
    }

    public(friend) fun add_token_info<T0>(arg0: &mut Warehouse<T0>, arg1: vector<u64>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<vector<0x1::string::String>>, arg6: vector<vector<0x1::string::String>>) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        let v1 = 0;
        let v2 = 0x1::vector::length<0x1::string::String>(&arg4) == v0;
        let v3 = 0x1::vector::length<vector<0x1::string::String>>(&arg5) == v0;
        while (v1 < v0) {
            let v4 = if (v2) {
                0x1::option::some<0x1::string::String>(0x1::vector::pop_back<0x1::string::String>(&mut arg4))
            } else {
                0x1::option::none<0x1::string::String>()
            };
            let v5 = if (v3) {
                0x1::vector::pop_back<vector<0x1::string::String>>(&mut arg5)
            } else {
                0x1::vector::empty<0x1::string::String>()
            };
            let v6 = if (v3) {
                0x1::vector::pop_back<vector<0x1::string::String>>(&mut arg6)
            } else {
                0x1::vector::empty<0x1::string::String>()
            };
            let v7 = NFTContent{
                name             : 0x1::vector::pop_back<0x1::string::String>(&mut arg2),
                url              : 0x1::vector::pop_back<0x1::string::String>(&mut arg3),
                symbol           : v4,
                attribute_keys   : v5,
                attribute_values : v6,
                is_used          : false,
            };
            0x2::table::add<u64, NFTContent>(&mut arg0.nft_content, 0x1::vector::pop_back<u64>(&mut arg1), v7);
            v1 = v1 + 1;
        };
    }

    public fun borrow_nft_content_mut<T0>(arg0: &mut Warehouse<T0>, arg1: u64) : &mut NFTContent {
        0x2::table::borrow_mut<u64, NFTContent>(&mut arg0.nft_content, arg1)
    }

    public fun create_warehouse<T0>(arg0: &mut 0x2::tx_context::TxContext) : Warehouse<T0> {
        Warehouse<T0>{
            collection_info : 0x1::option::none<CollectionContent>(),
            nft_content     : 0x2::table::new<u64, NFTContent>(arg0),
        }
    }

    public fun get_nft_attributes_keys(arg0: &NFTContent) : (bool, vector<0x1::string::String>) {
        let v0 = false;
        let v1 = 0x1::vector::empty<0x1::string::String>();
        if (!0x1::vector::is_empty<0x1::string::String>(&arg0.attribute_keys)) {
            v0 = true;
            v1 = arg0.attribute_keys;
        };
        (v0, v1)
    }

    public fun get_nft_attributes_values(arg0: &NFTContent) : (bool, vector<0x1::string::String>) {
        let v0 = false;
        let v1 = 0x1::vector::empty<0x1::string::String>();
        if (!0x1::vector::is_empty<0x1::string::String>(&arg0.attribute_values)) {
            v0 = true;
            v1 = arg0.attribute_values;
        };
        (v0, v1)
    }

    public fun get_nft_name(arg0: &NFTContent) : 0x1::string::String {
        arg0.name
    }

    public fun get_nft_symbol(arg0: &NFTContent) : (bool, 0x1::string::String) {
        let v0 = false;
        let v1 = 0x1::string::utf8(b"");
        if (0x1::option::is_some<0x1::string::String>(&arg0.symbol)) {
            v0 = true;
            v1 = *0x1::option::borrow<0x1::string::String>(&arg0.symbol);
        };
        (v0, v1)
    }

    public fun get_nft_url(arg0: &NFTContent) : 0x1::string::String {
        arg0.url
    }

    public fun nft_mark_as_used(arg0: &mut NFTContent) {
        arg0.is_used = true;
    }

    // decompiled from Move bytecode v6
}

