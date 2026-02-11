module 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::video {
    struct Video has key {
        id: 0x2::object::UID,
        owner: address,
        blob_id: vector<u8>,
        blob_object_id: 0x2::object::ID,
        title: vector<u8>,
        description: vector<u8>,
        thumbnail_blob_id: vector<u8>,
        visibility: u8,
        forever_price_micro: u64,
        rental_price_micro: u64,
        rental_duration_ms: u64,
        uploaded_ms: u64,
    }

    struct VideoUploaded has copy, drop {
        owner: address,
        video_id: 0x2::object::ID,
        title: vector<u8>,
        forever_price: u64,
        rental_price: u64,
    }

    struct PriceUpdated has copy, drop {
        video_id: 0x2::object::ID,
        forever_price: u64,
        rental_price: u64,
    }

    public fun get_forever_price(arg0: &Video) : u64 {
        arg0.forever_price_micro
    }

    public fun get_rental_duration(arg0: &Video) : u64 {
        arg0.rental_duration_ms
    }

    public fun get_rental_price(arg0: &Video) : u64 {
        arg0.rental_price_micro
    }

    entry fun make_free(arg0: &mut Video, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
        arg0.forever_price_micro = 0;
        arg0.rental_price_micro = 0;
        let v0 = PriceUpdated{
            video_id      : 0x2::object::id<Video>(arg0),
            forever_price : 0,
            rental_price  : 0,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    entry fun set_visibility(arg0: &mut Video, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(arg1 <= 2, 2);
        arg0.visibility = arg1;
    }

    entry fun update_pricing(arg0: &mut Video, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 1);
        arg0.forever_price_micro = arg1;
        arg0.rental_price_micro = arg2;
        arg0.rental_duration_ms = arg3;
        let v0 = PriceUpdated{
            video_id      : 0x2::object::id<Video>(arg0),
            forever_price : arg1,
            rental_price  : arg2,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    entry fun update_video(arg0: &mut Video, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 1);
        arg0.title = arg1;
        arg0.description = arg2;
        arg0.thumbnail_blob_id = arg3;
    }

    entry fun upload_video(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(arg5 <= 2, 2);
        let v1 = Video{
            id                  : 0x2::object::new(arg10),
            owner               : v0,
            blob_id             : arg0,
            blob_object_id      : arg1,
            title               : arg2,
            description         : arg3,
            thumbnail_blob_id   : arg4,
            visibility          : arg5,
            forever_price_micro : arg6,
            rental_price_micro  : arg7,
            rental_duration_ms  : arg8,
            uploaded_ms         : arg9,
        };
        0x2::transfer::transfer<Video>(v1, v0);
        let v2 = VideoUploaded{
            owner         : v0,
            video_id      : 0x2::object::id<Video>(&v1),
            title         : v1.title,
            forever_price : v1.forever_price_micro,
            rental_price  : v1.rental_price_micro,
        };
        0x2::event::emit<VideoUploaded>(v2);
    }

    // decompiled from Move bytecode v6
}

