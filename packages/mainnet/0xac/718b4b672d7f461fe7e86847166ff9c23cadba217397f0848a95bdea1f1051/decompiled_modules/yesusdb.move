module 0xac718b4b672d7f461fe7e86847166ff9c23cadba217397f0848a95bdea1f1051::yesusdb {
    struct YesUSDB has key {
        id: 0x2::object::UID,
    }

    public fun create_yield_vault<T0>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<YesUSDB>(arg0, decimals(), 0x1::string::utf8(b"yesUSDB"), 0x1::string::utf8(b"Yield-Enhanced sUSDB"), 0x1::string::utf8(b"yesUSDB is the auto-compound yield-bearing token of SUSDB saving pool"), 0x1::string::utf8(b"https://www.bucketprotocol.io/icons/sUSDB.svg"), arg5);
        0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::yield_usdb::default<YesUSDB, T0>(arg1, arg2, v1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::new(0x1::option::none<0x1::string::String>(), arg5), arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<YesUSDB>>(0x2::coin_registry::finalize<YesUSDB>(v0, arg5), 0x2::tx_context::sender(arg5));
    }

    public fun decimals() : u8 {
        6
    }

    // decompiled from Move bytecode v6
}

