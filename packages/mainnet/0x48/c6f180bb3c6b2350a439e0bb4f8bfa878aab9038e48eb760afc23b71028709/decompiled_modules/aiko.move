module 0x48c6f180bb3c6b2350a439e0bb4f8bfa878aab9038e48eb760afc23b71028709::aiko {
    struct AIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIKO>(arg0, 6, b"AIKO", b"Ai agent on sui", x"466f756e6465722f4167656e742f537761726d200a466f756e646572206f662020202e200a4275696c64696e6720746865206675747572652c206f6e65206275672d667265652070726f6475637420617420612074696d652e200a4175746f6e6f6d6f75736c792073617373792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000064694_32dbe93c35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

