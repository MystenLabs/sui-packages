module 0x3891b30c5e9000f9015f4cf34c8cef0076ddd94e3e17fa2df575e420cdb2d1e6::storage_rebate_optimized {
    struct RebateObject has key {
        id: 0x2::object::UID,
        data: vector<u8>,
    }

    fun create_rebate_object(arg0: &mut 0x2::tx_context::TxContext) : RebateObject {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 49152) {
            0x1::vector::push_back<u8>(&mut v0, ((v1 % 256) as u8));
            v1 = v1 + 1;
        };
        RebateObject{
            id   : 0x2::object::new(arg0),
            data : v0,
        }
    }

    fun delete_rebate_object(arg0: RebateObject) {
        let RebateObject {
            id   : v0,
            data : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun storage_rebate_optimized_arbitrage(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 10) {
            let v1 = create_rebate_object(arg1);
            delete_rebate_object(v1);
            v0 = v0 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::zero<0x2::sui::SUI>(arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun test_deployment(arg0: &mut 0x2::tx_context::TxContext) {
        delete_rebate_object(create_rebate_object(arg0));
    }

    // decompiled from Move bytecode v6
}

