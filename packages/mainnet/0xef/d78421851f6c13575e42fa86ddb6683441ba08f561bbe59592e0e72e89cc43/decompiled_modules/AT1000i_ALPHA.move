module 0xefd78421851f6c13575e42fa86ddb6683441ba08f561bbe59592e0e72e89cc43::AT1000i_ALPHA {
    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct AT1000I_ALPHA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AT1000I_ALPHA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AT1000I_ALPHA>>(0x2::coin::mint<AT1000I_ALPHA>(arg0, arg1, arg3), arg2);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    fun init(arg0: AT1000I_ALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AT1000I_ALPHA>(arg0, 9, b"AT1000i Alpha", b"AT1000ia", b"AT1000i Alpha Token for the AT1000i AI/ML Auto Trader protocol built by Minith Labs", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AT1000I_ALPHA>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AT1000I_ALPHA>>(v1, v2);
    }

    public fun mint_initial_supply(arg0: &mut 0x2::coin::TreasuryCap<AT1000I_ALPHA>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xe39d3415072c78f6734135dd6faa1d0d0b62a1a378701a26dc8d38b9e96b85b2;
        0x2::transfer::public_transfer<0x2::coin::Coin<AT1000I_ALPHA>>(0x2::coin::mint<AT1000I_ALPHA>(arg0, 1000000000000000, arg1), v0);
        let v1 = MintEvent{
            amount    : 1000000000000000,
            recipient : v0,
        };
        0x2::event::emit<MintEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

