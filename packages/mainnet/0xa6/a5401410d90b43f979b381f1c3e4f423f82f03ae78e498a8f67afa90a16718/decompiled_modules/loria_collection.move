module 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_collection {
    struct LoriaCollection has store, key {
        id: 0x2::object::UID,
        url: 0x1::string::String,
        blob_id: 0x1::string::String,
        pack_blob_id: 0x1::string::String,
        website: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        pack_price: u64,
        max_packs: u64,
        minted_packs: u64,
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : LoriaCollection {
        let v0 = 0x1::string::utf8(b"https://walrus.tusky.io/");
        0x1::string::append(&mut v0, arg0);
        LoriaCollection{
            id           : 0x2::object::new(arg7),
            url          : v0,
            blob_id      : arg0,
            pack_blob_id : arg1,
            website      : arg2,
            name         : arg3,
            description  : arg4,
            pack_price   : arg5,
            max_packs    : arg6,
            minted_packs : 0,
        }
    }

    public fun get_id(arg0: &LoriaCollection) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_max_packs(arg0: &LoriaCollection) : u64 {
        arg0.max_packs
    }

    public fun get_mint_price(arg0: &LoriaCollection) : u64 {
        arg0.pack_price
    }

    public fun get_minted_packs(arg0: &LoriaCollection) : u64 {
        arg0.minted_packs
    }

    public fun get_pack_blob_id(arg0: &LoriaCollection) : 0x1::string::String {
        arg0.pack_blob_id
    }

    public(friend) fun increment_minted_packs(arg0: &mut LoriaCollection) {
        arg0.minted_packs = arg0.minted_packs + 1;
    }

    // decompiled from Move bytecode v6
}

