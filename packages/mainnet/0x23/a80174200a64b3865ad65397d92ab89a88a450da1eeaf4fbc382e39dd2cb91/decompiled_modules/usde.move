module 0x23a80174200a64b3865ad65397d92ab89a88a450da1eeaf4fbc382e39dd2cb91::usde {
    struct USDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDE>(arg0, 6, b"USDE", b"USDE", b"USDE for test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDE>>(v1);
        0x2::coin::mint_and_transfer<USDE>(&mut v2, 10000000000000000, @0x91146573f34bae3dc0cd7eb5f4c33ec1e179106cc3cb648e33cd4891e519800b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

