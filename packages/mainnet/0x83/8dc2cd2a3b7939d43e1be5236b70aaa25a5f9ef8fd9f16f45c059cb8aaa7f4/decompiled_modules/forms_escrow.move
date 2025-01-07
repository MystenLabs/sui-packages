module 0x838dc2cd2a3b7939d43e1be5236b70aaa25a5f9ef8fd9f16f45c059cb8aaa7f4::forms_escrow {
    struct Form has key {
        id: 0x2::object::UID,
        formId: 0x1::string::String,
        budget: u64,
        cost_per_respose: u64,
        end_date: u64,
        name: 0x1::string::String,
        status: u64,
        wallet_address: address,
        funds_to_distribute: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun create(arg0: u64, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Form{
            id                  : 0x2::object::new(arg8),
            formId              : 0x1::string::utf8(arg1),
            budget              : arg0,
            cost_per_respose    : arg2,
            end_date            : arg4,
            name                : 0x1::string::utf8(arg5),
            status              : arg6,
            wallet_address      : arg7,
            funds_to_distribute : 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg3), arg0),
        };
        0x2::transfer::share_object<Form>(v0);
    }

    public fun reward(arg0: u64, arg1: &mut Form, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 0);
        if (0x2::balance::value<0x2::sui::SUI>(&arg1.funds_to_distribute) >= arg1.cost_per_respose) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.funds_to_distribute, arg1.cost_per_respose, arg3), arg2);
        } else {
            arg1.status = 2;
            arg1.end_date = arg0;
        };
    }

    // decompiled from Move bytecode v6
}

