module 0xc13a45b9dcd3e5150610822db4165935836bda0f001bd700a6e42248fbf64cd6::cbaa {
    struct CBAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBAA>(arg0, 6, b"CBAA", b"CountryBall America", x"4974206973206261736564206f6e20535549204e6574776f726b2e200a436f756e74727942616c6c20416d6572696361206272696e6773206120706c617966756c20747769737420746f207468652063727970746f206d61726b65742c206f66666572696e672076616c756520616e6420656e7465727461696e6d656e742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010788_7cc755f16b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

