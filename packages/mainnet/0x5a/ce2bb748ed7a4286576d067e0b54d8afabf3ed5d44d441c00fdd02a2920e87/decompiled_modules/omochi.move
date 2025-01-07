module 0x5ace2bb748ed7a4286576d067e0b54d8afabf3ed5d44d441c00fdd02a2920e87::omochi {
    struct OMOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMOCHI>(arg0, 6, b"OMOCHI", b"FDGADSFADF", x"57616974696e6720666f72206120646970206f6e20746869732054696b746f6b2066726f67206f6d6f6368690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20240926145140_9eb551ffbb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMOCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMOCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

