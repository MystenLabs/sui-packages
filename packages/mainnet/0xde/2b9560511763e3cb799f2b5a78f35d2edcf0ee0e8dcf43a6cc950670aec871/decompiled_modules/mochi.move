module 0xde2b9560511763e3cb799f2b5a78f35d2edcf0ee0e8dcf43a6cc950670aec871::mochi {
    struct MOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCHI>(arg0, 6, b"MOCHI", b"", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://api.movepump.com/uploads/Mochi_Coin_57f56a35bc.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOCHI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCHI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOCHI>>(v2);
    }

    // decompiled from Move bytecode v6
}

