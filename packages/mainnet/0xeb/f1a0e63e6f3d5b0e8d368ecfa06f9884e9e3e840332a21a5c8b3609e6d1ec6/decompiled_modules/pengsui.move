module 0xebf1a0e63e6f3d5b0e8d368ecfa06f9884e9e3e840332a21a5c8b3609e6d1ec6::pengsui {
    struct PENGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGSUI>(arg0, 9, b"Pengsui", b"Pengsu", x"20f09f90a7205468652066697273742063726f73732d657965642070656e6775696e206f6e2053756920f09f8c8a0a576164646c696e67206163726f737320746865206f6365616e7320f09f909f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6b22682938be263d8303a18b17ca1d89blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

