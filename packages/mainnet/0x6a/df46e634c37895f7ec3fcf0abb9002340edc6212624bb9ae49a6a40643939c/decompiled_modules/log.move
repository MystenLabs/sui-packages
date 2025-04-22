module 0x6adf46e634c37895f7ec3fcf0abb9002340edc6212624bb9ae49a6a40643939c::log {
    struct LOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOG>(arg0, 9, b"LOG", b"LOG NAD", x"4c6f67204e616420697320636f6d6d756e697479204c6f756e6765204d6f6e6164732056696574204e616d0a4c696e6b206368616e6e656c3a2040686561646d6f6e6164766965746e616d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4c612549086c1b080104eb3dd674f58bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

