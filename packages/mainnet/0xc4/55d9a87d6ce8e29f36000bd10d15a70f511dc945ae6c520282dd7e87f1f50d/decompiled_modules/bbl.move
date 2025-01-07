module 0xc455d9a87d6ce8e29f36000bd10d15a70f511dc945ae6c520282dd7e87f1f50d::bbl {
    struct BBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBL>(arg0, 6, b"BBL", b"SUI Bubl", x"427562626c696e67206f6e200a405375694e6574776f726b0a20746f206d616b65206672656e73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BOB_907a148614.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

