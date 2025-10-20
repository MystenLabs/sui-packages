module 0x9d1fda775fde698e31c2a0a50f10fbdf5dde6d8e3adabf7f38461d01bd61debc::faucet {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun claim(arg0: &mut 0x2::coin::TreasuryCap<0x9d1fda775fde698e31c2a0a50f10fbdf5dde6d8e3adabf7f38461d01bd61debc::my_token::MY_TOKEN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9d1fda775fde698e31c2a0a50f10fbdf5dde6d8e3adabf7f38461d01bd61debc::my_token::MY_TOKEN>>(0x2::coin::mint<0x9d1fda775fde698e31c2a0a50f10fbdf5dde6d8e3adabf7f38461d01bd61debc::my_token::MY_TOKEN>(arg0, 1000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint_to(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<0x9d1fda775fde698e31c2a0a50f10fbdf5dde6d8e3adabf7f38461d01bd61debc::my_token::MY_TOKEN>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9d1fda775fde698e31c2a0a50f10fbdf5dde6d8e3adabf7f38461d01bd61debc::my_token::MY_TOKEN>>(0x2::coin::mint<0x9d1fda775fde698e31c2a0a50f10fbdf5dde6d8e3adabf7f38461d01bd61debc::my_token::MY_TOKEN>(arg1, arg3, arg4), arg2);
    }

    // decompiled from Move bytecode v6
}

