module 0xefb5dc861c296cfcceb7fb72c5533efddbc6cdc85395cd29b55119292b16b8cc::blob_manager {
    struct BlobsSubmitted has copy, drop {
        uploader: address,
        main_blob_id: 0x1::string::String,
        preview_blob_id: 0x1::string::String,
        seal_policy_id: 0x1::string::String,
        duration_seconds: u64,
        fee_paid_sui: u64,
    }

    public fun submit_blobs(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= 250000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, 250000000, arg5), @0xca793690985183dc8e2180fd059d76f3b0644f5c2ecd3b01cdebe7d40b0cca39);
        if (0x2::coin::value<0x2::sui::SUI>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        };
        let v1 = BlobsSubmitted{
            uploader         : v0,
            main_blob_id     : arg0,
            preview_blob_id  : arg1,
            seal_policy_id   : arg2,
            duration_seconds : arg3,
            fee_paid_sui     : 250000000,
        };
        0x2::event::emit<BlobsSubmitted>(v1);
    }

    // decompiled from Move bytecode v6
}

