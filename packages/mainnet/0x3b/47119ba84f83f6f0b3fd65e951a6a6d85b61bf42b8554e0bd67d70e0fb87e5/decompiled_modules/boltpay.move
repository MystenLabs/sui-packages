module 0x3b47119ba84f83f6f0b3fd65e951a6a6d85b61bf42b8554e0bd67d70e0fb87e5::boltpay {
    struct MerchantDetails has store, key {
        id: 0x2::object::UID,
        merchant_id: u64,
        merchant_name: 0x1::string::String,
        protocol_name: 0x1::string::String,
    }

    struct MerchantDetailsEvent has copy, drop {
        merchant_id: u64,
        merchant_name: 0x1::string::String,
        protocol_name: 0x1::string::String,
    }

    public entry fun transaction_identifier(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MerchantDetails{
            id            : 0x2::object::new(arg3),
            merchant_id   : arg0,
            merchant_name : arg1,
            protocol_name : arg2,
        };
        let v1 = MerchantDetailsEvent{
            merchant_id   : arg0,
            merchant_name : arg1,
            protocol_name : arg2,
        };
        0x2::event::emit<MerchantDetailsEvent>(v1);
        0x2::transfer::transfer<MerchantDetails>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

