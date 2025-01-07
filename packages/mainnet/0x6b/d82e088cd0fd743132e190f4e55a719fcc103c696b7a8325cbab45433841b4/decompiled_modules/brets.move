module 0x6bd82e088cd0fd743132e190f4e55a719fcc103c696b7a8325cbab45433841b4::brets {
    struct BRETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETS>(arg0, 6, b"BRETS", b"Brett Sui", b"PEPE'S best friend on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_b3b425d94c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETS>>(v1);
    }

    // decompiled from Move bytecode v6
}

