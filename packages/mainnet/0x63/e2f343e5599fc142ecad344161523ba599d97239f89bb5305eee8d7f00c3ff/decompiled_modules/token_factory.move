module 0x63e2f343e5599fc142ecad344161523ba599d97239f89bb5305eee8d7f00c3ff::token_factory {
    struct Factory has store, key {
        id: 0x2::object::UID,
        total_tokens_created: u64,
    }

    public fun get_total_tokens_created(arg0: &Factory) : u64 {
        arg0.total_tokens_created
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id                   : 0x2::object::new(arg0),
            total_tokens_created : 0,
        };
        0x2::transfer::share_object<Factory>(v0);
    }

    entry fun pay_and_record(arg0: &mut Factory, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u8, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 200000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0x3bc44c92f693a7e02ac587b6c221abe3084285f47c271e0d13b4d4599b22788);
        arg0.total_tokens_created = arg0.total_tokens_created + 1;
    }

    // decompiled from Move bytecode v6
}

