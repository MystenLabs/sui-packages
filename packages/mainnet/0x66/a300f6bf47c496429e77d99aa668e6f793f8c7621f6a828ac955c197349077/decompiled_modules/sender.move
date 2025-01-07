module 0x66a300f6bf47c496429e77d99aa668e6f793f8c7621f6a828ac955c197349077::sender {
    struct Admin has key {
        id: 0x2::object::UID,
        admin: address,
    }

    public entry fun change_admin(arg0: &mut Admin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.admin = arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Admin>(v0);
    }

    public entry fun multi_send(arg0: vector<address>, arg1: vector<u64>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg0) == 0x1::vector::length<u64>(&arg1), 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, *0x1::vector::borrow<u64>(&arg1, v0), arg3), *0x1::vector::borrow<address>(&arg0, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun send(arg0: address, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, arg1, arg3), arg0);
    }

    // decompiled from Move bytecode v6
}

