module 0x1c83e9c6812cff387a67ff8e45635b69d15590cd7d41994ed3b0b41a62ba2ef5::dorae {
    struct DORAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORAE>(arg0, 6, b"DORAE", b"Doraemon", x"4920616d20446f7261656d6f6e2c0a4120726f626f746963206361742066726f6d207468652032326e642063656e747572792e0a4920686176652061206d61676963616c20666f75722d64696d656e73696f6e616c20706f636b65742066696c6c6564207769746820616c6c20736f727473206f66206675747572697374696320676164676574732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9705_57b4a2d0d2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

