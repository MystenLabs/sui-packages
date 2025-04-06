module 0x7e6e59a887d81a77215a2790852dca62c36920d607797fb066a307fba0602da0::real {
    struct REAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: REAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REAL>(arg0, 9, b"REAL", b"Conor McGregor", b"The $REAL token is the native cryptocurrency of the RWG platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sun9-36.userapi.com/impg/Dlys8Ilwr-kSuCBNMQ1wp6SeHL01gkEr8Dzeew/iC1URgCOIpg.jpg?size=446x420&quality=95&sign=80dedc06f4caed8c2a85381b5068e345&type=album")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<REAL>>(0x2::coin::mint<REAL>(&mut v2, 2000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<REAL>>(v2);
    }

    // decompiled from Move bytecode v6
}

