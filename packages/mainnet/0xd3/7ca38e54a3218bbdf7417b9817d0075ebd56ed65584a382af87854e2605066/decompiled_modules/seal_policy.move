module 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::seal_policy {
    public fun owner_check(arg0: vector<u8>, arg1: &0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::mandate::Mandate, arg2: &0x2::tx_context::TxContext) {
        let (v0, _) = 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::seal_id::decode(arg0);
        assert!(v0 == 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::mandate::id(arg1), 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::errors::not_owner());
        assert!(0x2::tx_context::sender(arg2) == 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::mandate::owner(arg1), 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::errors::not_owner());
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::mandate::Mandate, arg2: &0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::market_registry::MarketRegistry, arg3: address, arg4: u8, arg5: u64, arg6: address, arg7: u64, arg8: &0x2::clock::Clock) {
        seal_check(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun seal_approve_owner(arg0: vector<u8>, arg1: &0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::mandate::Mandate, arg2: &0x2::tx_context::TxContext) {
        owner_check(arg0, arg1, arg2);
    }

    public fun seal_check(arg0: vector<u8>, arg1: &0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::mandate::Mandate, arg2: &0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::market_registry::MarketRegistry, arg3: address, arg4: u8, arg5: u64, arg6: address, arg7: u64, arg8: &0x2::clock::Clock) {
        let (v0, v1) = 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::seal_id::decode(arg0);
        assert!(v0 == 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::mandate::id(arg1), 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::errors::nonce());
        assert!(v1 == 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::mandate::nonce(arg1), 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::errors::nonce());
        let v2 = 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::new_intent(v0, 0x2::object::id_from_address(arg3), arg4, arg5, arg6, v1, arg7);
        0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::check(arg1, arg2, &v2, arg8);
    }

    // decompiled from Move bytecode v7
}

