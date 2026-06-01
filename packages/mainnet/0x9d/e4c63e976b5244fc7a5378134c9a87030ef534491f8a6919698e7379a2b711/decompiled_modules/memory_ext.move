module 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_ext {
    struct Lineage has copy, drop, store {
        parent: 0x1::option::Option<0x2::object::ID>,
        root: 0x1::option::Option<0x2::object::ID>,
        fork_depth: u16,
        ancestors: vector<address>,
    }

    struct PackExt has copy, drop, store {
        version: u32,
        content_hash: vector<u8>,
        lineage: Lineage,
        updated_at_ms: u64,
    }

    public fun attach_ext(arg0: &mut 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::uid_mut(arg0);
        assert!(!0x2::dynamic_field::exists_<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::ExtKey>(v0, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::ext_key()), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_ext_exists());
        let v1 = PackExt{
            version       : 1,
            content_hash  : arg1,
            lineage       : default_lineage(),
            updated_at_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::dynamic_field::add<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::ExtKey, PackExt>(v0, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::ext_key(), v1);
    }

    public fun bump_version(arg0: &mut 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        if (!has_ext(arg0)) {
            attach_ext(arg0, arg1, arg2, arg3);
            return
        };
        let v0 = 0x2::dynamic_field::borrow_mut<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::ExtKey, PackExt>(0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::uid_mut(arg0), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::ext_key());
        let v1 = v0.version;
        v0.version = v1 + 1;
        v0.content_hash = arg1;
        v0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::events::emit_memory_versioned(0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::id(arg0), v1, v0.version, v0.content_hash, v0.updated_at_ms);
    }

    fun cap_ancestors(arg0: &mut vector<address>, arg1: u16) {
        while (0x1::vector::length<address>(arg0) > (arg1 as u64)) {
            0x1::vector::remove<address>(arg0, 0);
        };
    }

    public fun default_lineage() : Lineage {
        Lineage{
            parent     : 0x1::option::none<0x2::object::ID>(),
            root       : 0x1::option::none<0x2::object::ID>(),
            fork_depth : 0,
            ancestors  : vector[],
        }
    }

    public fun fork_pack(arg0: &0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack, arg1: vector<0x2::object::ID>, arg2: vector<u8>, arg3: u16, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack {
        let v0 = read_lineage(arg0);
        let v1 = 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::id(arg0);
        let v2 = v0.fork_depth + 1;
        assert!(v2 <= 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::max_fork_depth(), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_fork_depth());
        let v3 = if (0x1::option::is_some<0x2::object::ID>(&v0.root)) {
            *0x1::option::borrow<0x2::object::ID>(&v0.root)
        } else {
            v1
        };
        let v4 = v0.ancestors;
        0x1::vector::push_back<address>(&mut v4, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::creator(arg0));
        let v5 = &mut v4;
        cap_ancestors(v5, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::max_fork_depth());
        let v6 = 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::mint_pack(0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::namespace_bytes(arg0), arg1, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::pack_type(arg0), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::poa_proofs(arg0), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::performance_score(arg0), arg3, arg5);
        let v7 = Lineage{
            parent     : 0x1::option::some<0x2::object::ID>(v1),
            root       : 0x1::option::some<0x2::object::ID>(v3),
            fork_depth : v2,
            ancestors  : v4,
        };
        let v8 = PackExt{
            version       : 1,
            content_hash  : arg2,
            lineage       : v7,
            updated_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::dynamic_field::add<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::ExtKey, PackExt>(0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::uid_mut(&mut v6), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::ext_key(), v8);
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::events::emit_pack_forked(0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::id(&v6), v1, v3, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::creator(&v6), v2, arg2);
        v6
    }

    public fun get_version(arg0: &0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack) : u32 {
        if (!has_ext(arg0)) {
            return 1
        };
        0x2::dynamic_field::borrow<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::ExtKey, PackExt>(0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::uid(arg0), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::ext_key()).version
    }

    public fun has_ext(arg0: &0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack) : bool {
        0x2::dynamic_field::exists_<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::ExtKey>(0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::uid(arg0), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::ext_key())
    }

    public fun lineage_ancestors(arg0: &Lineage) : vector<address> {
        arg0.ancestors
    }

    public fun lineage_fork_depth(arg0: &Lineage) : u16 {
        arg0.fork_depth
    }

    public fun read_lineage(arg0: &0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack) : Lineage {
        if (!has_ext(arg0)) {
            return default_lineage()
        };
        0x2::dynamic_field::borrow<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::ExtKey, PackExt>(0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::uid(arg0), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::ext_key()).lineage
    }

    // decompiled from Move bytecode v7
}

