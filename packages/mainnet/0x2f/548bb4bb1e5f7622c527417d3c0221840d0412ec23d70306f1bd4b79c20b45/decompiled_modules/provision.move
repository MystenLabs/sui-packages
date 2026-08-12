module 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::provision {
    entry fun subscribe<T0>(arg0: &mut 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::GlobalConfig, arg1: &0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::PlanRegistry, arg2: &mut 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::treasury::Treasury, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::subscribe<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v3 = v0;
        let v4 = 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::storage::create_blob_store(arg5);
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::set_blob_store_id(&mut v3, 0x2::object::id<0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::storage::BlobStore>(&v4));
        0x2::transfer::public_share_object<0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::storage::BlobStore>(v4);
        let v5 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::UserAccount>(v3, v5);
        0x2::transfer::public_transfer<0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::Subscription>(v1, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v5);
    }

    // decompiled from Move bytecode v7
}

