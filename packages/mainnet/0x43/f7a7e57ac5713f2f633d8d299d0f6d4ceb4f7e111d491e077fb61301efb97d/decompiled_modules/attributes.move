module 0x43f7a7e57ac5713f2f633d8d299d0f6d4ceb4f7e111d491e077fb61301efb97d::attributes {
    struct NftData has store {
        number: u64,
        keys: vector<0x1::string::String>,
        values: vector<0x1::string::String>,
        image_url: 0x1::string::String,
    }

    struct CollectionData has key {
        id: 0x2::object::UID,
        nfts: 0x2::table_vec::TableVec<NftData>,
    }

    struct DataCap has store, key {
        id: 0x2::object::UID,
    }

    fun attributes() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Background"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Clothes"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Hand"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Head"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Mouth"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Eyes"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Theme"));
        v0
    }

    public fun add_attribute(arg0: &mut CollectionData, arg1: &DataCap, arg2: u64, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>) {
        assert!(0x2::table_vec::length<NftData>(&arg0.nfts) < 5555 && 5555 >= arg2, 9223372251603140607);
        assert!(!0x1::string::is_empty(&arg3), 9223372255898107903);
        let v0 = if (is_robot(arg2)) {
            robot_attributes()
        } else {
            attributes()
        };
        let v1 = v0;
        let v2 = &arg4;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<0x1::string::String>(v2)) {
            if (!0x1::vector::contains<0x1::string::String>(&v1, 0x1::vector::borrow<0x1::string::String>(v2, v3))) {
                v4 = false;
                /* label 17 */
                assert!(v4, 9223372273077977087);
                let v5 = NftData{
                    number    : arg2,
                    keys      : arg4,
                    values    : arg5,
                    image_url : arg3,
                };
                0x2::table_vec::push_back<NftData>(&mut arg0.nfts, v5);
                return
            };
            v3 = v3 + 1;
        };
        v4 = true;
        /* goto 17 */
    }

    public fun destroy_data(arg0: CollectionData, arg1: DataCap) {
        let CollectionData {
            id   : v0,
            nfts : v1,
        } = arg0;
        let v2 = v1;
        assert!(0x2::table_vec::is_empty<NftData>(&v2), 9223372337502486527);
        0x2::table_vec::destroy_empty<NftData>(v2);
        0x2::object::delete(v0);
        let DataCap { id: v3 } = arg1;
        0x2::object::delete(v3);
    }

    public(friend) fun get_nft(arg0: &mut CollectionData, arg1: u64) : (u64, 0x1::string::String, vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = if (0x2::table_vec::length<NftData>(&arg0.nfts) == 1) {
            0x2::table_vec::pop_back<NftData>(&mut arg0.nfts)
        } else {
            0x2::table_vec::swap_remove<NftData>(&mut arg0.nfts, arg1)
        };
        let NftData {
            number    : v1,
            keys      : v2,
            values    : v3,
            image_url : v4,
        } = v0;
        (v1, v4, v2, v3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectionData{
            id   : 0x2::object::new(arg0),
            nfts : 0x2::table_vec::empty<NftData>(arg0),
        };
        0x2::transfer::share_object<CollectionData>(v0);
        let v1 = DataCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<DataCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_robot(arg0: u64) : bool {
        arg0 > 5545
    }

    public fun nfts_left(arg0: &CollectionData) : u64 {
        0x2::table_vec::length<NftData>(&arg0.nfts)
    }

    fun robot_attributes() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Background"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Serial"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Theme"));
        v0
    }

    // decompiled from Move bytecode v6
}

