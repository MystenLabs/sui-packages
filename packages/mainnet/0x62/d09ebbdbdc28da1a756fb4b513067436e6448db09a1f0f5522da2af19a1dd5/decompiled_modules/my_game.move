module 0x62d09ebbdbdc28da1a756fb4b513067436e6448db09a1f0f5522da2af19a1dd5::my_game {
    struct Dr1am1game has key {
        id: 0x2::object::UID,
        amt: 0x2::balance::Balance<0xf08f1248c39feda7e0cd2ee6b3a29218a5ae66af4da11fa7ddf341f770e033a7::dr1am1faucet::DR1AM1FAUCET>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_DR1AM1FAUCET(arg0: &mut Dr1am1game, arg1: 0x2::coin::Coin<0xf08f1248c39feda7e0cd2ee6b3a29218a5ae66af4da11fa7ddf341f770e033a7::dr1am1faucet::DR1AM1FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xf08f1248c39feda7e0cd2ee6b3a29218a5ae66af4da11fa7ddf341f770e033a7::dr1am1faucet::DR1AM1FAUCET>(&mut arg0.amt, 0x2::coin::into_balance<0xf08f1248c39feda7e0cd2ee6b3a29218a5ae66af4da11fa7ddf341f770e033a7::dr1am1faucet::DR1AM1FAUCET>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Dr1am1game{
            id  : 0x2::object::new(arg0),
            amt : 0x2::balance::zero<0xf08f1248c39feda7e0cd2ee6b3a29218a5ae66af4da11fa7ddf341f770e033a7::dr1am1faucet::DR1AM1FAUCET>(),
        };
        0x2::transfer::share_object<Dr1am1game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Dr1am1game, arg1: &0x2::random::Random, arg2: bool, arg3: 0x2::coin::Coin<0xf08f1248c39feda7e0cd2ee6b3a29218a5ae66af4da11fa7ddf341f770e033a7::dr1am1faucet::DR1AM1FAUCET>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg1, arg4);
        let v1 = 0x2::coin::value<0xf08f1248c39feda7e0cd2ee6b3a29218a5ae66af4da11fa7ddf341f770e033a7::dr1am1faucet::DR1AM1FAUCET>(&arg3);
        assert!(0x2::balance::value<0xf08f1248c39feda7e0cd2ee6b3a29218a5ae66af4da11fa7ddf341f770e033a7::dr1am1faucet::DR1AM1FAUCET>(&arg0.amt) >= v1 * 10, 0);
        if (arg2 == 0x2::random::generate_bool(&mut v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf08f1248c39feda7e0cd2ee6b3a29218a5ae66af4da11fa7ddf341f770e033a7::dr1am1faucet::DR1AM1FAUCET>>(0x2::coin::from_balance<0xf08f1248c39feda7e0cd2ee6b3a29218a5ae66af4da11fa7ddf341f770e033a7::dr1am1faucet::DR1AM1FAUCET>(0x2::balance::split<0xf08f1248c39feda7e0cd2ee6b3a29218a5ae66af4da11fa7ddf341f770e033a7::dr1am1faucet::DR1AM1FAUCET>(&mut arg0.amt, v1), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf08f1248c39feda7e0cd2ee6b3a29218a5ae66af4da11fa7ddf341f770e033a7::dr1am1faucet::DR1AM1FAUCET>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xf08f1248c39feda7e0cd2ee6b3a29218a5ae66af4da11fa7ddf341f770e033a7::dr1am1faucet::DR1AM1FAUCET>(&mut arg0.amt, 0x2::coin::into_balance<0xf08f1248c39feda7e0cd2ee6b3a29218a5ae66af4da11fa7ddf341f770e033a7::dr1am1faucet::DR1AM1FAUCET>(arg3));
        };
    }

    public entry fun remove_DR1AM1FAUCET(arg0: &AdminCap, arg1: &mut Dr1am1game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf08f1248c39feda7e0cd2ee6b3a29218a5ae66af4da11fa7ddf341f770e033a7::dr1am1faucet::DR1AM1FAUCET>>(0x2::coin::from_balance<0xf08f1248c39feda7e0cd2ee6b3a29218a5ae66af4da11fa7ddf341f770e033a7::dr1am1faucet::DR1AM1FAUCET>(0x2::balance::split<0xf08f1248c39feda7e0cd2ee6b3a29218a5ae66af4da11fa7ddf341f770e033a7::dr1am1faucet::DR1AM1FAUCET>(&mut arg1.amt, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

