module 0xb50ad77d045236c8fed6d978eace6c32d4c5cee6c4029b5f6bc12e7e2479399e::central {
    struct CENTRAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CENTRAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CENTRAL>(arg0, 6, b"CENTRAL", b"Centralized Coin", x"54686520776f726c64e28099732066697273742063727970746f63757272656e6379207468617420676976657320796f75207a65726f20636f6e74726f6c20e2809420616e64207765206c696b652069742074686174207761792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Centralized_coin_logo_f720a4cd8a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CENTRAL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CENTRAL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

