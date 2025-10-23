module 0xe9cdd66e33dc95a96cbf0e9ac4ea5fe857a79ea3fb429b835fb669d7c71f7057::suispawn {
    struct SUISPAWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISPAWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISPAWN>(arg0, 9, b"SUISPAWN", b"SUISPAWN", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1761218420/sui_tokens/umtgwur3hchxamba3wtd.gif"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISPAWN>>(0x2::coin::mint<SUISPAWN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUISPAWN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISPAWN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

