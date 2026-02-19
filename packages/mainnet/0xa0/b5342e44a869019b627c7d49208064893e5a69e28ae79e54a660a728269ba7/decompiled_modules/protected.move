module 0xa0b5342e44a869019b627c7d49208064893e5a69e28ae79e54a660a728269ba7::protected {
    struct ProtectedStorage {
        storage: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,
    }

    public(friend) fun borrow(arg0: &ProtectedStorage) : &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage {
        &arg0.storage
    }

    public(friend) fun borrow_mut(arg0: &mut ProtectedStorage) : &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage {
        &mut arg0.storage
    }

    public fun protect(arg0: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : ProtectedStorage {
        ProtectedStorage{storage: arg0}
    }

    public fun unprotect_and_reshare(arg0: ProtectedStorage) {
        let ProtectedStorage { storage: v0 } = arg0;
        0x2::transfer::public_share_object<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(v0);
    }

    // decompiled from Move bytecode v6
}

