module 0xc9259a764774079b56742c311722e39390bd50850a632270f03ea040de6bf205::blog {
    struct Post has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        created_at: u64,
        updated_at: u64,
        post_blob_id: 0x1::string::String,
        post_metadata_id: 0x2::object::ID,
    }

    struct PostMetadata has store, key {
        id: 0x2::object::UID,
        post_id: 0x2::object::ID,
        owner: address,
        like: u64,
        tag: vector<0x1::string::String>,
        price: 0x1::option::Option<u64>,
    }

    struct PostPayment has key {
        id: 0x2::object::UID,
        list: 0x2::table::Table<0x2::object::ID, vector<address>>,
    }

    fun approve_internal(arg0: address, arg1: vector<u8>, arg2: &PostPayment, arg3: &PostMetadata) : bool {
        if (!is_prefix(namespace(arg2), arg1)) {
            return false
        };
        0x1::vector::contains<address>(0x2::table::borrow<0x2::object::ID, vector<address>>(&arg2.list, arg3.post_id), &arg0)
    }

    public fun create_post(arg0: &0xc9259a764774079b56742c311722e39390bd50850a632270f03ea040de6bf205::user::User, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::object::new(arg4);
        let v2 = Post{
            id               : 0x2::object::new(arg4),
            title            : arg1,
            created_at       : v0,
            updated_at       : v0,
            post_blob_id     : arg2,
            post_metadata_id : 0x2::object::uid_to_inner(&v1),
        };
        let v3 = PostMetadata{
            id      : v1,
            post_id : 0x2::object::uid_to_inner(&v2.id),
            owner   : 0x2::tx_context::sender(arg4),
            like    : 0,
            tag     : 0x1::vector::empty<0x1::string::String>(),
            price   : 0x1::option::some<u64>(10000000),
        };
        0x2::transfer::public_transfer<Post>(v2, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_share_object<PostMetadata>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PostPayment{
            id   : 0x2::object::new(arg0),
            list : 0x2::table::new<0x2::object::ID, vector<address>>(arg0),
        };
        0x2::transfer::share_object<PostPayment>(v0);
    }

    fun is_prefix(arg0: vector<u8>, arg1: vector<u8>) : bool {
        if (0x1::vector::length<u8>(&arg0) > 0x1::vector::length<u8>(&arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            if (*0x1::vector::borrow<u8>(&arg0, v0) != *0x1::vector::borrow<u8>(&arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun is_purchased_post(arg0: &PostPayment, arg1: &PostMetadata, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = arg1.post_id;
        if (!0x2::table::contains<0x2::object::ID, vector<address>>(&arg0.list, v0)) {
            return false
        };
        let v1 = 0x2::tx_context::sender(arg2);
        0x1::vector::contains<address>(0x2::table::borrow<0x2::object::ID, vector<address>>(&arg0.list, v0), &v1)
    }

    public fun namespace(arg0: &PostPayment) : vector<u8> {
        0x2::object::uid_to_bytes(&arg0.id)
    }

    public fun purchase_post(arg0: &mut PostPayment, arg1: &PostMetadata, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 10000000, 0);
        let v0 = arg1.post_id;
        if (!0x2::table::contains<0x2::object::ID, vector<address>>(&arg0.list, v0)) {
            0x2::table::add<0x2::object::ID, vector<address>>(&mut arg0.list, v0, 0x1::vector::empty<address>());
        };
        0x1::vector::push_back<address>(0x2::table::borrow_mut<0x2::object::ID, vector<address>>(&mut arg0.list, v0), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg1.owner);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &PostPayment, arg2: &PostMetadata, arg3: &0x2::tx_context::TxContext) {
        assert!(approve_internal(0x2::tx_context::sender(arg3), arg0, arg1, arg2), 9999);
    }

    // decompiled from Move bytecode v6
}

