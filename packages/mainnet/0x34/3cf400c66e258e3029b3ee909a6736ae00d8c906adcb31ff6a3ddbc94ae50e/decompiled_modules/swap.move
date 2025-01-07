module 0x343cf400c66e258e3029b3ee909a6736ae00d8c906adcb31ff6a3ddbc94ae50e::swap {
    struct Bank has key {
        id: 0x2::object::UID,
        coin1: 0x2::balance::Balance<0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_coin::MY_COIN>,
        coin2: 0x2::balance::Balance<0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_faucet_coin::MY_FAUCET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun deposit<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun deposit_coin1(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_coin::MY_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.coin1;
        deposit<0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_coin::MY_COIN>(v0, arg1);
    }

    public entry fun deposit_coin2(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_faucet_coin::MY_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.coin2;
        deposit<0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_faucet_coin::MY_FAUCET_COIN>(v0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id    : 0x2::object::new(arg0),
            coin1 : 0x2::balance::zero<0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_coin::MY_COIN>(),
            coin2 : 0x2::balance::zero<0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_faucet_coin::MY_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_1_2(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_coin::MY_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.coin1;
        deposit<0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_coin::MY_COIN>(v0, arg1);
        let v1 = &mut arg0.coin2;
        withdraw<0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_faucet_coin::MY_FAUCET_COIN>(v1, 0x2::coin::value<0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_coin::MY_COIN>(&arg1) * 73 / 10, arg2);
    }

    public entry fun swap_2_1(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_faucet_coin::MY_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.coin2;
        deposit<0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_faucet_coin::MY_FAUCET_COIN>(v0, arg1);
        let v1 = &mut arg0.coin1;
        withdraw<0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_coin::MY_COIN>(v1, 0x2::coin::value<0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_faucet_coin::MY_FAUCET_COIN>(&arg1) * 10 / 73, arg2);
    }

    fun withdraw<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_coin1(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.coin1;
        withdraw<0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_coin::MY_COIN>(v0, arg2, arg3);
    }

    public entry fun withdraw_coin2(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.coin2;
        withdraw<0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_faucet_coin::MY_FAUCET_COIN>(v0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

