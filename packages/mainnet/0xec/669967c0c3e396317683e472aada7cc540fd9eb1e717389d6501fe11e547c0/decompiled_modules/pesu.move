module 0xec669967c0c3e396317683e472aada7cc540fd9eb1e717389d6501fe11e547c0::pesu {
    struct PESU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESU>(arg0, 9, b"PESU", b"Pengsu", x"f09f90a7205468652066697273742063726f73732d657965642070656e6775696e206f6e2053756920f09f8c8a0a576164646c696e67206163726f737320746865206f6365616e7320f09f909f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3b360b5e83414148ac52c705e1a2765eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PESU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

