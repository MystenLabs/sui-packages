module 0xff3977bb7190a8de5563af409d92366080873d90323c239e0a62ac6b037ea16d::paywall {
    struct Video has key {
        id: 0x2::object::UID,
        price: u64,
        creator: address,
        preview_blob_id: 0x1::string::String,
        full_blob_id: 0x1::string::String,
    }

    struct AccessPass has key {
        id: 0x2::object::UID,
        video_id: 0x2::object::ID,
    }

    public fun access_pass_video_id(arg0: &AccessPass) : 0x2::object::ID {
        arg0.video_id
    }

    public fun create_video(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Video{
            id              : 0x2::object::new(arg3),
            price           : arg0,
            creator         : 0x2::tx_context::sender(arg3),
            preview_blob_id : arg1,
            full_blob_id    : arg2,
        };
        0x2::transfer::share_object<Video>(v0);
    }

    public fun purchase(arg0: &Video, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : AccessPass {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.price, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.creator);
        AccessPass{
            id       : 0x2::object::new(arg2),
            video_id : 0x2::object::id<Video>(arg0),
        }
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &AccessPass, arg2: &Video) {
        assert!(arg1.video_id == 0x2::object::id<Video>(arg2), 1);
        let v0 = 0x2::object::id_bytes<Video>(arg2);
        let v1 = 0x1::vector::length<u8>(&v0);
        assert!(0x1::vector::length<u8>(&arg0) >= v1, 2);
        let v2 = 0;
        while (v2 < v1) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v2) == *0x1::vector::borrow<u8>(&v0, v2), 2);
            v2 = v2 + 1;
        };
    }

    public fun video_creator(arg0: &Video) : address {
        arg0.creator
    }

    public fun video_full_blob_id(arg0: &Video) : &0x1::string::String {
        &arg0.full_blob_id
    }

    public fun video_preview_blob_id(arg0: &Video) : &0x1::string::String {
        &arg0.preview_blob_id
    }

    public fun video_price(arg0: &Video) : u64 {
        arg0.price
    }

    // decompiled from Move bytecode v6
}

