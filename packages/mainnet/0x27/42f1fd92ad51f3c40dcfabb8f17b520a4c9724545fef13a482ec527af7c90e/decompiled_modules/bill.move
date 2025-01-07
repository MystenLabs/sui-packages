module 0x2742f1fd92ad51f3c40dcfabb8f17b520a4c9724545fef13a482ec527af7c90e::bill {
    struct BILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILL>(arg0, 6, b"BILL", b"Bill", b"I am Metamask Fox. my name is bill.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/670a1964c45128c65068cf42_1728715108_21218cdda8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

