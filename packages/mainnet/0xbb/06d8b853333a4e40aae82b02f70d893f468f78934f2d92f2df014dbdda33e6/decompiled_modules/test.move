module 0xbb06d8b853333a4e40aae82b02f70d893f468f78934f2d92f2df014dbdda33e6::test {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    public entry fun mint_t_coins(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(0x2::coin::mint<MYCOIN>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

