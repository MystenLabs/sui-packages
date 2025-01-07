module 0x52d95ad242c43b052f485a419eb92504644be45fbf6789facf9c50c782921b8c::soap {
    struct SOAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOAP>(arg0, 6, b"SOAP", b"Dont Drop The Soap!", b"$SOAP Dont Drop The Soap!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/portal_3af57b5788.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

