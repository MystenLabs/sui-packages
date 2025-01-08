module 0xf25ff6ece5a5e6a3b2cc846cbf19763f1d3d7f6f8dac3d1dc6ba118789324856::penguin_7k {
    struct PENGUIN_7K has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUIN_7K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUIN_7K>(arg0, 9, b"Penguin_7K", b"Penguin", x"f09f90a7205468652066697273742063726f73732d657965642070656e6775696e206f6e2053756920f09f8c8a0a576164646c696e67206163726f737320746865206f6365616e7320f09f909f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a4aa63a802b7809a3961bac2c0414956blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGUIN_7K>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUIN_7K>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

