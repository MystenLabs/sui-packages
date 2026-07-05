module 0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::provision {
    entry fun subscribe<T0>(arg0: &mut 0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::admin::GlobalConfig, arg1: &0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::subscription::PlanRegistry, arg2: &mut 0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::treasury::Treasury, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::subscription::subscribe<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v3 = v0;
        let v4 = 0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::storage::create_blob_store(arg5);
        0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::subscription::set_blob_store_id(&mut v3, 0x2::object::id<0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::storage::BlobStore>(&v4));
        0x2::transfer::public_share_object<0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::storage::BlobStore>(v4);
        let v5 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::subscription::UserAccount>(v3, v5);
        0x2::transfer::public_transfer<0x97a1bd5744867b6e2843680565135a57cd1f6e7a5b553250b855fc9d2bc9b::subscription::Subscription>(v1, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v5);
    }

    // decompiled from Move bytecode v7
}

