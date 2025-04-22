module 0x75ec28ff316f64ec93aeb0463a3ca14ad5d9900d96a76dde1d8e594d4de4db1::posei {
    struct POSEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSEI>(arg0, 6, b"POSEI", b"Poseidon", x"496e2074686520657665722d6368616e67696e67207469646573206f662063727970746f2c20506f736569646f6e207374616e64732074616c6c2c206775617264696e672074686520747275652062656c6965766572732e0a5768656e2066616b652077617665732063726173682c20746865207265616c206f6e657320726973652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo1_f996ca0759.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

