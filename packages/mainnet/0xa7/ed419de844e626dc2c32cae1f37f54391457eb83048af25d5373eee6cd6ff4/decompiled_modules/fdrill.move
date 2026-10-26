module 0xa7ed419de844e626dc2c32cae1f37f54391457eb83048af25d5373eee6cd6ff4::fdrill {
    struct FDRILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDRILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FDRILL>(arg0, 9, 0x1::string::utf8(b"FDRILL"), 0x1::string::utf8(b"Factory Drill"), 0x1::string::utf8(b"Throwaway test coin for a bridge rehearsal. No value."), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<FDRILL>>(0x2::coin::mint<FDRILL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::coin_registry::finalize_and_delete_metadata_cap<FDRILL>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDRILL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

