module 0x6aa619e2cace43ad74e3b2ae78823a31d74bff95cf0e4f44e035a204e436d68::owl {
    struct OWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWL>(arg0, 6, b"OWL", b"Owl on Sui", b"The high-flying blue wise owl of the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000086535_64514416fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

