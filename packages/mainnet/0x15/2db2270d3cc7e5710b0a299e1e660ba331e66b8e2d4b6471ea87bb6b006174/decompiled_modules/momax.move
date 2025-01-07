module 0x152db2270d3cc7e5710b0a299e1e660ba331e66b8e2d4b6471ea87bb6b006174::momax {
    struct MOMAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMAX>(arg0, 6, b"MOMAX", b"MOGIUS MAXIMUS", x"4d6f67697573204d6178696d75732020200a0a54686520756c74696d61746520667573696f6e206f66204b656b697573204d6178696d757320646976696e65206175726120616e64204d4f472072656c656e746c657373206d6f6767696e6720656e657267792e2041206d656d6520626f726e20746f20646f6d696e6174652074696d656c696e657320616e6420617363656e6420746f207468652063727970746f207370616365732e2020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250107_214543_640_748c58d69d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOMAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

