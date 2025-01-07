module 0x140910623c08af67d842f6e96d60df19947f444531adadac704dc9bfa6b44c74::cba {
    struct CBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBA>(arg0, 6, b"CBA", b"CountryBall America", x"4974206973206261736564206f6e20535549204e6574776f726b2e200a436f756e74727942616c6c20416d6572696361206272696e6773206120706c617966756c20747769737420746f207468652063727970746f206d61726b65742c206f66666572696e672076616c756520616e6420656e7465727461696e6d656e742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_7f221a8d0e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

