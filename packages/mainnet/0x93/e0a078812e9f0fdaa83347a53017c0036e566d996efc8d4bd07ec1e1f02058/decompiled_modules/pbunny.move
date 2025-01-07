module 0x93e0a078812e9f0fdaa83347a53017c0036e566d996efc8d4bd07ec1e1f02058::pbunny {
    struct PBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBUNNY>(arg0, 6, b"PBUNNY", b"Pink Bunny", x"546865206d6f7374206d656d6561626c65206d656d65636f696e20696e0a6578697374656e63652e2054686520726162626974732068617665206861640a7468656972206461792c206974732074696d6520666f722050696e6b0a42756e6e7920746f20726569676e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052540_0076858b9a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PBUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

