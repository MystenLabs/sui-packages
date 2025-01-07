module 0x54c49241a164d857b473ddb26045b2fc8a70a0f84f1e49dbe6654b48f0bf57d5::blockbolt {
    struct MerchantOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct Treasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct FeeSettings has key {
        id: 0x2::object::UID,
        fee_percentage: u64,
    }

    struct FeeDeductEvent has copy, drop {
        amount: u64,
        merchant_id: u64,
    }

    struct MerchantDetails has store, key {
        id: 0x2::object::UID,
        amount: u64,
        merchant_id: u64,
        protocol_name: 0x1::string::String,
        merchant_name: 0x1::string::String,
    }

    struct PaymentTransferEvent has copy, drop {
        amount: u64,
        merchant_id: u64,
        merchant_address: address,
    }

    struct MerchantDetailsEvent has copy, drop {
        amount: u64,
        merchant_id: u64,
        protocol_name: 0x1::string::String,
        merchant_name: 0x1::string::String,
    }

    public entry fun collect_fees<T0>(arg0: &MerchantOwnerCap, arg1: &mut Treasury<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MerchantOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MerchantOwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize_fee(arg0: &MerchantOwnerCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 10000, 9223372410516930561);
        let v0 = FeeSettings{
            id             : 0x2::object::new(arg2),
            fee_percentage : arg1,
        };
        0x2::transfer::share_object<FeeSettings>(v0);
    }

    public fun initialize_treasury<T0>(arg0: &MerchantOwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public fun send<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Treasury<T0>, arg2: &FeeSettings, arg3: 0x1::string::String, arg4: address, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg5, 7);
        assert!(arg6 > 0, 8);
        let v0 = 0x1::string::utf8(b"Powered By BlockBolt");
        let v1 = arg5 * 10000 / 100;
        let v2 = arg5 * arg2.fee_percentage / 10000;
        let v3 = if (v2 > v1) {
            v1
        } else {
            v2
        };
        assert!(v3 <= arg5, 6);
        let v4 = FeeDeductEvent{
            amount      : v3,
            merchant_id : arg6,
        };
        0x2::event::emit<FeeDeductEvent>(v4);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, v3, arg7)));
        let v5 = PaymentTransferEvent{
            amount           : arg5 - v3,
            merchant_id      : arg6,
            merchant_address : arg4,
        };
        0x2::event::emit<PaymentTransferEvent>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg4);
        let v6 = MerchantDetails{
            id            : 0x2::object::new(arg7),
            amount        : arg5,
            merchant_id   : arg6,
            protocol_name : v0,
            merchant_name : arg3,
        };
        let v7 = MerchantDetailsEvent{
            amount        : arg5,
            merchant_id   : arg6,
            protocol_name : v0,
            merchant_name : arg3,
        };
        0x2::event::emit<MerchantDetailsEvent>(v7);
        0x2::transfer::transfer<MerchantDetails>(v6, 0x2::tx_context::sender(arg7));
    }

    public entry fun update_fee(arg0: &MerchantOwnerCap, arg1: &mut FeeSettings, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000, 9223372470646472705);
        arg1.fee_percentage = arg2;
    }

    // decompiled from Move bytecode v6
}

