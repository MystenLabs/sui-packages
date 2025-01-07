module 0xf74a927c2fe57604e0dd07907a9f62d74d7b5b1b466381abdbcd0ee18683d125::jarjar_ai_oracle {
    struct EventGenerate has copy, drop {
        prompt_data: 0x1::string::String,
        callback_data: 0x1::string::String,
        model_name: 0x1::string::String,
        sender: address,
        value: u64,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
        owner: address,
    }

    public fun generate(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0xf74a927c2fe57604e0dd07907a9f62d74d7b5b1b466381abdbcd0ee18683d125::price_model::PriceModel, arg5: &mut OwnerCap, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 0xf74a927c2fe57604e0dd07907a9f62d74d7b5b1b466381abdbcd0ee18683d125::price_model::get_price(arg4, &arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg5.owner);
        let v0 = EventGenerate{
            prompt_data   : arg0,
            callback_data : arg1,
            model_name    : arg2,
            sender        : 0x2::tx_context::sender(arg6),
            value         : 0x2::coin::value<0x2::sui::SUI>(&arg3),
        };
        0x2::event::emit<EventGenerate>(v0);
    }

    public fun get_owner_cap_address(arg0: &OwnerCap) : address {
        arg0.owner
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<OwnerCap>(v0);
    }

    // decompiled from Move bytecode v6
}

