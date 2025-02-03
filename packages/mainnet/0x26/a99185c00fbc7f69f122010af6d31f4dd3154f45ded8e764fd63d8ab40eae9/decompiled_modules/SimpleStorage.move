module 0x26a99185c00fbc7f69f122010af6d31f4dd3154f45ded8e764fd63d8ab40eae9::SimpleStorage {
    struct StoredData has store, key {
        id: 0x2::object::UID,
        birthdate: u64,
        name: vector<u8>,
    }

    public entry fun store_data(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StoredData{
            id        : 0x2::object::new(arg0),
            birthdate : 14111987,
            name      : b"sadkov",
        };
        0x2::transfer::public_share_object<StoredData>(v0);
    }

    // decompiled from Move bytecode v6
}

