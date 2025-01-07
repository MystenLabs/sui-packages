module 0x81ab36916b0a2adc9b217027ad660481ff36170ee0ed2c5771952ad0afa2a8dc::taisaigame {
    struct Game has key {
        id: 0x2::object::UID,
        val: 0x2::balance::Balance<0x4123c8ba91d71254de2bc6de82ef9eef0507c3cbc3d8544e3ad71ee8474e65f7::ajin_faucet_coin::AJIN_FAUCET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0x4123c8ba91d71254de2bc6de82ef9eef0507c3cbc3d8544e3ad71ee8474e65f7::ajin_faucet_coin::AJIN_FAUCET_COIN>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x4123c8ba91d71254de2bc6de82ef9eef0507c3cbc3d8544e3ad71ee8474e65f7::ajin_faucet_coin::AJIN_FAUCET_COIN>(&mut arg0.val, 0x2::coin::into_balance<0x4123c8ba91d71254de2bc6de82ef9eef0507c3cbc3d8544e3ad71ee8474e65f7::ajin_faucet_coin::AJIN_FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id  : 0x2::object::new(arg0),
            val : 0x2::balance::zero<0x4123c8ba91d71254de2bc6de82ef9eef0507c3cbc3d8544e3ad71ee8474e65f7::ajin_faucet_coin::AJIN_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Game, arg1: bool, arg2: 0x2::coin::Coin<0x4123c8ba91d71254de2bc6de82ef9eef0507c3cbc3d8544e3ad71ee8474e65f7::ajin_faucet_coin::AJIN_FAUCET_COIN>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x4123c8ba91d71254de2bc6de82ef9eef0507c3cbc3d8544e3ad71ee8474e65f7::ajin_faucet_coin::AJIN_FAUCET_COIN>(&arg2);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::balance::value<0x4123c8ba91d71254de2bc6de82ef9eef0507c3cbc3d8544e3ad71ee8474e65f7::ajin_faucet_coin::AJIN_FAUCET_COIN>(&arg0.val);
        if (v2 < v0) {
            abort 1
        };
        if (v2 < v0 * 10) {
            abort 2
        };
        let v3 = 0x2::random::new_generator(arg3, arg4);
        if (arg1 == 0x2::random::generate_bool(&mut v3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4123c8ba91d71254de2bc6de82ef9eef0507c3cbc3d8544e3ad71ee8474e65f7::ajin_faucet_coin::AJIN_FAUCET_COIN>>(0x2::coin::from_balance<0x4123c8ba91d71254de2bc6de82ef9eef0507c3cbc3d8544e3ad71ee8474e65f7::ajin_faucet_coin::AJIN_FAUCET_COIN>(0x2::balance::split<0x4123c8ba91d71254de2bc6de82ef9eef0507c3cbc3d8544e3ad71ee8474e65f7::ajin_faucet_coin::AJIN_FAUCET_COIN>(&mut arg0.val, v0), arg4), v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4123c8ba91d71254de2bc6de82ef9eef0507c3cbc3d8544e3ad71ee8474e65f7::ajin_faucet_coin::AJIN_FAUCET_COIN>>(arg2, v1);
        } else {
            0x2::balance::join<0x4123c8ba91d71254de2bc6de82ef9eef0507c3cbc3d8544e3ad71ee8474e65f7::ajin_faucet_coin::AJIN_FAUCET_COIN>(&mut arg0.val, 0x2::coin::into_balance<0x4123c8ba91d71254de2bc6de82ef9eef0507c3cbc3d8544e3ad71ee8474e65f7::ajin_faucet_coin::AJIN_FAUCET_COIN>(arg2));
        };
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4123c8ba91d71254de2bc6de82ef9eef0507c3cbc3d8544e3ad71ee8474e65f7::ajin_faucet_coin::AJIN_FAUCET_COIN>>(0x2::coin::from_balance<0x4123c8ba91d71254de2bc6de82ef9eef0507c3cbc3d8544e3ad71ee8474e65f7::ajin_faucet_coin::AJIN_FAUCET_COIN>(0x2::balance::split<0x4123c8ba91d71254de2bc6de82ef9eef0507c3cbc3d8544e3ad71ee8474e65f7::ajin_faucet_coin::AJIN_FAUCET_COIN>(&mut arg1.val, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

