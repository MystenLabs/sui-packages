module 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::migrate {
    struct ListingMigrated has copy, drop {
        old_listing_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
    }

    public fun migrate_listing(arg0: &0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::admin::AdminCap, arg1: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::Listings, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: 0x1::string::String, arg11: address, arg12: vector<u8>, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::migrate_create_listing(arg1, arg11, arg12, arg10, arg9, arg4, arg5, arg6, arg7, arg8, arg13, arg3, arg14);
        let v1 = ListingMigrated{
            old_listing_id : arg2,
            listing_id     : v0,
        };
        0x2::event::emit<ListingMigrated>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

