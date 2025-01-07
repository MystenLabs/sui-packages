module 0x923395a4a920290c69f4802b9ecc60f2ab8fc58cd94727fe2d85ef22140533f5::swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bank has key {
        id: 0x2::object::UID,
        movecoin: 0x2::balance::Balance<0x839c8bd56fdb7ea8668884079cb7c0bd9ae2fe62a9a016bed3e5c8d60f1b2e2b::movecoin::MOVECOIN>,
        movefaucetcoin: 0x2::balance::Balance<0x620ccf7fdfcff7b8cbc136097552bd76aa12d09d1d2d4dd98d3633af990dc3::movefaucetcoin::MOVEFAUCETCOIN>,
    }

    public entry fun deposit_movecoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x839c8bd56fdb7ea8668884079cb7c0bd9ae2fe62a9a016bed3e5c8d60f1b2e2b::movecoin::MOVECOIN>) {
        0x2::balance::join<0x839c8bd56fdb7ea8668884079cb7c0bd9ae2fe62a9a016bed3e5c8d60f1b2e2b::movecoin::MOVECOIN>(&mut arg0.movecoin, 0x2::coin::into_balance<0x839c8bd56fdb7ea8668884079cb7c0bd9ae2fe62a9a016bed3e5c8d60f1b2e2b::movecoin::MOVECOIN>(arg1));
    }

    public entry fun deposit_movefaucetcoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x620ccf7fdfcff7b8cbc136097552bd76aa12d09d1d2d4dd98d3633af990dc3::movefaucetcoin::MOVEFAUCETCOIN>) {
        0x2::balance::join<0x620ccf7fdfcff7b8cbc136097552bd76aa12d09d1d2d4dd98d3633af990dc3::movefaucetcoin::MOVEFAUCETCOIN>(&mut arg0.movefaucetcoin, 0x2::coin::into_balance<0x620ccf7fdfcff7b8cbc136097552bd76aa12d09d1d2d4dd98d3633af990dc3::movefaucetcoin::MOVEFAUCETCOIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id             : 0x2::object::new(arg0),
            movecoin       : 0x2::balance::zero<0x839c8bd56fdb7ea8668884079cb7c0bd9ae2fe62a9a016bed3e5c8d60f1b2e2b::movecoin::MOVECOIN>(),
            movefaucetcoin : 0x2::balance::zero<0x620ccf7fdfcff7b8cbc136097552bd76aa12d09d1d2d4dd98d3633af990dc3::movefaucetcoin::MOVEFAUCETCOIN>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_movecoin_to_movefaucetcoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x839c8bd56fdb7ea8668884079cb7c0bd9ae2fe62a9a016bed3e5c8d60f1b2e2b::movecoin::MOVECOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x839c8bd56fdb7ea8668884079cb7c0bd9ae2fe62a9a016bed3e5c8d60f1b2e2b::movecoin::MOVECOIN>(&mut arg0.movecoin, 0x2::coin::into_balance<0x839c8bd56fdb7ea8668884079cb7c0bd9ae2fe62a9a016bed3e5c8d60f1b2e2b::movecoin::MOVECOIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x620ccf7fdfcff7b8cbc136097552bd76aa12d09d1d2d4dd98d3633af990dc3::movefaucetcoin::MOVEFAUCETCOIN>>(0x2::coin::from_balance<0x620ccf7fdfcff7b8cbc136097552bd76aa12d09d1d2d4dd98d3633af990dc3::movefaucetcoin::MOVEFAUCETCOIN>(0x2::balance::split<0x620ccf7fdfcff7b8cbc136097552bd76aa12d09d1d2d4dd98d3633af990dc3::movefaucetcoin::MOVEFAUCETCOIN>(&mut arg0.movefaucetcoin, 0x2::coin::value<0x839c8bd56fdb7ea8668884079cb7c0bd9ae2fe62a9a016bed3e5c8d60f1b2e2b::movecoin::MOVECOIN>(&arg1) * 2), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_movefaucetcoin_to_movecoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x620ccf7fdfcff7b8cbc136097552bd76aa12d09d1d2d4dd98d3633af990dc3::movefaucetcoin::MOVEFAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x620ccf7fdfcff7b8cbc136097552bd76aa12d09d1d2d4dd98d3633af990dc3::movefaucetcoin::MOVEFAUCETCOIN>(&mut arg0.movefaucetcoin, 0x2::coin::into_balance<0x620ccf7fdfcff7b8cbc136097552bd76aa12d09d1d2d4dd98d3633af990dc3::movefaucetcoin::MOVEFAUCETCOIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x839c8bd56fdb7ea8668884079cb7c0bd9ae2fe62a9a016bed3e5c8d60f1b2e2b::movecoin::MOVECOIN>>(0x2::coin::from_balance<0x839c8bd56fdb7ea8668884079cb7c0bd9ae2fe62a9a016bed3e5c8d60f1b2e2b::movecoin::MOVECOIN>(0x2::balance::split<0x839c8bd56fdb7ea8668884079cb7c0bd9ae2fe62a9a016bed3e5c8d60f1b2e2b::movecoin::MOVECOIN>(&mut arg0.movecoin, 0x2::coin::value<0x620ccf7fdfcff7b8cbc136097552bd76aa12d09d1d2d4dd98d3633af990dc3::movefaucetcoin::MOVEFAUCETCOIN>(&arg1) / 2), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_movecoin(arg0: &mut Bank, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x839c8bd56fdb7ea8668884079cb7c0bd9ae2fe62a9a016bed3e5c8d60f1b2e2b::movecoin::MOVECOIN>>(0x2::coin::from_balance<0x839c8bd56fdb7ea8668884079cb7c0bd9ae2fe62a9a016bed3e5c8d60f1b2e2b::movecoin::MOVECOIN>(0x2::balance::split<0x839c8bd56fdb7ea8668884079cb7c0bd9ae2fe62a9a016bed3e5c8d60f1b2e2b::movecoin::MOVECOIN>(&mut arg0.movecoin, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_movefaucetcoin(arg0: &mut Bank, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x620ccf7fdfcff7b8cbc136097552bd76aa12d09d1d2d4dd98d3633af990dc3::movefaucetcoin::MOVEFAUCETCOIN>>(0x2::coin::from_balance<0x620ccf7fdfcff7b8cbc136097552bd76aa12d09d1d2d4dd98d3633af990dc3::movefaucetcoin::MOVEFAUCETCOIN>(0x2::balance::split<0x620ccf7fdfcff7b8cbc136097552bd76aa12d09d1d2d4dd98d3633af990dc3::movefaucetcoin::MOVEFAUCETCOIN>(&mut arg0.movefaucetcoin, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

