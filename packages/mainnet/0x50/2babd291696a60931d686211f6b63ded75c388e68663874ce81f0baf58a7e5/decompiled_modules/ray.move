module 0x502babd291696a60931d686211f6b63ded75c388e68663874ce81f0baf58a7e5::ray {
    struct RAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAY>(arg0, 6, b"RAY", b"RAY LAUNCH SOON(DONT BUY)", x"524159204c41554e434820534f4f4e2e20444f4e5420425559205448495320544f4b454e2e0a0a57652077616e7420746f2074656c6c20796f7520746861742077652077696c6c20736f6f6e206c61756e6368206f7572202452415920746f6b656e2e204a6f696e206f75722074656c656772616d206f72207477697474657220666f72206d6f726520696e666f726d6174696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/reay_2_034d91a526.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

