module 0xcbc73a8e9c9573d183395c0b1a5ac02566151ddf9edc939cc4f489dc0cbae1e::loncat {
    struct LONCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONCAT>(arg0, 6, b"LONCAT", b"Lonely Cat", x"48692c20496d204c6f6e656c79204361742e20546865206c6f6e656c696573742063617420696e2074686520776f726c642e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016448_3f970dabb2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LONCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

