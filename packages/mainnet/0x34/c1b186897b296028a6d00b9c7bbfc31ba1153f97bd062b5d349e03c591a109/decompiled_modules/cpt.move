module 0x34c1b186897b296028a6d00b9c7bbfc31ba1153f97bd062b5d349e03c591a109::cpt {
    struct CPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPT>(arg0, 6, b"CPT", b"Crypto Partisans", x"42534320646576206f6620416c70686141444120616e6420426574614144412e0a6c6f6f6b696e6720746f20736c6f77206d6f6f6e20612070726f6a65637420616e64206275696c642061207374726f6e672053756920636f6d6d756e6974792061726f756e642069742e200a57652077696c6c20636f6f6b20736c6f772c206a6f696e2074686520544720616e64206c65742773206275696c642061206e6577206d6f76656d656e742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_24_at_14_56_34_59cf756bb9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

