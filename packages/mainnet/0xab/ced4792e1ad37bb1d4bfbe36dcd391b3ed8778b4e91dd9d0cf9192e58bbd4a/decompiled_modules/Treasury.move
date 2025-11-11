module 0xabced4792e1ad37bb1d4bfbe36dcd391b3ed8778b4e91dd9d0cf9192e58bbd4a::Treasury {
    struct Treasury has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<0xabced4792e1ad37bb1d4bfbe36dcd391b3ed8778b4e91dd9d0cf9192e58bbd4a::XYLEG::XYLEG>,
        vault: 0x2::balance::Balance<0xabced4792e1ad37bb1d4bfbe36dcd391b3ed8778b4e91dd9d0cf9192e58bbd4a::XYLEG::XYLEG>,
        admin: 0x1::option::Option<address>,
    }

    public entry fun accept_bootstrap(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg1);
    }

    public entry fun distribute(arg0: &mut Treasury, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xabced4792e1ad37bb1d4bfbe36dcd391b3ed8778b4e91dd9d0cf9192e58bbd4a::XYLEG::XYLEG>>(0x2::coin::from_balance<0xabced4792e1ad37bb1d4bfbe36dcd391b3ed8778b4e91dd9d0cf9192e58bbd4a::XYLEG::XYLEG>(0x2::balance::split<0xabced4792e1ad37bb1d4bfbe36dcd391b3ed8778b4e91dd9d0cf9192e58bbd4a::XYLEG::XYLEG>(&mut arg0.vault, arg2), arg3), arg1);
    }

    public entry fun finalize(arg0: &mut Treasury) {
        assert!(0x1::option::is_some<address>(&arg0.admin), 1001);
        arg0.admin = 0x1::option::none<address>();
    }

    // decompiled from Move bytecode v6
}

