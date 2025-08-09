module 0x76c7cf0c5be9c96167143e96febeb8a8196ec2583e48f3585dc7607d32a48ff7::attributes {
    struct NftData has store {
        number: u64,
        image_url: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        trait_types: vector<0x1::string::String>,
        trait_values: vector<0x1::string::String>,
    }

    struct CollectionData has key {
        id: 0x2::object::UID,
        nfts: 0x2::table_vec::TableVec<NftData>,
        total_added: u64,
        owner: address,
    }

    struct DataCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_nft(arg0: &mut CollectionData, arg1: &DataCap, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.owner, 999);
        assert!(0x1::vector::length<0x1::string::String>(&arg6) == 0x1::vector::length<0x1::string::String>(&arg7), 1);
        let v0 = NftData{
            number       : arg2,
            image_url    : arg3,
            name         : arg4,
            description  : arg5,
            trait_types  : arg6,
            trait_values : arg7,
        };
        0x2::table_vec::push_back<NftData>(&mut arg0.nfts, v0);
        arg0.total_added = arg0.total_added + 1;
    }

    public fun batch_add_nfts(arg0: &mut CollectionData, arg1: &DataCap, arg2: vector<u64>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<vector<0x1::string::String>>, arg7: vector<vector<0x1::string::String>>, arg8: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.owner, 999);
        let v0 = 0x1::vector::length<u64>(&arg2);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = NftData{
                number       : *0x1::vector::borrow<u64>(&arg2, v1),
                image_url    : *0x1::vector::borrow<0x1::string::String>(&arg3, v1),
                name         : *0x1::vector::borrow<0x1::string::String>(&arg4, v1),
                description  : *0x1::vector::borrow<0x1::string::String>(&arg5, v1),
                trait_types  : *0x1::vector::borrow<vector<0x1::string::String>>(&arg6, v1),
                trait_values : *0x1::vector::borrow<vector<0x1::string::String>>(&arg7, v1),
            };
            0x2::table_vec::push_back<NftData>(&mut arg0.nfts, v2);
            v1 = v1 + 1;
        };
        arg0.total_added = arg0.total_added + v0;
    }

    public fun clear_all_nfts(arg0: &mut CollectionData, arg1: &DataCap, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 999);
        let v0 = 0;
        while (v0 < 0x2::table_vec::length<NftData>(&arg0.nfts)) {
            let NftData {
                number       : _,
                image_url    : _,
                name         : _,
                description  : _,
                trait_types  : _,
                trait_values : _,
            } = 0x2::table_vec::pop_back<NftData>(&mut arg0.nfts);
            v0 = v0 + 1;
        };
        arg0.total_added = 0;
    }

    public fun clear_nfts_by_range(arg0: &mut CollectionData, arg1: &DataCap, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 999);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x2::table_vec::length<NftData>(&arg0.nfts)) {
            let v2 = 0x2::table_vec::borrow<NftData>(&arg0.nfts, v1);
            if (v2.number >= arg2 && v2.number <= arg3) {
                0x1::vector::push_back<u64>(&mut v0, v1);
            };
            v1 = v1 + 1;
        };
        0x1::vector::reverse<u64>(&mut v0);
        let v3 = 0x1::vector::length<u64>(&v0);
        let v4 = 0;
        while (v4 < v3) {
            let NftData {
                number       : _,
                image_url    : _,
                name         : _,
                description  : _,
                trait_types  : _,
                trait_values : _,
            } = 0x2::table_vec::swap_remove<NftData>(&mut arg0.nfts, *0x1::vector::borrow<u64>(&v0, v4));
            v4 = v4 + 1;
        };
        arg0.total_added = arg0.total_added - v3;
    }

    public(friend) fun get_nft(arg0: &mut CollectionData, arg1: u64) : (u64, 0x1::string::String, 0x1::string::String, 0x1::string::String, vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = if (0x2::table_vec::length<NftData>(&arg0.nfts) == 1) {
            0x2::table_vec::pop_back<NftData>(&mut arg0.nfts)
        } else {
            0x2::table_vec::swap_remove<NftData>(&mut arg0.nfts, arg1)
        };
        let NftData {
            number       : v1,
            image_url    : v2,
            name         : v3,
            description  : v4,
            trait_types  : v5,
            trait_values : v6,
        } = v0;
        (v1, v2, v3, v4, v5, v6)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = CollectionData{
            id          : 0x2::object::new(arg0),
            nfts        : 0x2::table_vec::empty<NftData>(arg0),
            total_added : 0,
            owner       : v0,
        };
        0x2::transfer::share_object<CollectionData>(v1);
        let v2 = DataCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<DataCap>(v2, v0);
    }

    public fun is_locked(arg0: &CollectionData) : bool {
        arg0.owner == @0x0
    }

    public fun lock_collection(arg0: &mut CollectionData, arg1: &DataCap, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 999);
        arg0.owner = @0x0;
    }

    public fun nfts_left(arg0: &CollectionData) : u64 {
        0x2::table_vec::length<NftData>(&arg0.nfts)
    }

    public fun total_added(arg0: &CollectionData) : u64 {
        arg0.total_added
    }

    // decompiled from Move bytecode v6
}

