module 0x65c8f56afbf1ab08717998645bc38d7e753c1e77d7e42ca258883ee2af3a8f28::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    struct MinterStorage has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MinterStorage{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<CORE>(arg0, arg1),
        };
        0x2::transfer::transfer<MinterStorage>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_nemo(arg0: &mut 0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMOStorage, arg1: &MinterStorage, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::NEMO>>(0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo::mint(arg0, &arg1.publisher, (arg2 as u64), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

