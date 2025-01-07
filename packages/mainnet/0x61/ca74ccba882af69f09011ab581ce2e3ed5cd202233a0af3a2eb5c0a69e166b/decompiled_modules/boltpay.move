module 0x61ca74ccba882af69f09011ab581ce2e3ed5cd202233a0af3a2eb5c0a69e166b::boltpay {
    struct MerchantDetails has store, key {
        id: 0x2::object::UID,
        amount: u64,
        merchant_id: u64,
        protocol_name: 0x1::string::String,
        merchant_name: 0x1::string::String,
    }

    struct MerchantDetailsEvent has copy, drop {
        amount: u64,
        merchant_id: u64,
        protocol_name: 0x1::string::String,
        merchant_name: 0x1::string::String,
    }

    public entry fun create_tx<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: 0x1::string::String, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) == arg4, 0);
        let v0 = 0x1::string::utf8(b"Powered by Boltpay");
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg3);
        let v1 = MerchantDetails{
            id            : 0x2::object::new(arg5),
            amount        : arg4,
            merchant_id   : arg1,
            protocol_name : v0,
            merchant_name : arg2,
        };
        let v2 = MerchantDetailsEvent{
            amount        : arg4,
            merchant_id   : arg1,
            protocol_name : v0,
            merchant_name : arg2,
        };
        0x2::event::emit<MerchantDetailsEvent>(v2);
        0x2::transfer::transfer<MerchantDetails>(v1, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

