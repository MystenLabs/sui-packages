module 0x99b5e921f24162117880eaeb9682e7e1675c09286e59fdbb34a0edb71280a00b::shadowpost {
    struct Secret has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        walrus_blob_id: vector<u8>,
        created_at: u64,
    }

    public entry fun send_secret(arg0: address, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Secret{
            id             : 0x2::object::new(arg3),
            sender         : 0x2::tx_context::sender(arg3),
            recipient      : arg0,
            walrus_blob_id : arg1,
            created_at     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::transfer::transfer<Secret>(v0, arg0);
    }

    // decompiled from Move bytecode v7
}

