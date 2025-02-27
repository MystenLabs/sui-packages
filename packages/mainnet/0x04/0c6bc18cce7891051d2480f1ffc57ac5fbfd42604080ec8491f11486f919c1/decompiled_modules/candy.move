module 0x40c6bc18cce7891051d2480f1ffc57ac5fbfd42604080ec8491f11486f919c1::candy {
    struct CANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CANDY>(arg0, 6, b"CANDY", b"Candy by SuiAI", b"Your Kostas Krypton dog name Candy cryptographer & ethical hacker, co-founder @mysten_labs ex lead @meta", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_4621_629349686d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CANDY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANDY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

