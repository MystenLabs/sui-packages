module 0x2e2d1daf82ccfc0f03e29ac22f16e656261c1cc2490903310db18418544758c7::larry {
    struct LARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LARRY>(arg0, 6, b"LARRY", b"Larry the sui bear", x"5768656e206d61726b65742073656e74696d656e742069730a626561726973682074686520626561727320636f6d65206f7574206f660a7468656972206361766520616e642074616b652066756c6c20636f6e74726f6c0a6f6620746865206d61726b6574", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sans_titre_4_f4d8ca562d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LARRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LARRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

