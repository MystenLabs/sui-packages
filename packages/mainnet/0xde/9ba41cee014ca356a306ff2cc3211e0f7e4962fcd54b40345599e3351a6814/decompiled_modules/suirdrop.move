module 0xde9ba41cee014ca356a306ff2cc3211e0f7e4962fcd54b40345599e3351a6814::suirdrop {
    struct AirdropEvent has copy, drop {
        id: vector<u8>,
        coin: 0x1::ascii::String,
        recipient_addresses: vector<address>,
        recipient_amount: vector<u64>,
    }

    public entry fun create_airdrop<T0>(arg0: vector<address>, arg1: vector<u64>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0)) {
            let v1 = &mut arg2;
            let v2 = split_airdrop_coin_internel<T0>(v1, *0x1::vector::borrow<u64>(&arg1, v0), arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, *0x1::vector::borrow<address>(&arg0, v0));
            v0 = v0 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg3));
        let v3 = 0x1::type_name::get<T0>();
        let v4 = AirdropEvent{
            id                  : *0x2::tx_context::digest(arg3),
            coin                : *0x1::type_name::borrow_string(&v3),
            recipient_addresses : arg0,
            recipient_amount    : arg1,
        };
        0x2::event::emit<AirdropEvent>(v4);
    }

    fun split_airdrop_coin_internel<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

