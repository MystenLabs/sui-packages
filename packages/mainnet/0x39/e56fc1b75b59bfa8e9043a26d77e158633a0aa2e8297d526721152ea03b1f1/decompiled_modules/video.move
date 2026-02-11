module 0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::video {
    struct Video has key {
        id: 0x2::object::UID,
        creator: address,
        title: vector<u8>,
        description: vector<u8>,
        blob_id: vector<u8>,
        blob_object_id: 0x2::object::ID,
        walrus_blob_ref: 0x2::object::ID,
        thumbnail_url: vector<u8>,
        forever_price_micro: u64,
        rental_price_micro: u64,
        rental_duration_ms: u64,
        visibility: u8,
        created_ms: u64,
    }

    struct VideoRegistered has copy, drop {
        video_id: 0x2::object::ID,
        creator: address,
        title: vector<u8>,
    }

    public fun get_creator(arg0: &Video) : address {
        arg0.creator
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

    public fun is_free(arg0: &Video) : bool {
        arg0.forever_price_micro == 0 && arg0.rental_price_micro == 0
    }

    entry fun make_free(arg0: &mut Video, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 1);
        arg0.forever_price_micro = 0;
        arg0.rental_price_micro = 0;
    }

    entry fun register_video(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = Video{
            id                  : 0x2::object::new(arg10),
            creator             : v0,
            title               : arg0,
            description         : arg1,
            blob_id             : arg2,
            blob_object_id      : arg3,
            walrus_blob_ref     : arg4,
            thumbnail_url       : arg5,
            forever_price_micro : arg6,
            rental_price_micro  : arg7,
            rental_duration_ms  : arg8,
            visibility          : 0,
            created_ms          : arg9,
        };
        0x2::transfer::share_object<Video>(v1);
        let v2 = VideoRegistered{
            video_id : 0x2::object::uid_to_inner(&v1.id),
            creator  : v0,
            title    : arg0,
        };
        0x2::event::emit<VideoRegistered>(v2);
    }

    entry fun set_visibility(arg0: &mut Video, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        arg0.visibility = arg1;
    }

    entry fun update_pricing(arg0: &mut Video, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg4), 1);
        arg0.forever_price_micro = arg1;
        arg0.rental_price_micro = arg2;
        arg0.rental_duration_ms = arg3;
    }

    entry fun update_video(arg0: &mut Video, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg4), 1);
        arg0.title = arg1;
        arg0.description = arg2;
        arg0.thumbnail_url = arg3;
    }

    // decompiled from Move bytecode v6
}

