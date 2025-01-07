module 0xe52185736bf6763f843e6b48eba97025d06caecf9211851effa31fbc02a2ab3d::magnus {
    struct MAGNUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGNUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGNUS>(arg0, 6, b"Magnus", b"The Therapy Dog", b"Inspired by a therapy dog named Magnus, who has 1.2 million followers on Instagram and Tiktok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_IN_Sr_TB_8_400x400_00edf47246.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGNUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGNUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

