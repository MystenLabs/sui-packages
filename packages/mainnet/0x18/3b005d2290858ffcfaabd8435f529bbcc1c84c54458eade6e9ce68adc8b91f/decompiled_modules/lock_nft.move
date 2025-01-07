module 0x183b005d2290858ffcfaabd8435f529bbcc1c84c54458eade6e9ce68adc8b91f::lock_nft {
    struct LockedNFTCreated has copy, drop {
        id: 0x2::object::ID,
        creator: address,
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        key_hash: vector<u8>,
    }

    struct LockedNFTUnlocked has copy, drop {
        id: 0x2::object::ID,
        creator: address,
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        recipient: address,
        key: vector<u8>,
    }

    struct LockedNFT<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        creator: address,
        key_hash: vector<u8>,
        nft_object_table: 0x2::object_table::ObjectTable<0x2::object::ID, T0>,
        nft_table_key: 0x2::object::ID,
    }

    public entry fun lock_nft<T0: store + key>(arg0: T0, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg0);
        let v1 = 0x2::object_table::new<0x2::object::ID, T0>(arg2);
        0x2::object_table::add<0x2::object::ID, T0>(&mut v1, v0, arg0);
        let v2 = LockedNFT<T0>{
            id               : 0x2::object::new(arg2),
            creator          : 0x2::tx_context::sender(arg2),
            key_hash         : arg1,
            nft_object_table : v1,
            nft_table_key    : v0,
        };
        emit_locked_nft_created<T0>(&v2);
        0x2::transfer::public_share_object<LockedNFT<T0>>(v2);
    }

    public fun emit_locked_nft_created<T0: store + key>(arg0: &LockedNFT<T0>) {
        let v0 = LockedNFTCreated{
            id       : *0x2::object::borrow_id<LockedNFT<T0>>(arg0),
            creator  : arg0.creator,
            nft_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            nft_id   : arg0.nft_table_key,
            key_hash : arg0.key_hash,
        };
        0x2::event::emit<LockedNFTCreated>(v0);
    }

    public fun emit_locked_nft_unlocked<T0: store + key>(arg0: &LockedNFT<T0>, arg1: address, arg2: vector<u8>) {
        let v0 = LockedNFTUnlocked{
            id        : *0x2::object::borrow_id<LockedNFT<T0>>(arg0),
            creator   : arg0.creator,
            nft_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            nft_id    : arg0.nft_table_key,
            recipient : arg1,
            key       : arg2,
        };
        0x2::event::emit<LockedNFTUnlocked>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun unlock_nft<T0: store + key>(arg0: &mut LockedNFT<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::hash::sha3_256(arg1) == arg0.key_hash) {
            true
        } else {
            let v1 = 0x2::tx_context::sender(arg2);
            &arg0.creator == &v1
        };
        assert!(v0, 0);
        let v2 = 0x2::tx_context::sender(arg2);
        emit_locked_nft_unlocked<T0>(arg0, v2, arg1);
        0x2::transfer::public_transfer<T0>(0x2::object_table::remove<0x2::object::ID, T0>(&mut arg0.nft_object_table, arg0.nft_table_key), v2);
        arg0.key_hash = 0x1::vector::empty<u8>();
    }

    // decompiled from Move bytecode v6
}

