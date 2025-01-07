module 0xbbdea5a9b040c22dbe8e9200a4810eba19e5339e19bcb0691cdffec3d35344f2::blockbolt {
    struct MerchantOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct MerchnatFee<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

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

    public entry fun collecttion<T0>(arg0: &MerchantOwnerCap, arg1: &mut MerchnatFee<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MerchantOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MerchantOwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initializer<T0>(arg0: &MerchantOwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MerchnatFee<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<MerchnatFee<T0>>(v0);
    }

    public entry fun send<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut MerchnatFee<T0>, arg2: 0x1::string::String, arg3: address, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= 0, 0);
        let v0 = 0x1::string::utf8(b"Powered By BlockBolt");
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, arg4 * 100000 / 1000000000, arg6)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg3);
        let v1 = MerchantDetails{
            id            : 0x2::object::new(arg6),
            amount        : arg4,
            merchant_id   : arg5,
            protocol_name : v0,
            merchant_name : arg2,
        };
        let v2 = MerchantDetailsEvent{
            amount        : arg4,
            merchant_id   : arg5,
            protocol_name : v0,
            merchant_name : arg2,
        };
        0x2::event::emit<MerchantDetailsEvent>(v2);
        0x2::transfer::transfer<MerchantDetails>(v1, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

