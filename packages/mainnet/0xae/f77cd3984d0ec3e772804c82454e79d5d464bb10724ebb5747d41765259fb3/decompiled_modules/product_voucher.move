module 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::product_voucher {
    struct ProductVoucher has store, key {
        id: 0x2::object::UID,
        store_id: 0x2::object::ID,
        game_id: 0x2::object::ID,
        product_id: 0x2::object::ID,
        voucher_number: u64,
        product_name: 0x1::string::String,
        purchased_at: u64,
        is_code_revealed: bool,
    }

    struct ProductCodeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProductCode has store {
        code_hash: vector<u8>,
        code_type: 0x1::string::String,
        is_used: bool,
        used_at: 0x1::option::Option<u64>,
    }

    struct ProductVoucherMinted has copy, drop {
        voucher_id: 0x2::object::ID,
        buyer: address,
        store_id: 0x2::object::ID,
        game_id: 0x2::object::ID,
        product_id: 0x2::object::ID,
        voucher_number: u64,
    }

    struct ProductCodeRevealed has copy, drop {
        voucher_id: 0x2::object::ID,
        owner: address,
        code_type: 0x1::string::String,
    }

    struct ProductCodeUsed has copy, drop {
        voucher_id: 0x2::object::ID,
        owner: address,
        code_type: 0x1::string::String,
    }

    public fun get_code_type(arg0: &ProductVoucher) : 0x1::string::String {
        let v0 = ProductCodeKey{dummy_field: false};
        0x2::dynamic_field::borrow<ProductCodeKey, ProductCode>(&arg0.id, v0).code_type
    }

    public fun get_code_used_at(arg0: &ProductVoucher) : 0x1::option::Option<u64> {
        let v0 = ProductCodeKey{dummy_field: false};
        0x2::dynamic_field::borrow<ProductCodeKey, ProductCode>(&arg0.id, v0).used_at
    }

    public fun is_code_revealed(arg0: &ProductVoucher) : bool {
        arg0.is_code_revealed
    }

    public fun is_code_used(arg0: &ProductVoucher) : bool {
        let v0 = ProductCodeKey{dummy_field: false};
        0x2::dynamic_field::borrow<ProductCodeKey, ProductCode>(&arg0.id, v0).is_used
    }

    public fun is_transferable(arg0: &ProductVoucher) : bool {
        !arg0.is_code_revealed
    }

    public fun mark_code_used(arg0: &mut ProductVoucher, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.is_code_revealed, 3);
        let v0 = ProductCodeKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<ProductCodeKey, ProductCode>(&mut arg0.id, v0);
        assert!(!v1.is_used, 4);
        v1.is_used = true;
        v1.used_at = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg1));
        let v2 = ProductCodeUsed{
            voucher_id : 0x2::object::id<ProductVoucher>(arg0),
            owner      : 0x2::tx_context::sender(arg2),
            code_type  : get_code_type(arg0),
        };
        0x2::event::emit<ProductCodeUsed>(v2);
    }

    public(friend) fun mint_product_voucher(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::string::String, arg5: vector<u8>, arg6: 0x1::string::String, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg9);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = ProductVoucher{
            id               : v0,
            store_id         : arg0,
            game_id          : arg1,
            product_id       : arg2,
            voucher_number   : arg3,
            product_name     : arg4,
            purchased_at     : 0x2::clock::timestamp_ms(arg8),
            is_code_revealed : false,
        };
        let v3 = ProductCode{
            code_hash : arg5,
            code_type : arg6,
            is_used   : false,
            used_at   : 0x1::option::none<u64>(),
        };
        let v4 = ProductCodeKey{dummy_field: false};
        0x2::dynamic_field::add<ProductCodeKey, ProductCode>(&mut v2.id, v4, v3);
        let v5 = ProductVoucherMinted{
            voucher_id     : v1,
            buyer          : arg7,
            store_id       : arg0,
            game_id        : arg1,
            product_id     : arg2,
            voucher_number : arg3,
        };
        0x2::event::emit<ProductVoucherMinted>(v5);
        0x2::transfer::public_transfer<ProductVoucher>(v2, arg7);
        v1
    }

    public fun reveal_code(arg0: &mut ProductVoucher, arg1: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_code_revealed, 2);
        arg0.is_code_revealed = true;
        let v0 = ProductCodeRevealed{
            voucher_id : 0x2::object::id<ProductVoucher>(arg0),
            owner      : 0x2::tx_context::sender(arg1),
            code_type  : get_code_type(arg0),
        };
        0x2::event::emit<ProductCodeRevealed>(v0);
    }

    public fun verify_product_code(arg0: &ProductVoucher, arg1: vector<u8>) : bool {
        let v0 = ProductCodeKey{dummy_field: false};
        0x1::hash::sha2_256(arg1) == 0x2::dynamic_field::borrow<ProductCodeKey, ProductCode>(&arg0.id, v0).code_hash
    }

    public fun voucher_game_id(arg0: &ProductVoucher) : 0x2::object::ID {
        arg0.game_id
    }

    public fun voucher_id(arg0: &ProductVoucher) : 0x2::object::ID {
        0x2::object::id<ProductVoucher>(arg0)
    }

    public fun voucher_number(arg0: &ProductVoucher) : u64 {
        arg0.voucher_number
    }

    public fun voucher_product_id(arg0: &ProductVoucher) : 0x2::object::ID {
        arg0.product_id
    }

    public fun voucher_product_name(arg0: &ProductVoucher) : 0x1::string::String {
        arg0.product_name
    }

    public fun voucher_purchased_at(arg0: &ProductVoucher) : u64 {
        arg0.purchased_at
    }

    public fun voucher_store_id(arg0: &ProductVoucher) : 0x2::object::ID {
        arg0.store_id
    }

    // decompiled from Move bytecode v7
}

