module 0x64b698562fc3fee6fa0ed7c09c5af73b43ba97822f6062da7645577fcd257e7b::bill {
    struct BILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILL>(arg0, 6, b"BILL", b"BILLIONAIRE", b"the easiest and fastest way to become a billionaire", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bilionaire_977429dbe8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

