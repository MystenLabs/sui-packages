module 0xbc804d4f96bbb6ab9b5cf6b883cd669408b50a8fd2449b57f7f199a42e9ea227::bdolph {
    struct BDOLPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDOLPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDOLPH>(arg0, 6, b"BDOLPH", b"Bread Dolphin", b"The dolphin is made of bread.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bread_dolph_4cc83dfd6e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDOLPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDOLPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

