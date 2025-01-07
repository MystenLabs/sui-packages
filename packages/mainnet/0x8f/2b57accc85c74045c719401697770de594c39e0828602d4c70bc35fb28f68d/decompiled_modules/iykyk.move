module 0x8f2b57accc85c74045c719401697770de594c39e0828602d4c70bc35fb28f68d::iykyk {
    struct IYKYK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IYKYK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IYKYK>(arg0, 6, b"IYKYK", b"If You Know You Know", x"49594b594b20436f696e3a20466f722054686f73652057686f204765742049740a0a536f20696620796f75206b6e6f772c20796f75206b6e6f772e20416e6420696620796f7520646f6e742c206974732074696d6520746f2067657420776974682069742e202349594b594b20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/9eacc9f516f2e6a4ce3b227360116ca3_770b29e81c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IYKYK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IYKYK>>(v1);
    }

    // decompiled from Move bytecode v6
}

