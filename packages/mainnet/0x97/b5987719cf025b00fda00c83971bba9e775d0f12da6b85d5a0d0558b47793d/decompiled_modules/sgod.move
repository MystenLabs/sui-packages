module 0x97b5987719cf025b00fda00c83971bba9e775d0f12da6b85d5a0d0558b47793d::sgod {
    struct SGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOD>(arg0, 6, b"SGOD", b"SUIGOD", x"54686520756c74696d617465206d656d6520636f696e20626c657373696e67207468652053756920626c6f636b636861696e207769746820646976696e6520766962657320616e6420756e73746f707061626c6520656e657267792e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000358596_cc4aaf732f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

