module 0x753eeb4f9a7971ee49bf16ed4f94986fbc7b234e7264140dbc1bf971d157a2a0::swap {
    struct Pool has store, key {
        id: 0x2::object::UID,
        coinA: 0x2::balance::Balance<0xf4842690b5e5d10bdbcc9c568cc809f9cedcb14654af9ff129e1248558d56cf3::yun::YUN>,
        coinB: 0x2::balance::Balance<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>,
    }

    public entry fun DepositA(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0xf4842690b5e5d10bdbcc9c568cc809f9cedcb14654af9ff129e1248558d56cf3::yun::YUN>, arg2: u64) {
        assert!(0x2::coin::value<0xf4842690b5e5d10bdbcc9c568cc809f9cedcb14654af9ff129e1248558d56cf3::yun::YUN>(arg1) >= arg2, 100);
        0x2::balance::join<0xf4842690b5e5d10bdbcc9c568cc809f9cedcb14654af9ff129e1248558d56cf3::yun::YUN>(&mut arg0.coinA, 0x2::balance::split<0xf4842690b5e5d10bdbcc9c568cc809f9cedcb14654af9ff129e1248558d56cf3::yun::YUN>(0x2::coin::balance_mut<0xf4842690b5e5d10bdbcc9c568cc809f9cedcb14654af9ff129e1248558d56cf3::yun::YUN>(arg1), arg2));
    }

    public entry fun DepositB(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>, arg2: u64) {
        assert!(0x2::coin::value<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(arg1) >= arg2, 100);
        0x2::balance::join<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(&mut arg0.coinB, 0x2::balance::split<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(0x2::coin::balance_mut<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(arg1), arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id    : 0x2::object::new(arg0),
            coinA : 0x2::balance::zero<0xf4842690b5e5d10bdbcc9c568cc809f9cedcb14654af9ff129e1248558d56cf3::yun::YUN>(),
            coinB : 0x2::balance::zero<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun swap_A_to_B(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0xf4842690b5e5d10bdbcc9c568cc809f9cedcb14654af9ff129e1248558d56cf3::yun::YUN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0xf4842690b5e5d10bdbcc9c568cc809f9cedcb14654af9ff129e1248558d56cf3::yun::YUN>(&arg0.coinA);
        let v1 = 0x2::balance::value<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(&arg0.coinB);
        let v2 = if (arg2 > 0) {
            if (v1 > 0) {
                v0 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 100);
        let v3 = arg2 * v1 / (v0 + arg2);
        assert!(v3 > 0 && v3 < v1, 100);
        0x2::balance::join<0xf4842690b5e5d10bdbcc9c568cc809f9cedcb14654af9ff129e1248558d56cf3::yun::YUN>(&mut arg0.coinA, 0x2::balance::split<0xf4842690b5e5d10bdbcc9c568cc809f9cedcb14654af9ff129e1248558d56cf3::yun::YUN>(0x2::coin::balance_mut<0xf4842690b5e5d10bdbcc9c568cc809f9cedcb14654af9ff129e1248558d56cf3::yun::YUN>(arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>>(0x2::coin::take<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(&mut arg0.coinB, v3, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_B_to_A(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0xf4842690b5e5d10bdbcc9c568cc809f9cedcb14654af9ff129e1248558d56cf3::yun::YUN>(&arg0.coinA);
        let v1 = 0x2::balance::value<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(&arg0.coinB);
        let v2 = if (arg2 > 0) {
            if (v1 > 0) {
                v0 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 100);
        let v3 = arg2 * v0 / (v1 + arg2);
        assert!(v3 > 0 && v3 < v0, 100);
        0x2::balance::join<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(&mut arg0.coinB, 0x2::balance::split<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(0x2::coin::balance_mut<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf4842690b5e5d10bdbcc9c568cc809f9cedcb14654af9ff129e1248558d56cf3::yun::YUN>>(0x2::coin::take<0xf4842690b5e5d10bdbcc9c568cc809f9cedcb14654af9ff129e1248558d56cf3::yun::YUN>(&mut arg0.coinA, v3, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

