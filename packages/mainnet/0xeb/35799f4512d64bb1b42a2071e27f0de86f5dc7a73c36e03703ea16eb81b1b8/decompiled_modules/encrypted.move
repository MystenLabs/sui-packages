module 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::encrypted {
    struct EncryptedPost has store, key {
        id: 0x2::object::UID,
        temple_id: 0x2::object::ID,
        author: address,
        genome_id: 0x2::object::ID,
        title: vector<u8>,
        encrypted_blob_id: vector<u8>,
        decrypt_price: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        access_list: 0x2::table::Table<address, bool>,
        created_at: u64,
    }

    public entry fun create_encrypted_post(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) > 0, 200);
        assert!(arg4 > 0, 600);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x2::table::new<address, bool>(arg6);
        0x2::table::add<address, bool>(&mut v2, v0, true);
        let v3 = EncryptedPost{
            id                : 0x2::object::new(arg6),
            temple_id         : arg0,
            author            : v0,
            genome_id         : arg1,
            title             : arg2,
            encrypted_blob_id : arg3,
            decrypt_price     : arg4,
            treasury          : 0x2::balance::zero<0x2::sui::SUI>(),
            access_list       : v2,
            created_at        : v1,
        };
        0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::events::emit_encrypted_post_created(0x2::object::id<EncryptedPost>(&v3), arg0, v0, v3.title, arg4, v1);
        0x2::transfer::share_object<EncryptedPost>(v3);
    }

    public fun encrypted_post_author(arg0: &EncryptedPost) : address {
        arg0.author
    }

    public fun encrypted_post_has_access(arg0: &EncryptedPost, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.access_list, arg1)
    }

    public fun encrypted_post_price(arg0: &EncryptedPost) : u64 {
        arg0.decrypt_price
    }

    public fun encrypted_post_title(arg0: &EncryptedPost) : &vector<u8> {
        &arg0.title
    }

    public fun encrypted_post_treasury_value(arg0: &EncryptedPost) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    fun is_prefix(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 > 0x1::vector::length<u8>(arg1)) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public entry fun purchase_access(arg0: &mut EncryptedPost, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, bool>(&arg0.access_list, v0), 602);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.decrypt_price, 601);
        let v1 = arg0.decrypt_price;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg3)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        0x2::table::add<address, bool>(&mut arg0.access_list, v0, true);
        0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::events::emit_access_purchased(0x2::object::id<EncryptedPost>(arg0), v0, v1, 0x2::clock::timestamp_ms(arg2));
    }

    public entry fun seal_approve(arg0: &EncryptedPost, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.access_list, 0x2::tx_context::sender(arg2)), 605);
        let v0 = 0x2::object::id_bytes<EncryptedPost>(arg0);
        assert!(is_prefix(&v0, &arg1), 605);
    }

    public entry fun withdraw_earnings(arg0: &mut EncryptedPost, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.author == v0, 603);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.treasury) > 0, 604);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury);
        0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::events::emit_earnings_withdrawn(0x2::object::id<EncryptedPost>(arg0), v0, v1, 0x2::clock::timestamp_ms(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, v1), arg2), v0);
    }

    // decompiled from Move bytecode v6
}

