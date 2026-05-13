module 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft {
    struct MemoryPack has store, key {
        id: 0x2::object::UID,
        namespace: 0x1::string::String,
        blob_ids: vector<0x2::object::ID>,
        pack_type: u8,
        creator: address,
        poa_proofs: vector<vector<u8>>,
        performance_score: u8,
        is_listed: bool,
        royalty_bps: u16,
        memwal_delegate: address,
    }

    struct PackMinted has copy, drop {
        pack_id: 0x2::object::ID,
        creator: address,
        namespace: 0x1::string::String,
    }

    public fun id(arg0: &MemoryPack) : 0x2::object::ID {
        0x2::object::id<MemoryPack>(arg0)
    }

    public fun burn_pack(arg0: MemoryPack) {
        let MemoryPack {
            id                : v0,
            namespace         : _,
            blob_ids          : _,
            pack_type         : _,
            creator           : _,
            poa_proofs        : _,
            performance_score : _,
            is_listed         : _,
            royalty_bps       : _,
            memwal_delegate   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun creator(arg0: &MemoryPack) : address {
        arg0.creator
    }

    public fun memwal_delegate(arg0: &MemoryPack) : address {
        arg0.memwal_delegate
    }

    public fun mint_pack(arg0: vector<u8>, arg1: vector<0x2::object::ID>, arg2: u8, arg3: vector<vector<u8>>, arg4: u8, arg5: u16, arg6: &mut 0x2::tx_context::TxContext) : MemoryPack {
        assert!(arg5 <= 1000, 1);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = MemoryPack{
            id                : 0x2::object::new(arg6),
            namespace         : 0x1::string::utf8(arg0),
            blob_ids          : arg1,
            pack_type         : arg2,
            creator           : v0,
            poa_proofs        : arg3,
            performance_score : arg4,
            is_listed         : false,
            royalty_bps       : arg5,
            memwal_delegate   : v0,
        };
        let v2 = PackMinted{
            pack_id   : 0x2::object::id<MemoryPack>(&v1),
            creator   : v0,
            namespace : v1.namespace,
        };
        0x2::event::emit<PackMinted>(v2);
        v1
    }

    public fun royalty_bps(arg0: &MemoryPack) : u16 {
        arg0.royalty_bps
    }

    public fun set_listed(arg0: &mut MemoryPack, arg1: bool) {
        arg0.is_listed = arg1;
    }

    public(friend) fun set_memwal_delegate(arg0: &mut MemoryPack, arg1: address) {
        arg0.memwal_delegate = arg1;
    }

    public fun share_to_sender(arg0: MemoryPack, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MemoryPack>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

