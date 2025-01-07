module 0xc77f8afb0f6231b78a84f989bd0390f54ab60435ec5ad13d1fc6fa7e1fe8b6cc::pres {
    struct PRES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRES>(arg0, 9, b"PRES", b"Pepe Resistance Sui", b"Introducing \"Pepe Resistance\" on the Sui Network. Sui Network's version of the infamous pepe meme. Join us in promoting freedom and SUI adoption worldwide. X: https://x.com/peperesistances Telegram: https://t.me/peperesistance Website: https://suipeperesistance.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PRES>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRES>>(v1);
    }

    // decompiled from Move bytecode v6
}

