module 0x6441e359ccc5a2dac3aaca40a3687fa186564eba2f1336a6cc97824b1210b1d0::cia {
    struct CIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIA>(arg0, 6, b"CIA", b"Clitoris Investigation Agency", b"Do you accept this mission?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cailogo_a8c36babf8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

