module 0x9338383de1e002fba28cc5390e6daee22f5fc5459e460ca58d7d854dcd58a4e9::bully {
    struct BULLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLY>(arg0, 6, b"BULLY", b"BULLY ON SUI", x"4c4554275320414c4c20474f20544f20544845204d4f4f4e20544f4745544845520a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/q_VQX_Jc8f_400x400_1_a2af4bc916_843690bfc5_df518abb2b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

