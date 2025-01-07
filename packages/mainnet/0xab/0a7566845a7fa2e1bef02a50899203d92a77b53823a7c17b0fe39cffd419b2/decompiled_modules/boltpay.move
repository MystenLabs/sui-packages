module 0xab0a7566845a7fa2e1bef02a50899203d92a77b53823a7c17b0fe39cffd419b2::boltpay {
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
        0x2::coin::value<T0>(&arg0);
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

