module 0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::merchant_registry {
    struct Merchant has key {
        id: 0x2::object::UID,
        business_name: 0x1::string::String,
        sector: 0x1::string::String,
        location: 0x1::string::String,
        kyc_url: 0x1::string::String,
        bank_details: 0x1::string::String,
        is_verified: bool,
        joined_at: u64,
    }

    struct MerchantRegistered has copy, drop {
        merchant_id: 0x2::object::ID,
        business_name: 0x1::string::String,
        sector: 0x1::string::String,
        owner: address,
        timestamp: u64,
    }

    public entry fun register_merchant(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg0) > 0, 1);
        assert!(0x1::string::length(&arg1) > 0, 1);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = Merchant{
            id            : 0x2::object::new(arg6),
            business_name : arg0,
            sector        : arg1,
            location      : arg2,
            kyc_url       : arg3,
            bank_details  : arg4,
            is_verified   : false,
            joined_at     : v1,
        };
        let v3 = MerchantRegistered{
            merchant_id   : 0x2::object::id<Merchant>(&v2),
            business_name : v2.business_name,
            sector        : v2.sector,
            owner         : v0,
            timestamp     : v1,
        };
        0x2::event::emit<MerchantRegistered>(v3);
        0x2::transfer::transfer<Merchant>(v2, v0);
    }

    // decompiled from Move bytecode v6
}

