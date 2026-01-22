module 0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::verification_fees {
    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::shock::SHOCK>,
        admin: address,
    }

    public entry fun collect_fee(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::shock::SHOCK>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::shock::SHOCK>(&arg1) >= 10000000000, 1);
        0x2::balance::join<0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::shock::SHOCK>(&mut arg0.balance, 0x2::coin::into_balance<0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::shock::SHOCK>(arg1));
    }

    public fun get_treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::shock::SHOCK>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::shock::SHOCK>(),
            admin   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public entry fun update_admin(arg0: &mut Treasury, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.admin = arg1;
    }

    public entry fun withdraw_treasury(arg0: &mut Treasury, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::shock::SHOCK>>(0x2::coin::from_balance<0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::shock::SHOCK>(0x2::balance::split<0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::shock::SHOCK>(&mut arg0.balance, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

