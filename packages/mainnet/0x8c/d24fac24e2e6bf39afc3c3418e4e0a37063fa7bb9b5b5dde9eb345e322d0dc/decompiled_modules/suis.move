module 0x8cd24fac24e2e6bf39afc3c3418e4e0a37063fa7bb9b5b5dde9eb345e322d0dc::suis {
    struct SUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIS>(arg0, 6, b"SUIS", b"SUISPICIOUS MINDS", x"57652772652063617567687420696e206120747261700a492063616e27742077616c6b206f75740a426563617573652049206c6f766520796f7520746f6f206d7563682c20626162790a5768792063616e277420796f7520736565", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Elvis_Presley_Suspicious_Minds_1543866978_3b98cfce18.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

