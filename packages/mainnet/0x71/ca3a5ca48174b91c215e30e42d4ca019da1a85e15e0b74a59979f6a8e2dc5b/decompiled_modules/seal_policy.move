module 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::seal_policy {
    public fun owner_check(arg0: vector<u8>, arg1: &0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::Mandate, arg2: &0x2::tx_context::TxContext) {
        let (v0, _) = 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::seal_id::decode(arg0);
        assert!(v0 == 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::id(arg1), 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::not_owner());
        assert!(0x2::tx_context::sender(arg2) == 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::owner(arg1), 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::not_owner());
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::Mandate, arg2: &0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::market_registry::MarketRegistry, arg3: address, arg4: u8, arg5: u64, arg6: address, arg7: u64, arg8: &0x2::clock::Clock) {
        seal_check(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun seal_approve_owner(arg0: vector<u8>, arg1: &0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::Mandate, arg2: &0x2::tx_context::TxContext) {
        owner_check(arg0, arg1, arg2);
    }

    public fun seal_check(arg0: vector<u8>, arg1: &0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::Mandate, arg2: &0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::market_registry::MarketRegistry, arg3: address, arg4: u8, arg5: u64, arg6: address, arg7: u64, arg8: &0x2::clock::Clock) {
        let (v0, v1) = 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::seal_id::decode(arg0);
        assert!(v0 == 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::id(arg1), 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::nonce());
        assert!(v1 == 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::nonce(arg1), 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::nonce());
        let v2 = 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::new_intent(v0, 0x2::object::id_from_address(arg3), arg4, arg5, arg6, v1, arg7);
        0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::check(arg1, arg2, &v2, arg8);
    }

    // decompiled from Move bytecode v7
}

