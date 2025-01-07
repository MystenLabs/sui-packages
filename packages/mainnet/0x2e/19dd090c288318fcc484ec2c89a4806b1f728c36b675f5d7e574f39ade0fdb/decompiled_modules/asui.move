module 0x2e19dd090c288318fcc484ec2c89a4806b1f728c36b675f5d7e574f39ade0fdb::asui {
    struct ASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUI>(arg0, 6, b"ASUI", b"aaa SUI", b"aaa aaa aaa aaa aaa aaa ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014003_efd6121c50.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

